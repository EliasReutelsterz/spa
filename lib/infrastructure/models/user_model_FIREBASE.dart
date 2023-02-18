/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:improsso/domain/auth_domain/entities/id.dart';
import 'package:improsso/domain/general_domain/entities/course_entitiy.dart';
import 'package:improsso/domain/general_domain/entities/user_entity.dart';

class UserModelFIREBASE {
  final String id;
  final String username;
  final String email;
  final String currentUniversityId;
  final String currentProgramId;
  final Map<String, CourseEntity> courses;

  UserModelFIREBASE(
      {required this.id,
      required this.username,
      required this.email,
      required this.currentUniversityId,
      required this.currentProgramId,
      required this.courses});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'username': username});
    result.addAll({'email': email});
    result.addAll({'currentUniversityId': currentUniversityId});
    result.addAll({'currentProgramId': currentProgramId});
    result.addAll({'courses': courses});

    return result;
  }

  factory UserModelFIREBASE.fromMap(Map<String, dynamic> map) {
    Map<String, Map<String, dynamic>> asMap =
        map['courses'] as Map<String, Map<String, dynamic>>;
    for (String course in asMap.keys) {
      print(course);
    }
    return UserModelFIREBASE(
        id: map['id'] as String,
        username: map['username'] as String,
        email: map['email'] as String,
        currentUniversityId: map['currentUniversityId'] as String,
        currentProgramId: map['currentProgramId'] as String,
        courses: map['courses'] as Map<String, CourseEntity>);
  }

  UserModelFIREBASE copyWith({
    String? id,
    String? username,
    String? email,
    String? currentUniversityId,
    String? currentProgramId,
    Map<String, CourseEntity>? courses,
  }) {
    return UserModelFIREBASE(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      currentUniversityId: currentUniversityId ?? this.currentUniversityId,
      currentProgramId: currentProgramId ?? this.currentProgramId,
      courses: courses ?? this.courses,
    );
  }

  factory UserModelFIREBASE.fromFirestoreAsDocument(
      DocumentSnapshot<dynamic> doc) {
    return UserModelFIREBASE.fromMap(doc.data()!).copyWith(id: doc.id);
  }

  factory UserModelFIREBASE.fromFirestoreAsQuery(QueryDocumentSnapshot doc) {
    return UserModelFIREBASE.fromMap(doc.data() as Map<String, dynamic>)
        .copyWith(id: doc.id);
  }

  UserEntity toDomain() {
    return UserEntity(
        id: UniqueID.fromUniqueString(id),
        username: username,
        email: email,
        currentUniversityId: currentUniversityId,
        currentProgramId: currentProgramId,
        courses: courses);
  }

  factory UserModelFIREBASE.fromDomain(UserEntity user) {
    return UserModelFIREBASE(
        id: user.id.value,
        username: user.username,
        email: user.email,
        currentUniversityId: user.currentUniversityId,
        currentProgramId: user.currentProgramId,
        courses: user.courses);
  }
}
*/