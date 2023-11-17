import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../homepage.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Clipboard.setData(ClipboardData(text: passwordController.text));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text('Password copied to clipboard'),
              duration: Duration(seconds: 3),
            ),
          );
        },
        child: const Icon(Icons.copy));
  }
}
