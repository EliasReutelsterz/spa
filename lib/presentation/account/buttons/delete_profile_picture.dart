import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/user/pictures_bloc/bloc/pictures_bloc.dart';

class DeleteProfilePicture extends StatelessWidget {
  const DeleteProfilePicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PicturesBloc, PicturesState>(
      builder: (context, picturesState) {
        if (picturesState is PicturesSuccess) {
          return IconButton(
              onPressed: (() {
                BlocProvider.of<PicturesBloc>(context)
                    .add(DeleteProfilePictureEvent(context: context));
              }),
              icon: const Icon(Icons.delete_outline));
        } else {
          return IconButton(
              onPressed: (() {}), icon: const Icon(Icons.delete_outline));
        }
      },
    );
  }
}
