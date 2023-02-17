import 'package:bloc/bloc.dart';
import 'package:improsso/infrastructure/repositories/studies_repository_impl.dart';

part 'studies_event.dart';
part 'studies_state.dart';

class StudiesBloc extends Bloc<StudiesEvent, StudiesState> {
  StudiesBloc() : super(StudiesInitial()) {
    on<LoadUniversitiesAndProgramsEvent>((event, emit) async {
      StudiesRepositoryImpl studiesRepositoryImpl = StudiesRepositoryImpl();
      await studiesRepositoryImpl
          .loadUniversityNames()
          .then((failureOrUnisAndProgramsMap) {
        failureOrUnisAndProgramsMap.fold(
            (failure) => emit(StudiesFailure()),
            (unisAndProgramsMaps) => emit(StudiesSuccess(
                universities: unisAndProgramsMaps["unis"]!,
                programs: unisAndProgramsMaps["programs"]!)));
      });
    });
  }
}
