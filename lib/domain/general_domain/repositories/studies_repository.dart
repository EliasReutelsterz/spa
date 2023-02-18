import 'package:dartz/dartz.dart';
import 'package:improsso/domain/general_domain/entities/studies_entity.dart';
import 'package:improsso/domain/general_domain/failures/failures.dart';

abstract class StudiesRepository {
  Future<Either<Failure, StudiesEntity>> loadUniversityNames();
}
