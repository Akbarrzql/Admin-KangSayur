import 'package:admin_kangsayur/ui/sidebar/item/list_toko/event/take_down_event.dart';
import 'package:admin_kangsayur/ui/sidebar/item/list_toko/state/take_down_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/take_down_repository.dart';

class TakeDownPageBloc extends Bloc<TakeDownEvent, TakeDownState>{
  final TakeDownPageRepository takeDownPageRepository;

  TakeDownPageBloc({required this.takeDownPageRepository}) : super(InitialTakeDownState()){
    on<PostTakeDown>((event, emit) async {
      emit(IsLoadingTakeDown());
      try {
        var data = await takeDownPageRepository.postTakeDownProduk(event.tokoId, event.produkId, event.alasan);
        emit(IsLoadedTakeDown(data));
      } catch (e) {
        emit(IsErrorTakeDown(e.toString()));
      }
    });
  }
}