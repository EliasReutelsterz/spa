import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:improsso/core/errors/erros.dart';
import 'package:improsso/domain/auth_domain/repositories/auth_repository.dart';
import 'package:improsso/domain/general_domain/entities/general_course_entity.dart';
import 'package:improsso/domain/general_domain/entities/program_entity.dart';
import 'package:improsso/domain/general_domain/entities/studies_entity.dart';
import 'package:improsso/domain/general_domain/entities/uni_entity.dart';
import 'package:improsso/domain/general_domain/failures/failures.dart';
import 'package:improsso/domain/general_domain/repositories/studies_repository.dart';
import 'package:improsso/injection.dart';

class StudiesRepositoryImpl implements StudiesRepository {
  @override
  Future<Either<Failure, StudiesEntity>> loadUniversityNames() async {
    try {
      final userOption = sl<AuthRepository>().getSignedInUser();
      final currentUser =
          userOption.getOrElse(() => throw NotAuthentificatedError());
      return FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.id.value)
          .get()
          .then((userDoc) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        CollectionReference universities =
            FirebaseFirestore.instance.collection('universities');
        Map<String, UniEntity> mapUniNames = {};
        return universities.get().then((QuerySnapshot unisSnapshot) {
          for (QueryDocumentSnapshot uni in unisSnapshot.docs) {
            Map<dynamic, dynamic> dataOfUni =
                uni.data() as Map<String, dynamic>;
            mapUniNames[uni.id] =
                UniEntity(name: dataOfUni["name"] as String, id: uni.id);
          }
          if (userData["currentUniversityId"] as String == "") {
            return right(StudiesEntity(
                programsMap: {}, unisMap: mapUniNames, courseMap: {}));
          } else {
            return universities
                .doc(userData["currentUniversityId"] as String)
                .collection("programs")
                .get()
                .then((programs) {
              Map<String, ProgramEntity> mapProgramNames = {};
              for (QueryDocumentSnapshot program in programs.docs) {
                Map<String, dynamic> programData =
                    program.data() as Map<String, dynamic>;
                mapProgramNames[program.id] = ProgramEntity(
                    name: programData["name"] as String, id: program.id);
              }
              if (userData["currentProgramId"] as String == "") {
                return right(StudiesEntity(
                    unisMap: mapUniNames,
                    programsMap: mapProgramNames,
                    courseMap: {}));
              } else {
                return universities
                    .doc(userData["currentUniversityId"] as String)
                    .collection("programs")
                    .doc(userData["currentProgramId"])
                    .collection("courses")
                    .get()
                    .then((courses) {
                  Map<String, GeneralCourseEntity> mapCourses = {};
                  for (QueryDocumentSnapshot course in courses.docs) {
                    Map<String, dynamic> courseData =
                        course.data() as Map<String, dynamic>;
                    mapCourses[course.id] = GeneralCourseEntity(
                        uniId: userData["currentUniversityId"] as String,
                        programId: userData["currentProgramId"] as String,
                        name: courseData["name"] as String,
                        ects: courseData["ects"] as int,
                        field: courseData["field"] as String,
                        id: course.id);
                  }
                  return right(StudiesEntity(
                      unisMap: mapUniNames,
                      programsMap: mapProgramNames,
                      courseMap: mapCourses));
                });
              }
            });
          }
        });
      });
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
