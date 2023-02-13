import 'package:dartz/dartz.dart';
import 'package:improsso/domain/general_domain/entities/universities_entity.dart';
import 'package:improsso/domain/general_domain/failures/failures.dart';

abstract class UniversitiesRepository {
  Future<Either<Failure, UniversitiesEntity>> loadUniversityData();
}
