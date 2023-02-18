import 'package:flutter/material.dart';
import 'package:improsso/presentation/account/buttons/delete_account_button.dart';
import 'package:improsso/presentation/account/buttons/log_out_button.dart';
import 'package:improsso/presentation/account/widgets/profile_form.dart';
import 'package:improsso/presentation/account/widgets/profile_picture_widget.dart';
import 'package:improsso/presentation/account/widgets/programs_dropdown.dart';
import 'package:improsso/presentation/account/widgets/unis_dropdown.dart';

class Account extends StatelessWidget {
  Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          const SizedBox(height: 20),
          const ProfilePictureWidget(),
          const SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: const [
                  ProfileForm(),
                  SizedBox(height: 10),
                  UnisDropdown(),
                  SizedBox(height: 10),
                  ProgramsDropdown(),
                ],
              )),
          const SizedBox(height: 60),
          SizedBox(
            width: 250,
            child: Column(
              children: const [
                LogOutButton(),
                SizedBox(height: 10),
                DeleteAccountButton(),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
