import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

mixin AuthMixin {
  Future<User?> signIn(
      {required String email, required String password}) async {
    UserCredential credentials = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return credentials.user;
  }

  Future<User?> signUp(
      {required String username,
      required String email,
      required String password}) async {
    UserCredential credentials = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await credentials.user!.updateDisplayName(username);
    FirebaseFirestore.instance
        .collection('users')
        .doc(credentials.user!.uid)
        .set({
      "bookmarks": [],
    });
    return credentials.user;
  }
}
