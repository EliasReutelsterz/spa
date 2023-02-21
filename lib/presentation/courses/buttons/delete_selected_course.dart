import 'package:flutter/material.dart';
import 'package:improsso/application/user/controller_bloc/controller_bloc.dart';
import 'package:improsso/domain/general_domain/entities/completed_course_entitiy.dart';

class DeleteSelectedCourseButton extends StatelessWidget {
  final CompletedCourseEntity completedCourseEntity;
  final ControllerBloc controllerBloc;
  const DeleteSelectedCourseButton(
      {Key? key,
      required this.completedCourseEntity,
      required this.controllerBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (contextDialog) => AlertDialog(
                      title: Text(
                          "Do you really want to delete the course ${completedCourseEntity.name}?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              controllerBloc.add(DeleteCompletedCourseEvent(
                                  context: context,
                                  courseEntity: completedCourseEntity));
                            },
                            child: const Text("I am sure, delete it!")),
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel")),
                      ]));
        },
        child: Text(completedCourseEntity.name));
  }
}
