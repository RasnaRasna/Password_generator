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
                  trailing: CopyButton(),
                  subtitle: Text(
                    savedPassword["accountName"] ?? "",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: GreenColor),
                  ),
                  title: Text(
                    savedPassword['password'],
                    style: TextStyle(
                        color: GreenColor, fontWeight: FontWeight.bold),
                  ),
                  leading: Text(
                    _formatDate(timestamp),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: GreenColor),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(DateTime time) {
    // Format the time as a date (e.g., 2023-11-18)
    String formattedDate = DateFormat('dd-MM-yyyy').format(time);
    return formattedDate;
  }
}
