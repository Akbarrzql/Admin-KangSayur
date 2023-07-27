import 'package:flutter/cupertino.dart';

@immutable
abstract class LogoutPageEvent {}

class LogoutButtonPressed extends LogoutPageEvent {}