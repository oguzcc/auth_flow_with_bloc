part of 'session_cubit.dart';

@immutable
abstract class SessionState {}

class SessionUnknown extends SessionState {}

class Unauthenticated extends SessionState {}

class Authenticated extends SessionState {
  final dynamic user;

  Authenticated({required this.user});
}
