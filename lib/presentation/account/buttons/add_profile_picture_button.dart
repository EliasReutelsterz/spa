import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/user/pictures_bloc/bloc/pictures_bloc.dart';
import 'package:improsso/domain/user_domain/usecases/user_usecases.dart';

class AddProfilePictureButton extends StatelessWidget {
  const AddProfilePictureButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            BlocProvider.of<PicturesBloc>(context)
                .add(PickAndUploadPictureEvent(context: context));
          },
          child: const Text("Add profile picture"),
        ),
      ],
    );
  }
}
