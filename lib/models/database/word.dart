import 'package:cloud_firestore/cloud_firestore.dart';

class Word {
  String value;

  Word(this.value) {
    value = value.toLowerCase();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> firebaseSnapshot() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("definitions")
        .doc(value)
        .get();
    return snapshot;
  }

  Future addDefinitionInFirebase(Map<String, dynamic> map) async {
    await FirebaseFirestore.instance
        .collection("definitions")
        .doc(value)
        .set(map);
  }
}
