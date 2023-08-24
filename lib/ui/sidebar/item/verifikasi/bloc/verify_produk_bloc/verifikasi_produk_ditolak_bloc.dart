import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/event/verify_produk_event/verifikasi_ditolak_event.dart';
import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/respository/verify_produk/verifikasi_ditolak_repository.dart';
import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/state/verify_produk_state/verifikasi_ditolak_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class VerifikasiProdukDitolakBloc extends Bloc<VerifyProdukRejectEvent, VerifyProdukRejectState> {
  final VerifikasiDitolakRepository verifikasiProdukDitolakRepository;

  VerifikasiProdukDitolakBloc({required this.verifikasiProdukDitolakRepository}) : super(InitialVerifyProdukRejectState()){
    on<PostVerifyProdukReject>((event, emit) async{
      emit(VerifyProdukRejectLoading());
      try{
        var data = await verifikasiProdukDitolakRepository.verifikasiDitolak(event.idProduk, event.idToko, event.alasan);
        emit(VerifyProdukRejectSuccess(data));
      }catch(e){
        emit(VerifyProdukRejectError(e.toString()));
      }
    });
  }

}