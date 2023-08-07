import 'package:flutter/cupertino.dart';

@immutable
abstract class VerifyProdukEvent {}

class GetVerify extends VerifyProdukEvent {
  final String idProduk;

  GetVerify({required this.idProduk});
}