import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/model/verifikasi_produk_model.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class VerfikasiProdukPageState {}

class InitialVerfikasiProdukPageState extends VerfikasiProdukPageState {}

class VerifikasiProdukPageLoading extends VerfikasiProdukPageState {}

class VerifikasiProdukPageLoaded extends VerfikasiProdukPageState {
  final VerifikasiProdukModel verifikasiProduk;

  VerifikasiProdukPageLoaded(this.verifikasiProduk);
}

class VerifikasiProdukPageError extends VerfikasiProdukPageState {
  final String errorMessage;

  VerifikasiProdukPageError(this.errorMessage);
}