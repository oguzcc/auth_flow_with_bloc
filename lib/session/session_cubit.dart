import 'package:bloc/bloc.dart';
import '../auth/auth_credentials.dart';
import '../data/auth_repository.dart';
import 'package:meta/meta.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit({required this.authRepository}) : super(SessionUnknown()) {
    attemptAutoLogin();
  }

  final AuthRepository authRepository;

  void attemptAutoLogin() async {
    try {
      final user = await authRepository.attemptAutoLogin();
      emit(Authenticated(user: user));
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void showAuth() {
    emit(Unauthenticated());
  }

  void showSession(AuthCredentials authCredentials) {
    final user = authCredentials.username;
    emit(Authenticated(user: user));
  }

  void signOut() {
    authRepository.signOut();
    emit(Unauthenticated());
  }
}
