import 'package:flutter/cupertino.dart';

import '../../../model/login_model.dart';

@immutable
abstract class LoginPageState {}

class InitialLoginPageState extends LoginPageState {}

class LoginPageLoading extends LoginPageState {}

class LoginPageLoaded extends LoginPageState {
  final LoginModel loginModel;

  LoginPageLoaded(this.loginModel);
}

class LoginPageError extends LoginPageState {
  final String errorMessage;

  LoginPageError(this.errorMessage);
}
