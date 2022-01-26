part of 'welcome_cubit.dart';

@immutable
abstract class WelcomeState {}

class WelcomeInitial extends WelcomeState {}

class LoginState extends WelcomeState {}

class SignUpState extends WelcomeState {}
