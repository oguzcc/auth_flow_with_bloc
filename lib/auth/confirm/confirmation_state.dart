part of 'confirmation_bloc.dart';

class ConfirmationState {
  final String confirmationCode;
  bool get isValidConfirmationCode => confirmationCode.length == 6;
  final FormSubmissionStatus formStatus;

  ConfirmationState({
    this.confirmationCode = '',
    this.formStatus = const FormSubmissionInitial(),
  });

  ConfirmationState copyWith(
          {String? confirmationCode, FormSubmissionStatus? formStatus}) =>
      ConfirmationState(
        confirmationCode: confirmationCode ?? this.confirmationCode,
        formStatus: formStatus ?? this.formStatus,
      );
}
