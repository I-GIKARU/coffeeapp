import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/models/brew.dart';

class DatabaseService {
  final String uid;
  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection('users');

  DatabaseService({required this.uid});

  Future<void> updateUserData(String sugars, String name, int strength) async {
    return await userCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // Add this method to reload data
  void reloadData() {
    // This method will trigger a reload of data by notifying listeners
  }

  Stream<List<Brew>> get brews {
    return userCollection.snapshots().map(_brewListFromSnapshot);
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc['name'] ?? '',
        strength: doc['strength'] ?? 0,
        sugars: doc['sugars'] ?? '0',
      );
    }).toList();
  }
}
