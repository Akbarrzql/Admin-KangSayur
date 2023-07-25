// To parse this JSON data, do
//
//     final listTokoModel = listTokoModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ListTokoModel listTokoModelFromJson(String str) => ListTokoModel.fromJson(json.decode(str));

String listTokoModelToJson(ListTokoModel data) => json.encode(data.toJson());

class ListTokoModel {
  final String status;
  final String message;
  final List<Datum> data;

  ListTokoModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ListTokoModel.fromJson(Map<String, dynamic> json) => ListTokoModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final int id;
  final String imgProfile;
  final String namaToko;
  final String namaPemilik;
  final String alamat;
  final int visited;

  Datum({
    required this.id,
    required this.imgProfile,
    required this.namaToko,
    required this.namaPemilik,
    required this.alamat,
    required this.visited,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    imgProfile: json["img_profile"],
    namaToko: json["nama_toko"],
    namaPemilik: json["nama_pemilik"],
    alamat: json["alamat"],
    visited: json["visited"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "img_profile": imgProfile,
    "nama_toko": namaToko,
    "nama_pemilik": namaPemilik,
    "alamat": alamat,
    "visited": visited,
  };
}
