import 'package:flutter/cupertino.dart';

@immutable
abstract class ProdukPageEvent {}

class GetProduk extends ProdukPageEvent {
  final String tokoId;
  String kategoriId;

  GetProduk(this.tokoId, this.kategoriId);
}
