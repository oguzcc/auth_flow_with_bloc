part of 'sign_up_bloc.dart';

class SignUpState {
  String username;
  bool get isValidUsername => username.length > 3;
  String email;
  bool get isValidEmail => email.contains('@') && email.length > 5;
  String password;
  bool get isValidPassword => password.length > 3;
  FormSubmissionStatus? formStatus;

  SignUpState({
    this.username = '',
    this.email = '',
    this.password = '',
    this.formStatus = const FormSubmissionInitial(),
  });

  SignUpState copyWith(
      {String? username,
      String? password,
      String? email,
      FormSubmissionStatus? formStatus}) {
    return SignUpState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
