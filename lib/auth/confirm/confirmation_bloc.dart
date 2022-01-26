import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../auth/auth_cubit.dart';
import '../form_submission.dart';
import '../../data/auth_repository.dart';
import 'package:meta/meta.dart';

part 'confirmation_event.dart';
part 'confirmation_state.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepository;
  final AuthCubit authCubit;

  ConfirmationBloc({required this.authRepository, required this.authCubit})
      : super(ConfirmationState()) {
    on<ConfirmationCodeChanged>((event, emit) {
      emit(state.copyWith(confirmationCode: event.confirmationCode));
    });

    on<ConfirmationSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmissionSubmitting()));

      try {
        await authRepository.confirmation();
        emit(state.copyWith(formStatus: FormSubmissionSuccess()));
        final authCredentials = authCubit.authCredentials;
        authCubit.launchSession(authCredentials!);
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: FormSubmissionFailed(exception: e)));
      }
    });
  }
}
