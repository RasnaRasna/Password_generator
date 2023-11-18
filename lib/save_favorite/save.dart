import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password_generator/buttons/copy_button.dart';
import 'package:password_generator/const/const.dart';
import 'package:intl/intl.dart';
import 'package:password_generator/homepage.dart';

import '../buttons/favourite_buttons.dart';

class SavedPassword extends StatefulWidget {
  final String password;

  const SavedPassword({super.key, required this.password});

  @override
  State<SavedPassword> createState() => _SavedPasswordState();
}

class _SavedPasswordState extends State<SavedPassword> {
  List<bool> isFavoriteList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_circle_left_sharp,
            color: GreenColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Saved Passwords",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              // Get a reference to the 'savedPasswords' collection
              CollectionReference savedPasswordsCollection =
                  FirebaseFirestore.instance.collection("savedPasswords");

              // Get all documents in the 'savedPasswords' collection
              QuerySnapshot snapshot = await savedPasswordsCollection.get();

              if (snapshot.docs.isEmpty) {
                // Show a dialog informing the user that there are no passwords to delete
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(
                      "There are no passwords to delete.",
                      style: textStyleblack,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("OK"),
                      ),
                    ],
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      "Are you want to delete all Password ?",
                      style: textStyleblack,
                    ),
                    actions: [
                      SizedBox(
                        width: 130,
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("No"),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Loop through each document and delete it
                                for (QueryDocumentSnapshot doc
                                    in snapshot.docs) {
                                  await doc.reference.delete();
                                }

                                // Close the dialog
                                Navigator.pop(context);
                              },
                              child: Text("Yes"),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('savedPasswords').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          List<DocumentSnapshot> documents = snapshot.data!.docs;
          if (documents.isEmpty) {
            return Center(
              child: Text(
                'No passwords saved.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
          // Initialize isFavoriteList if it's empty or not the same length as documents
          if (isFavoriteList.isEmpty ||
              isFavoriteList.length != documents.length) {
            isFavoriteList = List.generate(documents.length, (index) => false);
          }

          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var savedPassword =
                  documents[index].data() as Map<String, dynamic>;
              // Check if 'timestamp' field is not null
              DateTime timestamp = savedPassword['timestamp'] != null
                  ? savedPassword['timestamp'].toDate()
                  : DateTime.now();
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black12),
                ),
                child: ListTile(
                  trailing: SizedBox(
                    width: 60, // Set a specific width for the SizedBox
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            FavouritePasswortoFirestore(
                                passwordController.text);
                            // Toggle the favorite status for the specific password
                            setState(() {
                              isFavoriteList[index] = !isFavoriteList[index];
                            });
                            await toggleFavoriteStatus(
                              documents[index].id,
                              isFavoriteList[index],
                            );
                          },
                          child: Icon(
                            isFavoriteList[index]
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavoriteList[index]
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                        CopyButton(),
                      ],
                    ),
                  ),
                  subtitle: Text(savedPassword["accountName"] ?? ""),
                  title: Text(
                    savedPassword['password'],
                    style: TextStyle(
                        color: GreenColor, fontWeight: FontWeight.bold),
                  ),
                  leading: Text(
                    _formatTime(timestamp),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    // Format the time as per your requirement
    String formattedTime = DateFormat.jm().format(time);
    return formattedTime; // ${time.day}/${time.month}/${time.year}";
  }

  void removeFromFavorites(String documentId) {
    FirebaseFirestore.instance
        .collection('favouritePassword')
        .doc(documentId) // Use the document ID
        .delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey,
        content: Text('Removed from favorites',
            style: TextStyle(color: Colors.white)),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
      ),
    );

    // Optionally, you can show a SnackBar or perform any other actions after removal.
  }

  Future<void> FavouritePasswortoFirestore(String password) async {
    try {
      FirebaseFirestore.instance.collection("favouritePassword").add({
        'password': password,
        'timestamp': FieldValue.serverTimestamp(),
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
}
