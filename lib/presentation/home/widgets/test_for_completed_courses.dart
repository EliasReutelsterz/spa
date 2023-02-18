import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/user/completedCourses_bloc/completed_courses_bloc.dart';

class TestForCompletedCourses extends StatelessWidget {
  const TestForCompletedCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompletedCoursesBloc, CompletedCoursesState>(
      builder: (context, completedCoursesState) {
        if (completedCoursesState is CompletedCoursesSuccess) {
          List<Widget> list = [];
          for (String course in completedCoursesState.courses.keys) {
            list.add(Text(completedCoursesState.courses[course]!.name));
          }
          return Column(
            children: list,
          );
        } else {
          return Placeholder();
        }
      },
    );
  }
}
