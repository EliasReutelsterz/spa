import 'package:bloc/bloc.dart';
import 'package:improsso/domain/auth_domain/repositories/auth_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignOutPressedEvent>((event, emit) async {
      await authRepository.logOut();
      emit(AuthStateUnauthentificated());
    });

    on<AuthCheckRequestedEvent>((event, emit) async {
      final userOption = authRepository.getSignedInUser();

      userOption.fold(() => emit(AuthStateUnauthentificated()),
          (a) => emit(AuthStateAuthentificated()));
    });
  }
}
