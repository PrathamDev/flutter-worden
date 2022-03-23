import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Word {
  String value;

  Word(this.value) {
    value = value.toLowerCase();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> firebaseSnapshot() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("words").doc(value).get();
    return snapshot;
  }

  Future addInFirebase(Map<String, dynamic> map) async {
    await FirebaseFirestore.instance.collection("words").doc(value).set(map);
  }
}
