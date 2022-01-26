import 'package:bloc/bloc.dart';
import '../auth_credentials.dart';
import '../../session/session_cubit.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.sessionCubit}) : super(AuthState.welcome);

  final SessionCubit sessionCubit;
  AuthCredentials? authCredentials;

  void showLogin() {
    emit(AuthState.login);
  }

  void showSignUp() {
    emit(AuthState.signUp);
  }

  void showConfirm(
      {required String username, String? email, String? password}) {
    authCredentials =
        AuthCredentials(username: username, email: email, password: password);
    emit(AuthState.confirm);
  }

  void launchSession(AuthCredentials authCredentials) {
    sessionCubit.showSession(authCredentials);
  }
}
