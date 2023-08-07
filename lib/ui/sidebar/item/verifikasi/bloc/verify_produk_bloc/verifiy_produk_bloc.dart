import 'package:flutter_bloc/flutter_bloc.dart';

import '../../event/verify_produk_event/verify_produk_event.dart';
import '../../respository/verify_produk/verify_produk_repository.dart';
import '../../state/verify_produk_state/verify_produk_state.dart';

class VerifyProdukBloc extends Bloc<VerifyProdukEvent, VerifyProdukState> {
  final VerifyProdukRepository verifyProdukRepository;

  VerifyProdukBloc({required this.verifyProdukRepository}) : super(VerifyProdukInitial()){
    on<GetVerify>((event, emit) async {
      emit(VerifyProdukLoading());
      try {
        var verifyProduk = await verifyProdukRepository.verifyProduk(event.idProduk);
        emit(VerifyProdukLoaded(verifyProduk));
      } catch (e) {
        emit(VerifyProdukError(e.toString()));
      }
    });
  }
}