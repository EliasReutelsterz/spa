import 'package:flutter/material.dart';
import 'package:improsso/presentation/courses/buttons/add_course_button.dart';
import 'package:improsso/presentation/courses/widgets/current_studies.dart';
import 'package:improsso/presentation/courses/widgets/test_for_completed_courses.dart';

class Courses extends StatelessWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Text("Courses -> erstmal nur Logik"),
            TextButton(
                onPressed: () {}, child: const Text("Currently nothing")),
            const CurrentStudies(),
            const AddCourseButton(),
            const TestForCompletedCourses(),
          ],
        ),
      ),
    );
  }
}
