import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'root.dart';
import 'theme.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(const Impresso());
}

class Impresso extends StatelessWidget {
  const Impresso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const RootWidget(),
    );
  }
}
