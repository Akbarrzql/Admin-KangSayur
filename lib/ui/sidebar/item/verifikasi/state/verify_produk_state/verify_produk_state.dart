import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/model/confirm/konfirmasi_verifikasi_model.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class VerifyProdukState {}

class VerifyProdukInitial extends VerifyProdukState {}

class VerifyProdukLoading extends VerifyProdukState {}

class VerifyProdukLoaded extends VerifyProdukState {
  final KonfirmasiVerifikasiModel verifyProdukModel;

  VerifyProdukLoaded(this.verifyProdukModel);
}

class VerifyProdukError extends VerifyProdukState {
  final String errorMessage;

  VerifyProdukError(this.errorMessage);
}