import 'package:admin_kangsayur/ui/sidebar/toko/event/list_toko_event.dart';
import 'package:admin_kangsayur/ui/sidebar/toko/repository/list_detail_toko_repository.dart';
import 'package:admin_kangsayur/ui/sidebar/toko/repository/produk_repository/produk_repository.dart';
import 'package:admin_kangsayur/ui/sidebar/toko/state/list_toko_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../event/produk_event/produk_event.dart';
import '../../state/produk_state/produk_state.dart';

class ProdukTokoBloc extends Bloc<ProdukPageEvent, ProdukPageState>{
  final ProdukTokoPageRepository produkTokoPageRepository;

  ProdukTokoBloc({required this.produkTokoPageRepository}) : super(InitialProdukState()){
    on<GetProduk>((event, emit) async {
      emit(IsLoadingProduk());
      try {
        var produkModel = await produkTokoPageRepository.produkToko(event.tokoId, event.kategoriId);
        emit(IsLoadedProduk(produkModel));
      } catch (e) {
        emit(IsErrorProduk(e.toString()));
      }
    });
  }


}