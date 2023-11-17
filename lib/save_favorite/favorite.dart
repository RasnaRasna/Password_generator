import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:password_generator/const/const.dart';

import '../buttons/copy_button.dart';
import '../buttons/favourite_buttons.dart';

class FavoritePassword extends StatelessWidget {
  const FavoritePassword({super.key});

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
        actions: [
          IconButton(
              onPressed: () {
                deleteAllFavPasswords(context);
              },
              icon: Icon(Icons.delete))
        ],
        title: Text(
          "Favourite Password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('favouritePassword')
            .snapshots(),
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
                'No  Favourite passwords .',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 10),
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
                  trailing: SizedBox(
                    width: 60, // Set a specific width for the SizedBox
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FavouriteButton(),
                        CopyButton(),
                      ],
                    ),
                  ),
                  title: Text(
                    favouritePassword['password'],
                    style: TextStyle(
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
    );
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
              content: Text(
                "There are no favorite passwords to delete.",
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
              title: Text("Delete All Passwords?"),
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
                        child: Text("No"),
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
                        child: Text("Yes"),
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

  String _formatTime(DateTime time) {
    // Format the time as per your requirement
    String formattedTime = DateFormat.jm().format(time);
    return formattedTime; // ${time.day}/${time.month}/${time.year}";
  }
}
