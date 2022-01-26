import 'package:bloc/bloc.dart';
import '../auth/auth_cubit.dart';
import '../auth_credentials.dart';
import '../form_submission.dart';
import '../../data/auth_repository.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, SignUpState> {
  final AuthRepository authRepository;
  final AuthCubit authCubit;

  LoginBloc({required this.authRepository, required this.authCubit})
      : super(SignUpState()) {
    on<LoginUsernameChanged>((event, emit) {
      emit(state.copyWith(username: event.username));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmissionSubmitting()));

      try {
        await authRepository.login();
        emit(state.copyWith(formStatus: FormSubmissionSuccess()));
        authCubit.launchSession(AuthCredentials(username: state.username));
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: FormSubmissionFailed(exception: e)));
      }
    });
  }
}
