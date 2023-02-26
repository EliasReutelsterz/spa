import 'package:flutter/material.dart';
import 'package:improsso/presentation/home/widgets/fields_pie_chart.dart';
import 'package:improsso/presentation/home/widgets/main_plot.dart';
import 'package:improsso/presentation/home/widgets/progress_bar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: const [
              ProgressBar(),
              SizedBox(height: 40),
              MainPlot(),
              FieldsPieChart(),
            ],
          ),
        ),
      ),
    );
  }
}
