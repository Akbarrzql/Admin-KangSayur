import 'package:admin_kangsayur/ui/sidebar/item/list_toko/model/list_toko_model.dart';
import 'package:admin_kangsayur/ui/sidebar/toko/model/list_detail_toko_model.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ListDetailTokoPageState {}

class InitialListDetailTokoPageState extends ListDetailTokoPageState {}

class ListDetailTokoPageLoading extends ListDetailTokoPageState {}

class ListDetailTokoPageLoaded extends ListDetailTokoPageState {
  final ListDetailTokoModel listDetailTokoModel;

  ListDetailTokoPageLoaded(this.listDetailTokoModel);
}

class ListDetailTokoPageError extends ListDetailTokoPageState {
  final String errorMessage;

  ListDetailTokoPageError(this.errorMessage);
}
