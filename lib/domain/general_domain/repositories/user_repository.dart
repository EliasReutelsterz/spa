import 'package:dartz/dartz.dart';
import 'package:improsso/domain/general_domain/entities/completed_course_entitiy.dart';
import 'package:improsso/domain/general_domain/entities/pictures_entity.dart';
import 'package:improsso/domain/general_domain/entities/user_entity.dart';
import 'package:improsso/domain/general_domain/failures/failures.dart';
import 'package:improsso/domain/general_domain/failures/user_failures.dart';

abstract class UserRepository {
  Stream<Either<UserFailure, UserEntity>> getAllData();

  Future<Either<Failure, PicturesEntity>> loadProfilePicture();

  Future<Either<Failure, Unit>> deleteProfilePicture();

  Future<Either<Failure, Unit>> pickAndUploadProfilePicture();

  Future<Either<Failure, Unit>> updateUsername(String input);

  Future<Either<Failure, Unit>> updateCurrentUniversity(String input);

  Future<Either<Failure, Unit>> updateCurrentProgram(String input);

  Stream<Either<Failure, Map<String, CompletedCourseEntity>>>
      getCompletedCourses();

  Future<Either<Failure, Unit>> addCompletedCourse(
      CompletedCourseEntity courseEntity);

  Future<Either<Failure, Unit>> deleteCompletedCourse(
      CompletedCourseEntity courseEntity);
}
