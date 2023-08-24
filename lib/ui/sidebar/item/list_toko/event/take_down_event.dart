import 'package:flutter/cupertino.dart';

@immutable
abstract class TakeDownEvent {}

class PostTakeDown extends TakeDownEvent {
  final String tokoId;
  final String produkId;
  final String alasan;

  PostTakeDown(this.tokoId, this.produkId, this.alasan);
}