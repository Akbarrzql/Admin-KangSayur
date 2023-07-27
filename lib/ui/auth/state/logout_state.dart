import 'package:flutter/cupertino.dart';

@immutable
abstract class LogoutPageState {}

class InitialLogoutPageState extends LogoutPageState {}

class LogoutPageLoading extends LogoutPageState {}

class LogoutPageLoaded extends LogoutPageState {}

class LogoutPageError extends LogoutPageState {
  final String errorMessage;

  LogoutPageError(this.errorMessage);
}
