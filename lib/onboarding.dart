import 'package:flutter/material.dart';

import 'homepage.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(110.0), // here the desired height

          child: AppBar(
            flexibleSpace: Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0), // Adjust padding as needed
                  child: const Text(
                    "Generate Password\n      as you wish",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
              ),
            ),

            // toolbarHeight: 100.0, // Adjust the total height of the AppBar
          )),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  height: 300.0,
                  width: 300.0,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("lib/animation_lmhbfyet_small (3).gif"),
                    fit: BoxFit.fill,
                  ))),
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 97, 30, 9),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => const MyHomePage()));
                },
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
