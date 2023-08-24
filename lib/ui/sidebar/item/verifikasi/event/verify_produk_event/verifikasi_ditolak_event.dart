import 'package:flutter/cupertino.dart';

@immutable
abstract class VerifyProdukRejectEvent{}

class PostVerifyProdukReject extends VerifyProdukRejectEvent{
  final String idProduk;
  final String idToko;
  final String alasan;

  PostVerifyProdukReject({required this.idProduk, required this.idToko, required this.alasan});
}