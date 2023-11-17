import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavouriteButton extends StatefulWidget {
  const FavouriteButton({super.key});

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isFavorite = !isFavorite;
          if (isFavorite) {
            // Add your logic for adding to favorites here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.grey,
                content: Text('Added to favorites',
                    style: TextStyle(color: Colors.white)),
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
            );
          }
        });
      },
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
      ),
    );
  }
}
