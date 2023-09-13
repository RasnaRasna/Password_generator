// import 'package:flutter/material.dart';

// class PasswordDisplayWidget extends StatefulWidget {
//   final String password;

//   const PasswordDisplayWidget({Key? key, required this.password})
//       : super(key: key);

//   @override
//   _PasswordDisplayWidgetState createState() => _PasswordDisplayWidgetState();
// }

// class _PasswordDisplayWidgetState extends State<PasswordDisplayWidget> {
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _passwordController.text = widget.password;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: _passwordController,
//       readOnly: true,
//       decoration: InputDecoration(
//         border: InputBorder.none,
//         suffixIcon: GestureDetector(
//           onTap: () {
//             // Implement copy to clipboard here
//           },
//           child: const Icon(Icons.copy),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _passwordController.dispose();
//     super.dispose();
//   }
// }
