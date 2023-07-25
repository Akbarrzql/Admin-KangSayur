import 'package:admin_kangsayur/ui/sidebar/item/list_toko/event/list_toko_event.dart';
import 'package:admin_kangsayur/ui/sidebar/item/list_toko/state/list_toko_state.dart';
import 'package:admin_kangsayur/ui/sidebar/toko/event/list_toko_event.dart';
import 'package:admin_kangsayur/ui/sidebar/toko/repository/list_detail_toko_repository.dart';
import 'package:admin_kangsayur/ui/sidebar/toko/state/list_toko_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListDetailTokoPageBloc extends Bloc<ListDetailTokoEvent, ListDetailTokoPageState>{
  final ListTokoDetailPageRepository listTokoDetailPageRepository;

  ListDetailTokoPageBloc({required this.listTokoDetailPageRepository}) : super(InitialListDetailTokoPageState()){
    on<GetListDetailToko>((event, emit) async {
      emit(ListDetailTokoPageLoading());
      try {
        var listDetailTokoModel = await listTokoDetailPageRepository.listDetailToko(event.idToko);
        emit(ListDetailTokoPageLoaded(listDetailTokoModel));
      } catch (e) {
        emit(ListDetailTokoPageError(e.toString()));
      }
    });
  }

}
