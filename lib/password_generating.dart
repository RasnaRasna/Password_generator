import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:password_generator/buttons/copy_button.dart';
import 'package:password_generator/const/const.dart';
import 'package:password_generator/homepage.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'check_box.dart';

class PasswordGenerating extends StatefulWidget {
  const PasswordGenerating({super.key});

  @override
  State<PasswordGenerating> createState() => _PasswordGeneratingState();
}

class _PasswordGeneratingState extends State<PasswordGenerating> {
  bool isCheckedNumbers = false;
  bool isCheckedLowercase = false;
  bool isCheckedUppercase = false;
  bool isCheckedSpecialCharacters = false;
  double selectedNumber = 0;
  String generatedPassword = '';
  String previousGeneratedPassword = ''; // Add this variable

  String lengthError = '';
  bool isFavorite = false;
  TextEditingController accountNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_circle_left_sharp,
            color: GreenColor,
          ),
        ),
        title: const Text(
          "Generate Password",
          style: TextStyle(fontWeight: FontWeight.bold, color: GreenColor),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              GeneratingPassword(context),
            ],
          ),
        ),
      ),
    );
  }

  Column GeneratingPassword(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Character Type",
          style: TextStyle(fontWeight: FontWeight.bold, color: GreenColor),
        ),
        const SizedBox(
          height: 5,
        ),
        buildCheckboxRow("123", "Numbers", isCheckedNumbers, (newValue) {
          setState(() {
            isCheckedNumbers = newValue ?? false;
          });
        }),
        buildCheckboxRow("ab", "Lowercase Letters", isCheckedLowercase,
            (newValue) {
          setState(() {
            isCheckedLowercase = newValue ?? false;
          });
        }),
        buildCheckboxRow("AB", "Uppercase Letters", isCheckedUppercase,
            (newValue) {
          setState(() {
            isCheckedUppercase = newValue ?? false;
          });
        }),
        buildCheckboxRow("#*", "Special Characters", isCheckedSpecialCharacters,
            (newValue) {
          setState(() {
            isCheckedSpecialCharacters = newValue ?? false;
          });
        }),
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Password Length",
          style: TextStyle(color: GreenColor, fontWeight: FontWeight.bold),
        ),
        SfSlider(
          max: 30.0,
          value: selectedNumber,
          showTicks: true,
          onChanged: (value) {
            setState(() {
              selectedNumber = value;
            });
          },
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            "Password Length: ${selectedNumber.toInt()}",
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: GreenColor),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              generateAndSetPassword();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: GreenColor, borderRadius: BorderRadius.circular(10)),
              width: double.infinity,
              height: 60,
              child: const Center(
                  child: Text(
                " Generate Password",
                style: textStylee,
              )),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (generatedPassword.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      readOnly: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: SizedBox(
                            width: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    bool isPasswordInFavorites =
                                        await FavouritePasswortoFirestore(
                                            generatedPassword);

                                    // Update the isFavorite state based on whether the password is in favorites
                                    setState(() {
                                      isFavorite = isPasswordInFavorites;
                                    });
                                  },
                                  child: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        isFavorite ? Colors.red : Colors.black,
                                  ),
                                ),
                                CopyButton()
                              ],
                            ),
                          ))),
                )),
          ),
        const SizedBox(
          height: 20,
        ),
        if (generatedPassword.isNotEmpty)
          Center(
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          actions: [
                            SizedBox(
                              width: 150,
                              child: Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      savePasswordToFirestore(generatedPassword,
                                          accountNameController.text);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyHomePage(
                                                    password: generatedPassword,
                                                  )));
                                    },
                                    child: Text("Save"),
                                  )
                                ],
                              ),
                            )
                          ],
                          content: TextField(
                            controller: accountNameController,
                          ),
                          title: Text(
                            'Enter Password Account Name',
                            style: textStyleblack,
                          ),
                        ));
                // Pass the generated password data to the SavedPassword screen
              },
              child: Container(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(children: [
                    Icon(
                      Icons.save,
                      color: GreenColor,
                    ),
                    Text("   Saved\nPassword",
                        style: TextStyle(
                            color: GreenColor, fontWeight: FontWeight.bold)),
                  ]),
                ),
                height: 90,
                width: 130,
                decoration: BoxDecoration(
                    border: Border.all(color: GreenColor),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          )
      ],
    );
  }

  Future<bool> FavouritePasswortoFirestore(String password) async {
    try {
      // Check if the password already exists in favorites
      var existingFavorites = await FirebaseFirestore.instance
          .collection("favouritePassword")
          .where('password', isEqualTo: password)
          .get();

      if (existingFavorites.docs.isEmpty) {
        // Password does not exist in favorites, add it
        FirebaseFirestore.instance.collection("favouritePassword").add({
          'password': password,
          'timestamp': FieldValue.serverTimestamp(),
        });

        print("Added to favorites: $password");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.grey,
            content: Text('Added to favorites',
                style: TextStyle(color: Colors.white)),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
          ),
        );

        // Return true to indicate that the password is in favorites
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.grey,
            content: Text('Password already in favorites',
                style: TextStyle(color: Colors.white)),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
          ),
        );
        print("Password already in favorites");

        // Return false to indicate that the password is not in favorites
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error saving password'),
          duration: Duration(seconds: 3),
        ),
      );
      print('Error saving password: $e');

      // Return false in case of an error
      return false;
    }
  }

  Future<void> savePasswordToFirestore(
      String password, String accountName) async {
    try {
      FirebaseFirestore.instance.collection('savedPasswords').add({
        'password': password,
        'timestamp': FieldValue.serverTimestamp(),
        'accountName': accountName, // Add the account name
      });
      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Password saved successfully'),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error saving password'),
          duration: Duration(seconds: 3),
        ),
      );
      print('Error saving password: $e');
    }
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
          duration: const Duration(seconds: 3),
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
