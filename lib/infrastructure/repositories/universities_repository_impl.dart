import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:improsso/domain/general_domain/entities/universities_entity.dart';
import 'package:improsso/domain/general_domain/failures/failures.dart';
import 'package:improsso/domain/general_domain/repositories/universities_repository.dart';

class UniversitiesRepositoryImpl implements UniversitiesRepository {
  @override
  Future<Either<Failure, UniversitiesEntity>> loadUniversityData() async {
    try {
      CollectionReference universities =
          FirebaseFirestore.instance.collection('universities');
      Map<String, dynamic> totalData = {};
      return universities.get().then((QuerySnapshot unisSnapshot) {
        for (QueryDocumentSnapshot uni in unisSnapshot.docs) {
          Map<dynamic, dynamic> dataOfUni = uni.data() as Map<dynamic, dynamic>;
          totalData[uni.id] = {"uni_name": dataOfUni["name"]};
          universities
              .doc(uni.id)
              .collection("programs")
              .get()
              .then((QuerySnapshot programsSnapshot) {
            totalData[uni.id]["programs"] = {};
            for (QueryDocumentSnapshot program in programsSnapshot.docs) {
              Map<dynamic, dynamic> dataOfProgram =
                  program.data() as Map<dynamic, dynamic>;
              totalData[uni.id]["programs"]
                  [program.id] = {"program_name": dataOfProgram["name"]};
            }
          });
        }
        return right(UniversitiesEntity(universities: totalData));
      });
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
