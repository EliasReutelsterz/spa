import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/user/pictures/bloc/pictures_bloc.dart';

class TestForPicturesBloc extends StatelessWidget {
  const TestForPicturesBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PicturesBloc, PicturesState>(
      builder: (context, picturesState) {
        if (picturesState is PicturesSuccess) {
          return picturesState.picturesEntity.profilePicture;
        } else {
          return Placeholder();
        }
      },
    );
  }
}
