import 'package:bloc/bloc.dart';

part 'universities_event.dart';
part 'universities_state.dart';

class UniversitiesBloc extends Bloc<UniversitiesEvent, UniversitiesState> {
  UniversitiesBloc() : super(UniversitiesInitial()) {
    on<UniversitiesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
