import 'package:flutter/cupertino.dart';

@immutable
abstract class ListTokoEvent {}

class GetListToko extends ListTokoEvent {}

class GetListDetailTokoBySearch extends ListTokoEvent {
  final String keyword;

  GetListDetailTokoBySearch(this.keyword);
}