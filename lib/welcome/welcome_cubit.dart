import 'package:bloc/bloc.dart';
import '../auth/auth/auth_cubit.dart';
import 'package:meta/meta.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit({required this.authCubit}) : super(WelcomeInitial());

  final AuthCubit authCubit;

  void showLoginPage() {
    emit(LoginState());
    authCubit.showLogin();
  }

  void showSignUpPage() {
    emit(SignUpState());
    authCubit.showSignUp();
  }
}
