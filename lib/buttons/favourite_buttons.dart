import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> toggleFavoriteStatus(String documentId, bool isFavorite) async {
  try {
    CollectionReference favPasswordsCollection =
        FirebaseFirestore.instance.collection("favouritePassword");

    if (isFavorite) {
      // Add to favorites
      await favPasswordsCollection.add({
        'passwordId': documentId,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } else {
      // Remove from favorites
      await favPasswordsCollection
          .where('passwordId', isEqualTo: documentId)
          .get()
          .then((snapshot) {
        for (QueryDocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
    }
  } catch (e) {
    print('Error toggling favorite status: $e');
  }
}
