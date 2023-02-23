import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:improsso/core/errors/erros.dart';
import 'package:improsso/domain/auth_domain/repositories/auth_repository.dart';
import 'package:improsso/domain/general_domain/entities/completed_course_entitiy.dart';
import 'package:improsso/domain/general_domain/entities/pictures_entity.dart';
import 'package:improsso/domain/general_domain/entities/user_entity.dart';
import 'package:improsso/domain/general_domain/failures/failures.dart';
import 'package:improsso/domain/general_domain/failures/user_failures.dart';
import 'package:improsso/domain/general_domain/repositories/user_repository.dart';
import 'package:improsso/injection.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Stream<Either<UserFailure, UserEntity>> getAllData() async* {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final currentUser =
        userOption.getOrElse(() => throw NotAuthentificatedError());
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Stream<Either<UserFailure, UserEntity>> userEntityStream =
        users.doc(currentUser.id.value).snapshots().map((snapshot) {
      Map<String, dynamic> userdocData =
          snapshot.data() as Map<String, dynamic>;
      return right<UserFailure, UserEntity>(UserEntity(
          id: currentUser.id,
          username: userdocData["username"] as String,
          email: userdocData["email"] as String,
          currentUniversityId: userdocData["currentUniversityId"] as String,
          currentProgramId: userdocData["currentProgramId"] as String));
    }).handleError((e) {
      if (e is FirebaseException) {
        if (e.code.contains('permission-denied') ||
            e.code.contains("PERMISSION_DENIED")) {
          return left(InsufficientPermissions());
        } else {
          return left(GeneralUserFailure());
        }
      } else {
        return left(GeneralUserFailure());
      }
    });
    yield* userEntityStream;
  }

  @override
  Future<Either<Failure, PicturesEntity>> loadProfilePicture() async {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final currentUser =
        userOption.getOrElse(() => throw NotAuthentificatedError());
    const oneMegabyte = 1024 * 1024;
    final storageRef = FirebaseStorage.instance.ref();
    final pathReference =
        storageRef.child("/images/${currentUser.id.value}/profile_picture");
    final Either<Failure, PicturesEntity> failureOrPicturesEntity =
        await pathReference.getData(oneMegabyte).then((data) {
      try {
        return right(PicturesEntity(profilePicture: Image.memory(data!)));
      } catch (e) {
        return left(GeneralFailure());
      }
    });
    return failureOrPicturesEntity;
  }

  @override
  Future<Either<Failure, Unit>> deleteProfilePicture() async {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final currentUser =
        userOption.getOrElse(() => throw NotAuthentificatedError());
    final storageRef = FirebaseStorage.instance.ref();
    final pathReference =
        storageRef.child("/images/${currentUser.id.value}/profile_picture");
    try {
      return await pathReference.delete().then((value) => right(unit));
    } catch (e) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> pickAndUploadProfilePicture() async {
    try {
      final ImagePicker picker = ImagePicker();
      return await picker
          .pickImage(source: ImageSource.gallery, imageQuality: 1)
          .then((pickedFile) async {
        if (pickedFile != null) {
          File photo = File(pickedFile.path);
          User user = FirebaseAuth.instance.currentUser!;
          final storageRef = FirebaseStorage.instance.ref();
          final folderRef =
              storageRef.child('/images/${user.uid}/profile_picture');
          return await folderRef.putFile(photo).then((p0) => right(unit));
        } else {
          return left(GeneralFailure());
        }
      });
    } catch (e) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUsername(String input) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      return FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        "username": input,
      }, SetOptions(merge: true)).then((value) {
        return right(unit);
      });
    } catch (e) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCurrentUniversity(String input) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      return FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        "currentUniversityId": input,
      }, SetOptions(merge: true)).then((value) {
        return right(unit);
      });
    } catch (e) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCurrentProgram(String input) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      return FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        "currentProgramId": input,
      }, SetOptions(merge: true)).then((value) {
        return right(unit);
      });
    } catch (e) {
      return left(GeneralFailure());
    }
  }

  @override
  Stream<Either<Failure, Map<String, CompletedCourseEntity>>>
      getCompletedCourses() async* {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final currentUser =
        userOption.getOrElse(() => throw NotAuthentificatedError());
    CollectionReference coursesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.id.value)
        .collection("courses");

    yield* coursesRef.snapshots().map((snapshot) {
      Map<String, CompletedCourseEntity> coursesMap = {};
      for (QueryDocumentSnapshot<Object?> course in snapshot.docs) {
        if (course["graded"]) {
          coursesMap[course.id] = CompletedCourseEntity(
              uniId: course["uniId"],
              programId: course["programId"],
              name: course["name"],
              graded: course["graded"],
              grade: course["grade"],
              ects: course["ects"],
              field: course["field"],
              semester: course["semester"],
              id: course.id);
        } else {
          coursesMap[course.id] = CompletedCourseEntity(
              uniId: course["uniId"],
              programId: course["programId"],
              name: course["name"],
              graded: course["graded"],
              ects: course["ects"],
              field: course["field"],
              semester: course["semester"],
              id: course.id);
        }
      }
      return right<Failure, Map<String, CompletedCourseEntity>>(coursesMap);
    }).handleError((e) {
      return left(GeneralFailure());
    });
  }

  @override
  Future<Either<Failure, Unit>> addCompletedCourse(
      CompletedCourseEntity courseEntity) async {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final currentUser =
        userOption.getOrElse(() => throw NotAuthentificatedError());
    try {
      if (courseEntity.graded) {
        return FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser.id.value)
            .collection("courses")
            .doc(courseEntity.id)
            .set({
          "uniId": courseEntity.uniId,
          "programId": courseEntity.programId,
          "name": courseEntity.name,
          "grade": courseEntity.grade,
          "graded": courseEntity.graded,
          "ects": courseEntity.ects,
          "field": courseEntity.field,
          "semester": courseEntity.semester
        }, SetOptions(merge: true)).then((value) {
          return right(unit);
        });
      } else {
        return FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser.id.value)
            .collection("courses")
            .doc(courseEntity.id)
            .set({
          "uniId": courseEntity.uniId,
          "programId": courseEntity.programId,
          "name": courseEntity.name,
          "graded": courseEntity.graded,
          "ects": courseEntity.ects,
          "field": courseEntity.field,
          "semester": courseEntity.semester
        }, SetOptions(merge: true)).then((value) {
          return right(unit);
        });
      }
    } catch (e) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCompletedCourse(
      CompletedCourseEntity courseEntity) async {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final currentUser =
        userOption.getOrElse(() => throw NotAuthentificatedError());
    try {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser.id.value)
          .collection("courses")
          .doc(courseEntity.id)
          .delete()
          .then((value) {
        return right(unit);
      });
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
