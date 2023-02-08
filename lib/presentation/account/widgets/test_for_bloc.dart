import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/auth/observer_bloc/observer_bloc.dart';

class TestForBloc extends StatelessWidget {
  const TestForBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObserverBloc, ObserverState>(
      builder: (context, observerState) {
        if (observerState is ObserverSuccess) {
          return Text(observerState.userEntity.username);
        } else {
          return Placeholder();
        }
      },
    );
  }
}
