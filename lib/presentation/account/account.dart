import 'package:flutter/material.dart';
import 'package:improsso/presentation/account/buttons/add_profile_picture_button.dart';
import 'package:improsso/presentation/account/buttons/delete_account_button.dart';
import 'package:improsso/presentation/account/buttons/delete_profile_picture.dart';
import 'package:improsso/presentation/account/buttons/log_out_button.dart';
import 'package:improsso/presentation/account/widgets/test_for_observer_bloc.dart';
import 'package:improsso/presentation/account/widgets/test_for_pictures_bloc.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle _style = Theme.of(context)
        .textTheme
        .headline2!
        .copyWith(fontSize: 20, color: Theme.of(context).colorScheme.onPrimary);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          const Text("AccountPage"),
          const LogOutButton(),
          DeleteAccountButton(style: _style),
          const AddProfilePictureButton(),
          const TestForObserverBloc(),
          const TestForPicturesBloc(),
          const DeleteProfilePicture(),
        ]),
      ),
    );
  }
}
