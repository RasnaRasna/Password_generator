import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:password_generator/const/const.dart';

import '../buttons/copy_button.dart';
import '../buttons/favourite_buttons.dart';

class FavoritePassword extends StatefulWidget {
  FavoritePassword({super.key});

  @override
  State<FavoritePassword> createState() => _FavoritePasswordState();
}

class _FavoritePasswordState extends State<FavoritePassword> {
  List<bool> isFavoriteList = [];
  // List to track favorite status for each password
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
        actions: [
          IconButton(
              onPressed: () {
                deleteAllFavPasswords(context);
              },
              icon: const Icon(Icons.delete))
        ],
        centerTitle: true,
        title: const Text(
          "Favourite Password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('favouritePassword')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            List<DocumentSnapshot> documents = snapshot.data!.docs;
            if (documents.isEmpty) {
              return const Center(
                child: Text(
                  'No  Favourite passwords .',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
            // Initialize isFavoriteList if it's empty or not the same length as documents
            if (isFavoriteList.isEmpty ||
                isFavoriteList.length != documents.length) {
              isFavoriteList = List.generate(documents.length, (index) => true);
            }

            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                var favouritePassword =
                    documents[index].data() as Map<String, dynamic>;
                // Check if 'timestamp' field is not null
                DateTime timestamp = favouritePassword['timestamp'] != null
                    ? favouritePassword['timestamp'].toDate()
                    : DateTime.now();

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: ListTile(
                    leading: Text(
                      _formatDate(timestamp),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: GreenColor),
                    ),
                    trailing: SizedBox(
                      width: 60, // Set a specific width for the SizedBox
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              // Toggle the favorite status for the specific password
                              setState(() {
                                isFavoriteList[index] = !isFavoriteList[index];
                              });
                              if (!isFavoriteList[index]) {
                                removeFromFavorites(
                                  documents[index].id, // Pass the document ID
                                );
                              }
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
                          const CopyButton(),
                        ],
                      ),
                    ),
                    title: Text(
                      favouritePassword['password'] ?? "No Password",
                      style: const TextStyle(
                          color: GreenColor, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      _formatTime(timestamp),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void removeFromFavorites(String documentId) {
    FirebaseFirestore.instance
        .collection('favouritePassword')
        .doc(documentId) // Use the document ID
        .delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey,
        content: const Text('Removed from favorites',
            style: TextStyle(color: Colors.white)),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
      ),
    );

    // Optionally, you can show a SnackBar or perform any other actions after removal.
  }

  // Function to delete all passwords
  void deleteAllFavPasswords(BuildContext context) {
    FirebaseFirestore.instance.collection('favouritePassword').get().then(
      (snapshot) {
        if (snapshot.docs.isEmpty) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(""),
              content: const Text(
                "There are no favorite passwords to delete.",
                style: textStyleblack,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Delete All Passwords?"),
              content: null,
              actions: [
                SizedBox(
                  width: 130,
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () async {
                          // Delete all passwords
                          for (DocumentSnapshot doc in snapshot.docs) {
                            doc.reference.delete();
                          }
                          // Close the dialog
                          Navigator.pop(context);
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  String _formatDate(DateTime time) {
    // Format the time as a date (e.g., 2023-11-18)
    String formattedDate = DateFormat('dd-MM-yyyy').format(time);
    return formattedDate;
  }

  String _formatTime(DateTime time) {
    // Format the time as per your requirement
    String formattedTime = DateFormat.jm().format(time);
    return formattedTime; // ${time.day}/${time.month}/${time.year}";
  }
}
