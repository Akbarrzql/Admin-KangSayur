import 'package:admin_kangsayur/ui/sidebar/item/list_toko/model/list_toko_model.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ListTokoPageState {}

class InitialListTokoPageState extends ListTokoPageState {}

class ListTokoPageLoading extends ListTokoPageState {}

class ListTokoPageLoaded extends ListTokoPageState {
  final ListTokoModel listToko;

  ListTokoPageLoaded(this.listToko);
}

class ListTokoPageError extends ListTokoPageState {
  final String errorMessage;

  ListTokoPageError(this.errorMessage);
}

class ListDetailTokoPageFilter extends ListTokoPageState {
  final List<Datum> filteredListDetailTokoModel;

  ListDetailTokoPageFilter(this.filteredListDetailTokoModel);
}