import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
    );
    /*
    ClipRect(
      child: Align(
        alignment: Alignment.topCenter,
        heightFactor: 0.5,
        child: Image.network(userAvatarUrl),
      ),
    );
    */
  }
}
