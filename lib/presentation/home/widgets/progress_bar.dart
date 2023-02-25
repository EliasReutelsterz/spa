import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      valueColor:
          AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
      minHeight: 15,
      value: 0.5,
    );
  }
}
