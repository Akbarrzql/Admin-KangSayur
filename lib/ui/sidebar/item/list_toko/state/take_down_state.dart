import 'package:flutter/cupertino.dart';

import '../model/take_down_produk.dart';

@immutable
abstract class TakeDownState {}

class InitialTakeDownState extends TakeDownState {}

class IsLoadingTakeDown extends TakeDownState {}

class IsErrorTakeDown extends TakeDownState {
  final String error;

  IsErrorTakeDown(this.error);
}

class IsLoadedTakeDown extends TakeDownState {
  final TakeDownModel takeDownModel;

  IsLoadedTakeDown(this.takeDownModel);
}