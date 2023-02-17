import 'package:dartz/dartz.dart';
import 'package:improsso/domain/general_domain/failures/failures.dart';

abstract class StudiesRepository {
  Future<Either<Failure, Map<String, Map<String, String>>>>
      loadUniversityNames();

  Future<Either<Failure, List<String>>> loadProgramNames(String universityID);
}
