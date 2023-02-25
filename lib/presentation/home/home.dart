import 'package:flutter/material.dart';
import 'package:improsso/presentation/home/widgets/TestPlot.dart';
import 'package:improsso/presentation/home/widgets/progress_bar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: const [
              Text("HomePage -> erstmal nur Logik"),
              ProgressBar(),
              SizedBox(height: 20),
              TestPlot(),
            ],
          ),
        ),
      ),
    );
  }
}
