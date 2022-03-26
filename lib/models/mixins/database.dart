import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

mixin DatabaseMixin {
  Future updateImage() async {
    //Picking Image
    ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      //Uploading Image
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref =
          storage.ref().child("/${FirebaseAuth.instance.currentUser!.uid}");
      UploadTask task = ref.putFile(File(image.path));
      TaskSnapshot snapshot = await task;
      String url = await snapshot.ref.getDownloadURL();
      //Uploading new photo url to firebase
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
    }
  }
}
