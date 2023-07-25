import 'package:flutter/cupertino.dart';
import '../../model/produk_model.dart';

@immutable
abstract class ProdukPageState {}

class InitialProdukState extends ProdukPageState {}

class IsLoadingProduk extends ProdukPageState {}

class IsErrorProduk extends ProdukPageState {
  final String error;

  IsErrorProduk(this.error);
}

class IsLoadedProduk extends ProdukPageState {
  final ProdukModel listProdukModel;

  IsLoadedProduk(this.listProdukModel);
}

