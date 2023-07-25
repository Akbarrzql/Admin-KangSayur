import 'package:flutter/cupertino.dart';

@immutable
abstract class ListDetailTokoEvent {}

class GetListDetailToko extends ListDetailTokoEvent {
  final String idToko;

  GetListDetailToko(this.idToko);
}

class GetListDetailTokoBySearch extends ListDetailTokoEvent {
  final String keyword;

  GetListDetailTokoBySearch(this.keyword);
}