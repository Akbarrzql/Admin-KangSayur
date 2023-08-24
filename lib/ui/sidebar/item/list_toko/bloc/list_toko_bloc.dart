import 'package:admin_kangsayur/ui/sidebar/item/list_toko/event/list_toko_event.dart';
import 'package:admin_kangsayur/ui/sidebar/item/list_toko/state/list_toko_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/list_toko_model.dart';
import '../repository/list_toko_repository.dart';

class ListTokoPageBloc extends Bloc<ListTokoEvent, ListTokoPageState>{
  final ListTokoPageRepository listTokoRepository;
  List<Datum> _filteredListTokoModel = [];
  ListTokoModel? _listTokoModel;

  ListTokoPageBloc({required this.listTokoRepository}) : super(InitialListTokoPageState()){
    on<GetListToko>((event, emit) async {
      emit(ListTokoPageLoading());
      try {
        var listTokoModel = await listTokoRepository.listToko();
        _listTokoModel = listTokoModel;
        emit(ListTokoPageLoaded(listTokoModel));
        print("berhasil");
      } catch (e) {
        print(e.toString());
        emit(ListTokoPageError(e.toString()));
      }
    });

    on<GetListDetailTokoBySearch>((event, emit) {
      final keyword = event.keyword.toLowerCase();

      if (_listTokoModel != null) {
        if (keyword.isNotEmpty) {
          _filteredListTokoModel = _listTokoModel!.data.where((produk) {
            final namaProduk = produk.namaToko.toString().toLowerCase();
            return namaProduk.contains(keyword);
          }).toList();
        } else {
          _filteredListTokoModel = _listTokoModel!.data;
        }
        emit(ListDetailTokoPageFilter(_filteredListTokoModel));
      }
    });
  }

}
