import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserUsecases {
  void pickAndUploadImage() async {
    final ImagePicker _picker = ImagePicker();
    await _picker
        .pickImage(source: ImageSource.gallery, imageQuality: 1)
        .then((pickedFile) async {
      if (pickedFile != null) {
        File photo = File(pickedFile.path);
        User user = FirebaseAuth.instance.currentUser!;
        final storageRef = FirebaseStorage.instance.ref();
        final folderRef =
            storageRef.child('/images/${user.uid}/profile_picture');
        folderRef.putFile(photo);
      }
    });
  }
}
