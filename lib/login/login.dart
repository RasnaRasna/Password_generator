import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end, // Align items at the bottom
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.0), // Adjust as needed
                child: Text(
                  'Login Page',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            TextField(
              style: TextStyle(fontSize: 16), // Set the font size
              decoration: InputDecoration(
                labelText: 'Email ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              style: TextStyle(fontSize: 16), // Set the font size
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add your login logic here
                // For simplicity, assume successful login for now
                // Navigate to the Home Page after successful login
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
