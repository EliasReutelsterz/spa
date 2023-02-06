import 'dart:io';
import 'package:flutter/material.dart';
import 'package:improsso/domain/user_domain/usecases/user_usecases.dart';

class AddProfilePictureButton extends StatelessWidget {
  const AddProfilePictureButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            UserUsecases().pickAndUploadImage();
          },
          child: const Text("Add profile picture"),
        ),
      ],
    );
  }
}
