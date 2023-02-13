import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/user/controller_bloc/controller_bloc.dart';
import 'package:improsso/application/user/observer_bloc/observer_bloc.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormFieldState> formFieldKey = GlobalKey<FormFieldState>();
    return BlocBuilder<ObserverBloc, ObserverState>(
      builder: (context, observerState) {
        if (observerState is ObserverSuccess) {
          return TextFormField(
            key: formFieldKey,
            autocorrect: false,
            readOnly: false,
            initialValue: observerState.userEntity.username,
            onFieldSubmitted: (String? insertedValue) {
              if (insertedValue != null) {
                BlocProvider.of<ControllerBloc>(context).add(
                    UpdateUsernameEvent(
                        context: context, input: insertedValue));
              }
            },
            decoration: const InputDecoration(labelText: "Username"),
          );
        } else {
          return const Placeholder();
        }
      },
    );
  }
}
