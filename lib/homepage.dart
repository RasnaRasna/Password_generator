import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'check_box.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isCheckedNumbers = false;
  bool isCheckedLowercase = false;
  bool isCheckedUppercase = false;
  bool isCheckedSpecialCharacters = false;
  double selectedNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
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
                                color: Color.fromARGB(255, 143, 35, 190)),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              decoration:
                                  InputDecoration(border: InputBorder.none)),
                        )),
                  ),
                  SizedBox(
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
                    style: const TextStyle(fontSize: 18),
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
                  SizedBox(
                    height: 30,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color.fromARGB(255, 160, 54, 196),
                                  Color(0xFF1976D2),
                                  Color.fromARGB(255, 167, 66, 245),
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
                          onPressed: () {},
                          child: const Text('   Generate   '),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
