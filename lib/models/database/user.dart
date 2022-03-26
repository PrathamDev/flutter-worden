import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  String id;
  List<String> bookmarks;

  User({this.id = "", required this.bookmarks});

  static fromMap(Map<String, dynamic> map, String id) {
    return User(id: id, bookmarks: List.from(map['bookmarks']));
  }

  toMap() {
    return {
      "bookmarks": bookmarks,
    };
  }

  static Stream<DocumentSnapshot<User>> getCurrentUserStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .withConverter<User>(fromFirestore: (snapshot, options) {
      return User.fromMap(snapshot.data()!, snapshot.id);
    }, toFirestore: (user, options) {
      return user.toMap();
    }).snapshots();
  }

  Future<void> updateBookmarks(List<String> bookmarks) async {
    await FirebaseFirestore.instance.collection('users').doc(id).set({
      'bookmarks': bookmarks,
    });
  }
}
