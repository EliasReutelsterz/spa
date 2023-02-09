import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:improsso/core/errors/erros.dart';
import 'package:improsso/domain/auth_domain/repositories/auth_repository.dart';
import 'package:improsso/domain/user_domain/entities/pictures_entity.dart';
import 'package:improsso/domain/user_domain/entities/user_entity.dart';
import 'package:improsso/domain/user_domain/failures/failures.dart';
import 'package:improsso/domain/user_domain/failures/user_failures.dart';
import 'package:improsso/domain/user_domain/repositories/user_repository.dart';
import 'package:improsso/infrastructure/models/user_model_FIREBASE.dart';
import 'package:improsso/injection.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Stream<Either<UserFailure, UserEntity>> getAllData() async* {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final currentUser =
        userOption.getOrElse(() => throw NotAuthentificatedError());
    //statt der drei Zeilen hier drüber auch möglich: User user = FirebaseAuth.instance.currentUser!;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Stream<Either<UserFailure, UserEntity>> userEntityStream =
        users.doc(currentUser.id.value).snapshots().map((snapshot) {
      return right<UserFailure, UserEntity>(
          UserModelFIREBASE.fromFirestoreAsDocument(snapshot).toDomain());
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
}
