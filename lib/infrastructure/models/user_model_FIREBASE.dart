import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:improsso/domain/auth_domain/entities/id.dart';
import 'package:improsso/domain/general_domain/entities/user_entity.dart';

class UserModelFIREBASE {
  final String id;
  final String username;
  final String email;
  final String universityId;
  final String programId;

  UserModelFIREBASE(
      {required this.id,
      required this.username,
      required this.email,
      required this.universityId,
      required this.programId});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'username': username});
    result.addAll({'email': email});
    result.addAll({'universityId': email});
    result.addAll({'programId': email});

    return result;
  }

  factory UserModelFIREBASE.fromMap(Map<String, dynamic> map) {
    return UserModelFIREBASE(
        id: map['id'] as String,
        username: map['username'] as String,
        email: map['email'] as String,
        universityId: map['universityId'] as String,
        programId: map['programId'] as String);
  }

  UserModelFIREBASE copyWith({
    String? id,
    String? username,
    String? email,
    String? universityId,
    String? programId,
  }) {
    return UserModelFIREBASE(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      universityId: universityId ?? this.universityId,
      programId: programId ?? this.programId,
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
        universityId: universityId,
        programId: programId);
  }

  factory UserModelFIREBASE.fromDomain(UserEntity user) {
    return UserModelFIREBASE(
        id: user.id.value,
        username: user.username,
        email: user.email,
        universityId: user.universityId,
        programId: user.programId);
  }
}
