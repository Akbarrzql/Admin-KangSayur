import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/event/verifikasi_produk_event.dart';
import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/respository/verifikasi_produk_repository.dart';
import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/state/verfikasi_produk_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifikasiProdukPageBloc extends Bloc<VerfikasiProdukPageEvent, VerfikasiProdukPageState>{
  final VerifikasiProdukRepository verifikasiProdukRepository;

  VerifikasiProdukPageBloc({required this.verifikasiProdukRepository}) : super(InitialVerfikasiProdukPageState()){
    on<GetListVerfikasi>((event, emit) async {
      emit(VerifikasiProdukPageLoading());
      try {
        var verifikasiProduk = await verifikasiProdukRepository.getVerifikasiProduk();
        emit(VerifikasiProdukPageLoaded(verifikasiProduk));
      } catch (e) {
        emit(VerifikasiProdukPageError(e.toString()));
      }
    });
  }
}