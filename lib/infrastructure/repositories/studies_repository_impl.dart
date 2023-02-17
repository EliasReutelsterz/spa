import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:improsso/core/errors/erros.dart';
import 'package:improsso/domain/auth_domain/repositories/auth_repository.dart';
import 'package:improsso/domain/general_domain/failures/failures.dart';
import 'package:improsso/domain/general_domain/repositories/studies_repository.dart';
import 'package:improsso/injection.dart';

class StudiesRepositoryImpl implements StudiesRepository {
  @override
  Future<Either<Failure, Map<String, Map<String, String>>>>
      loadUniversityNames() async {
    try {
      final userOption = sl<AuthRepository>().getSignedInUser();
      final currentUser =
          userOption.getOrElse(() => throw NotAuthentificatedError());
      Map<String, Map<String, String>> mapUnisAndPrograms = {};
      return FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.id.value)
          .get()
          .then((userDoc) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        CollectionReference universities =
            FirebaseFirestore.instance.collection('universities');
        Map<String, String> mapUniNames = {};
        return universities.get().then((QuerySnapshot unisSnapshot) {
          for (QueryDocumentSnapshot uni in unisSnapshot.docs) {
            Map<dynamic, dynamic> dataOfUni =
                uni.data() as Map<String, dynamic>;
            mapUniNames[uni.id] = dataOfUni["name"] as String;
          }
          mapUnisAndPrograms["unis"] = mapUniNames;
          if (userData["universityId"] as String == "") {
            mapUnisAndPrograms["programs"] = {};
            return right(mapUnisAndPrograms);
          } else {
            return universities
                .doc(userData["universityId"] as String)
                .collection("programs")
                .get()
                .then((programs) {
              Map<String, String> mapProgramNames = {};
              for (QueryDocumentSnapshot program in programs.docs) {
                Map<String, dynamic> programData =
                    program.data() as Map<String, dynamic>;
                mapProgramNames[program.id] = programData["name"] as String;
              }
              mapUnisAndPrograms["programs"] = mapProgramNames;
              return right(mapUnisAndPrograms);
            });
          }
        });
      });
    } catch (e) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> loadProgramNames(
      String universityID) async {
    try {
      CollectionReference programs = FirebaseFirestore.instance
          .collection('universities')
          .doc(universityID)
          .collection("programs");
      List<String> listProgramNames = [];
      return programs.get().then((QuerySnapshot programsSnapshot) {
        for (QueryDocumentSnapshot program in programsSnapshot.docs) {
          Map<dynamic, dynamic> dataOfProgram =
              program.data() as Map<dynamic, dynamic>;
          listProgramNames.add(dataOfProgram["name"]);
        }
        return right(listProgramNames);
      });
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
