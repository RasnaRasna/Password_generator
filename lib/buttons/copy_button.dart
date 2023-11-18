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
            SnackBar(
              backgroundColor: Colors.grey,
              content: Text('Password copied to clipboard'),
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
            ),
          );
        },
        child: const Icon(Icons.copy));
  }
}
