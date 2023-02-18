import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:improsso/presentation/home/buttons/add_course_button.dart';
import 'package:improsso/presentation/home/widgets/current_studies.dart';

import 'widgets/test_for_completed_courses.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Text("HomePage -> erstmal nur Logik"),
            TextButton(
                onPressed: () {}, child: const Text("Currently nothing")),
            const CurrentStudies(),
            const AddCourseButton(),
            TestForCompletedCourses(),
          ],
        ),
      ),
    );
  }
}
