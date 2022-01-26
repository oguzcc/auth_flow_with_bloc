import 'package:bloc/bloc.dart';
import '../auth/auth_cubit.dart';
import '../form_submission.dart';
import '../../data/auth_repository.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;
  final AuthCubit authCubit;

  SignUpBloc({required this.authRepository, required this.authCubit})
      : super(SignUpState()) {
    on<SignUpUsernameChanged>((event, emit) {
      emit(state.copyWith(username: event.username));
    });

    on<SignUpEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<SignUpPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<SignUpSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmissionSubmitting()));

      try {
        await authRepository.signUp();
        emit(state.copyWith(formStatus: FormSubmissionSuccess()));
        authCubit.showConfirm(username: state.username);
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: FormSubmissionFailed(exception: e)));
      }
    });
  }
}
