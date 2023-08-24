import 'package:flutter/cupertino.dart';

import '../../model/confirm/verifikasi_ditolak_model.dart';

@immutable
abstract class VerifyProdukRejectState{}

class InitialVerifyProdukRejectState extends VerifyProdukRejectState{}

class VerifyProdukRejectLoading extends VerifyProdukRejectState{}

class VerifyProdukRejectSuccess extends VerifyProdukRejectState{
  final VerifikasiDitolakModel verifikasiDitolakModel;

  VerifyProdukRejectSuccess(this.verifikasiDitolakModel);
}

class VerifyProdukRejectError extends VerifyProdukRejectState{
  final String errorMessage;

  VerifyProdukRejectError(this.errorMessage);
}
