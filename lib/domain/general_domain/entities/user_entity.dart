import 'package:improsso/domain/auth_domain/entities/id.dart';

class UserEntity {
  final UniqueID id;
  final String username;
  final String email;
  final String currentUniversityId;
  final String currentProgramId;

  UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.currentUniversityId,
    required this.currentProgramId,
  });

  factory UserEntity.empty() {
    return UserEntity(
        id: UniqueID(),
        username: "",
        email: "",
        currentUniversityId: "",
        currentProgramId: "");
  }

  UserEntity copyWith(
      {UniqueID? id,
      String? username,
      String? email,
      String? currentUniversityId,
      String? currentProgramId}) {
    return UserEntity(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        currentUniversityId: currentUniversityId ?? this.currentUniversityId,
        currentProgramId: currentProgramId ?? this.currentProgramId);
  }
}
