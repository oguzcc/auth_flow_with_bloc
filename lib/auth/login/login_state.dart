part of 'login_bloc.dart';

class SignUpState {
  String username;
  bool get isValidUsername => username.length > 3;
  String password;
  bool get isValidPassword => password.length > 3;
  FormSubmissionStatus? formStatus;

  SignUpState({
    this.username = '',
    this.password = '',
    this.formStatus = const FormSubmissionInitial(),
  });

  SignUpState copyWith(
      {String? username, String? password, FormSubmissionStatus? formStatus}) {
    return SignUpState(
      username: username ?? this.username,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
