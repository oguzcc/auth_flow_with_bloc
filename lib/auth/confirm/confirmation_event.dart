part of 'confirmation_bloc.dart';

@immutable
abstract class ConfirmationEvent {}

class ConfirmationCodeChanged extends ConfirmationEvent {
  final String confirmationCode;
  ConfirmationCodeChanged({required this.confirmationCode});
}

class ConfirmationSubmitted extends ConfirmationEvent {}
