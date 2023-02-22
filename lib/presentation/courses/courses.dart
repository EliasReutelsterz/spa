import 'package:flutter/material.dart';
import 'package:improsso/presentation/courses/buttons/add_course_button.dart';
import 'package:improsso/presentation/courses/buttons/delete_course_button.dart';
import 'package:improsso/presentation/courses/widgets/current_studies.dart';
import 'package:improsso/presentation/courses/widgets/table_completed_courses.dart';

class Courses extends StatelessWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CurrentStudies(),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                AddCourseButton(),
                SizedBox(width: 40),
                DeleteCourseButton(),
              ]),
              const SizedBox(height: 20),
              const TableCompletedCourses(),
            ],
          ),
        ),
      ),
    );
  }
}
