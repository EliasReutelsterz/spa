import 'package:improsso/domain/auth_domain/entities/id.dart';

class UserEntity {
  final UniqueID id;
  final String username;
  final String email;
  final String universityId;
  final String programId;

  UserEntity(
      {required this.id,
      required this.username,
      required this.email,
      required this.universityId,
      required this.programId});

  factory UserEntity.empty() {
    return UserEntity(
        id: UniqueID(),
        username: "",
        email: "",
        universityId: "",
        programId: "");
  }

  UserEntity copyWith(
      {UniqueID? id,
      String? username,
      String? email,
      String? universityId,
      String? programId}) {
    return UserEntity(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        universityId: universityId ?? this.universityId,
        programId: programId ?? this.programId);
  }
}
