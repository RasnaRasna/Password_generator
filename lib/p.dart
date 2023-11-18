// // // // import 'dart:math';

// // // import 'package:flutter/material.dart';
// // // import 'package:flutter/services.dart';
// // // import 'package:password_generator/homepage.dart';
// // // import 'package:syncfusion_flutter_sliders/sliders.dart';

// // // import 'check_box.dart';

// // // class PasswordGenerating extends StatefulWidget {
// // //   const PasswordGenerating({super.key});

// // //   @override
// // //   State<PasswordGenerating> createState() => _PasswordGeneratingState();
// // // }

// // // class _PasswordGeneratingState extends State<PasswordGenerating> {
// // //   bool isCheckedNumbers = false;
// // //   bool isCheckedLowercase = false;
// // //   bool isCheckedUppercase = false;
// // //   bool isCheckedSpecialCharacters = false;
// // //   double selectedNumber = 0;
// // //   String generatedPassword = '';
// // //   String lengthError = ''; // Added variable to hold the length error message
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: Center(
// // //         child: Padding(
// // //           padding: EdgeInsets.all(8.0),
// // //           child: ListView(
// // //             children: [
// // //               Column(
// // //                 children: [
// // //                   Padding(
// // //                     padding: const EdgeInsets.symmetric(horizontal: 20),
// // //                     child: Container(
// // //                         decoration: BoxDecoration(
// // //                             border: Border.all(
// // //                                 color: Color.fromARGB(255, 97, 30, 9)),
// // //                             borderRadius: BorderRadius.circular(15)),
// // //                         child: Padding(
// // //                           padding: EdgeInsets.all(8.0),
// // //                           child: TextFormField(
// // //                               readOnly: true,
// // //                               controller: passwordController,
// // //                               decoration: InputDecoration(
// // //                                 border: InputBorder.none,
// // //                                 suffixIcon: GestureDetector(
// // //                                     onTap: () {
// // //                                       Clipboard.setData(ClipboardData(
// // //                                           text: passwordController.text));
// // //                                       ScaffoldMessenger.of(context)
// // //                                           .showSnackBar(
// // //                                         const SnackBar(
// // //                                           backgroundColor: Colors.green,
// // //                                           content: Text(
// // //                                               'Password copied to clipboard'),
// // //                                           duration: Duration(seconds: 3),
// // //                                         ),
// // //                                       );
// // //                                     },
// // //                                     child: const Icon(Icons.copy)),
// // //                               )),
// // //                         )),
// // //                   ),
// // //                   const SizedBox(
// // //                     width: 10,
// // //                     height: 30,
// // //                   ),
// // //                   SfSlider(
// // //                     max: 30.0,
// // //                     value: selectedNumber,
// // //                     showTicks: true,
// // //                     onChanged: (value) {
// // //                       setState(() {
// // //                         selectedNumber = value;
// // //                       });
// // //                     },
// // //                   ),
// // //                   Text(
// // //                     "Password Length: ${selectedNumber.toInt()}",
// // //                     style: const TextStyle(
// // //                         fontSize: 18, fontWeight: FontWeight.bold),
// // //                   ),
// // //                   SizedBox(
// // //                     height: 5,
// // //                   ),
// // //                   buildCheckboxRow("Numbers", isCheckedNumbers, (newValue) {
// // //                     setState(() {
// // //                       isCheckedNumbers = newValue ?? false;
// // //                     });
// // //                   }),
// // //                   buildCheckboxRow("Lowercase Letters", isCheckedLowercase,
// // //                       (newValue) {
// // //                     setState(() {
// // //                       isCheckedLowercase = newValue ?? false;
// // //                     });
// // //                   }),
// // //                   buildCheckboxRow("Uppercase Letters", isCheckedUppercase,
// // //                       (newValue) {
// // //                     setState(() {
// // //                       isCheckedUppercase = newValue ?? false;
// // //                     });
// // //                   }),
// // //                   buildCheckboxRow(
// // //                       "Special Characters", isCheckedSpecialCharacters,
// // //                       (newValue) {
// // //                     setState(() {
// // //                       isCheckedSpecialCharacters = newValue ?? false;
// // //                     });
// // //                   }),
// // //                   const SizedBox(
// // //                     height: 30,
// // //                   ),
// // //                   GenerateButton(),
// // //                 ],
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   ClipRRect GenerateButton() {
// // //     return ClipRRect(
// // //       borderRadius: BorderRadius.circular(4),
// // //       child: Stack(
// // //         children: [
// // //           Positioned.fill(
// // //             child: Container(
// // //               decoration: const BoxDecoration(
// // //                 gradient: LinearGradient(
// // //                   colors: <Color>[
// // //                     Color.fromARGB(255, 47, 24, 18),
// // //                     Color.fromARGB(255, 97, 30, 9),
// // //                     Color.fromARGB(255, 47, 24, 18),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //           TextButton(
// // //             style: TextButton.styleFrom(
// // //               foregroundColor: Colors.white,
// // //               padding: const EdgeInsets.all(16.0),
// // //               textStyle: const TextStyle(fontSize: 20),
// // //             ),
// // //             onPressed: () {
// // //               generateAndSetPassword();
// // //             },
// // //             child: const Text('   Generate   '),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   void generateAndSetPassword() {
// // //     print('Generating password...');
// // //     print(
// // //         'generateAndSetPassword function called'); // Add this line for debugging
// // //     if (selectedNumber < 4) {
// // //       setState(() {
// // //         lengthError = 'Password length should be at least 4';
// // //         generatedPassword = '';
// // //       });

// // //       // Show the length error message
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(
// // //           backgroundColor: Colors.red,
// // //           content: Text(lengthError),
// // //           duration: Duration(seconds: 3),
// // //         ),
// // //       );
// // //     } else {
// // //       // Reset the length error message
// // //       setState(() {
// // //         lengthError = '';
// // //       });

// // //       // Define character sets
// // //       String lowerLetters =
// // //           isCheckedLowercase ? 'abcdefghijklmnopqrstuvwxyz' : '';
// // //       String upperLetters =
// // //           isCheckedUppercase ? 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' : '';
// // //       String num = isCheckedNumbers ? '0123456789' : '';
// // //       String specialChars =
// // //           isCheckedSpecialCharacters ? '!@#*()_-=+{}]|:?;/>.,<' : '';

// // //       String allChars = lowerLetters + upperLetters + num + specialChars;

// // //       // Check if at least one option is selected
// // //       if (allChars.isNotEmpty) {
// // //         final random = Random();
// // //         String password = '';

// // //         // Generate the password with the selected length
// // //         for (int i = 0; i < selectedNumber.toInt(); i++) {
// // //           password += allChars[random.nextInt(allChars.length)];
// // //         }
// // //         print(
// // //             'Generated password: $password'); // Debug print generated password

// // //         setState(() {
// // //           generatedPassword = password;
// // //           passwordController.text = generatedPassword; // Update the text field
// // //         });
// // //         print(
// // //             'Generated password: $generatedPassword'); // Debug print generated password
// // //       } else {
// // //         print('No options selected');

// // //         // Show a message if no options are selected
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(
// // //             backgroundColor: Colors.red,
// // //             content: Text('Please choose at least one option'),
// // //             duration: Duration(seconds: 3),
// // //           ),
// // //         );
// // //       }
// // //     }
// // //   }
// // // }



// // IconButton(
// //             onPressed: () async {
// //               // Get a reference to the 'favouritePassword' collection
// //               CollectionReference favouritePasswordsCollection =
// //                   FirebaseFirestore.instance.collection("favouritePassword");

// //               // Get all documents in the 'favouritePassword' collection
// //               QuerySnapshot snapshot = await favouritePasswordsCollection.get();

// //               showDialog(
// //                 context: context,
// //                 builder: (context) => AlertDialog(
// //                   title: snapshot.docs.isEmpty
// //                       ? const Text("No Favorite Passwords")
// //                       : Text("Delete All Passwords?"),
// //                   content: snapshot.docs.isEmpty
// //                       ? Text("There are no favorite passwords to delete.")
// //                       : null,
// //                   actions: [
// //                     if (snapshot.docs.isNotEmpty)
// //                       SizedBox(
// //                         width: 130,
// //                         child: Row(
// //                           children: [
// //                             TextButton(
// //                               onPressed: () {
// //                                 Navigator.pop(context);
// //                               },
// //                               child: Text("No"),
// //                             ),
// //                             TextButton(
// //                               onPressed: () async {
// //                                 // Close the dialog
// //                                 Navigator.pop(context);
// //                               },
// //                               child: Text("Yes"),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     if (snapshot.docs.isEmpty)
// //                       TextButton(
// //                         onPressed: () {
// //                           Navigator.pop(context);
// //                         },
// //                         child: Text("OK"),
// //                       ),
// //                   ],
// //                 ),
// //               );
// //             },
// //             icon: Icon(Icons.delete, color: GreenColor),
// //           ),



// // ...

// class FavoritePassword extends StatefulWidget {
//   const FavoritePassword({super.key});

//   @override
//   _FavoritePasswordState createState() => _FavoritePasswordState();
// }

// class _FavoritePasswordState extends State<FavoritePassword> {
//   // Map to store the favorite status for each password
//   Map<String, bool> favoriteStatus = {};

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // ... (existing code)
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('favouritePassword')
//             .snapshots(),
//         builder: (context, snapshot) {
//           // ... (existing code)
//           return ListView.separated(
//             separatorBuilder: (context, index) => SizedBox(height: 10),
//             itemCount: documents.length,
//             itemBuilder: (context, index) {
//               var favouritePassword =
//                   documents[index].data() as Map<String, dynamic>;
//               // Check if 'timestamp' field is not null
//               DateTime timestamp = favouritePassword['timestamp'] != null
//                   ? favouritePassword['timestamp'].toDate()
//                   : DateTime.now();

//               // Get the password document ID
//               String passwordDocId = documents[index].id;

//               // Set the initial favorite status to true
//               favoriteStatus.putIfAbsent(passwordDocId, () => true);

//               return Container(
//                 // ... (existing code)
//                 child: ListTile(
//                   trailing: SizedBox(
//                     width: 60,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         InkWell(
//                           onTap: () async {
//                             // Toggle the favorite status
//                             bool isCurrentlyFavorite =
//                                 favoriteStatus[passwordDocId] ?? true;
//                             setState(() {
//                               favoriteStatus[passwordDocId] =
//                                   !isCurrentlyFavorite;
//                             });

//                             // Perform the action based on the new favorite status
//                             if (isCurrentlyFavorite) {
//                               // Remove from favorites
//                               await deleteFavPassword(passwordDocId);
//                             }
//                           },
//                           child: Icon(
//                             favoriteStatus[passwordDocId] ?? true
//                                 ? Icons.favorite
//                                 : Icons.favorite_border,
//                             color: favoriteStatus[passwordDocId] ?? true
//                                 ? Colors.red
//                                 : Colors.black,
//                           ),
//                         ),
//                         CopyButton(),
//                       ],
//                     ),
//                   ),
//                   title: Text(
//                     favouritePassword['password'],
//                     style: TextStyle(
//                         color: GreenColor, fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text(
//                     _formatTime(timestamp),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   // Function to delete a specific password
//   Future<void> deleteFavPassword(String passwordDocId) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('favouritePassword')
//           .doc(passwordDocId)
//           .delete();
//     } catch (e) {
//       print('Error deleting password: $e');
//       // Handle the error as needed
//     }
//   }

//   // ... (existing code)
// }
