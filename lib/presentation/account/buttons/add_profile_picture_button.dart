import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddProfilePictureButton extends StatelessWidget {
  const AddProfilePictureButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            /*
            User user = FirebaseAuth.instance.currentUser!;
            final storageRef = FirebaseStorage.instance.ref();
            final folderRef =
                storageRef.child('/images/${user.uid}/profile_picture.jpg');
            //Hier fehlt der ImagePicker!!
            folderRef.putFile(file);
            */
          },
          child: const Text("Add profile picture"),
        ),
      ],
    );
  }
}
