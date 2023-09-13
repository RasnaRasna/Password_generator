import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'check_box.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

TextEditingController passwordController = TextEditingController();

class _MyHomePageState extends State<MyHomePage> {
  bool isCheckedNumbers = false;
  bool isCheckedLowercase = false;
  bool isCheckedUppercase = false;
  bool isCheckedSpecialCharacters = false;
  double selectedNumber = 0;
  String generatedPassword = '';
  String lengthError = ''; // Added variable to hold the length error message

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Password Generator",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 97, 30, 9)),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(
                                          text: passwordController.text));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                              'Password copied to clipboard'),
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                    },
                                    child: const Icon(Icons.copy)),
                              )),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 30,
                  ),
                  SfSlider(
                    max: 20.0,
                    value: selectedNumber,
                    showTicks: true,
                    onChanged: (value) {
                      setState(() {
                        selectedNumber = value;
                      });
                    },
                  ),
                  Text(
                    "Password Length: ${selectedNumber.toInt()}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  buildCheckboxRow("Numbers", isCheckedNumbers, (newValue) {
                    setState(() {
                      isCheckedNumbers = newValue ?? false;
                    });
                  }),
                  buildCheckboxRow("Lowercase Letters", isCheckedLowercase,
                      (newValue) {
                    setState(() {
                      isCheckedLowercase = newValue ?? false;
                    });
                  }),
                  buildCheckboxRow("Uppercase Letters", isCheckedUppercase,
                      (newValue) {
                    setState(() {
                      isCheckedUppercase = newValue ?? false;
                    });
                  }),
                  buildCheckboxRow(
                      "Special Characters", isCheckedSpecialCharacters,
                      (newValue) {
                    setState(() {
                      isCheckedSpecialCharacters = newValue ?? false;
                    });
                  }),
                  const SizedBox(
                    height: 30,
                  ),
                  GenerateButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ClipRRect GenerateButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color.fromARGB(255, 47, 24, 18),
                    Color.fromARGB(255, 97, 30, 9),
                    Color.fromARGB(255, 47, 24, 18),
                  ],
                ),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16.0),
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              generateAndSetPassword();
            },
            child: const Text('   Generate   '),
          ),
        ],
      ),
    );
  }

  void generateAndSetPassword() {
    print('Generating password...');
    print(
        'generateAndSetPassword function called'); // Add this line for debugging
    if (selectedNumber < 4) {
      setState(() {
        lengthError = 'Password length should be at least 4';
        generatedPassword = '';
      });

      // Show the length error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(lengthError),
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      // Reset the length error message
      setState(() {
        lengthError = '';
      });

      // Define character sets
      String lowerLetters =
          isCheckedLowercase ? 'abcdefghijklmnopqrstuvwxyz' : '';
      String upperLetters =
          isCheckedUppercase ? 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' : '';
      String num = isCheckedNumbers ? '0123456789' : '';
      String specialChars =
          isCheckedSpecialCharacters ? '!@#*()_-=+{}]|:?;/>.,<' : '';

      String allChars = lowerLetters + upperLetters + num + specialChars;

      // Check if at least one option is selected
      if (allChars.isNotEmpty) {
        final random = Random();
        String password = '';

        // Generate the password with the selected length
        for (int i = 0; i < selectedNumber.toInt(); i++) {
          password += allChars[random.nextInt(allChars.length)];
        }
        print(
            'Generated password: $password'); // Debug print generated password

        setState(() {
          generatedPassword = password;
          passwordController.text = generatedPassword; // Update the text field
        });
        print(
            'Generated password: $generatedPassword'); // Debug print generated password
      } else {
        print('No options selected');

        // Show a message if no options are selected
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please choose at least one option'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
