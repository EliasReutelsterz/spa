import 'package:bloc/bloc.dart';
import 'package:improsso/infrastructure/repositories/studies_repository_impl.dart';

part 'studies_event.dart';
part 'studies_state.dart';

class StudiesBloc extends Bloc<StudiesEvent, StudiesState> {
  StudiesBloc() : super(StudiesInitial()) {
    on<LoadStudiesEvent>((event, emit) async {
      StudiesRepositoryImpl studiesRepositoryImpl = StudiesRepositoryImpl();
      await studiesRepositoryImpl
          .loadUniversityNames()
          .then((failureOrstudiesEntity) {
        failureOrstudiesEntity.fold(
            (failure) => emit(StudiesFailure()),
            (studiesEntity) => emit(StudiesSuccess(
                universities: studiesEntity.unisMap,
                programs: studiesEntity.programsMap,
                courses: studiesEntity.courseMap)));
      });
    });
  }
}
