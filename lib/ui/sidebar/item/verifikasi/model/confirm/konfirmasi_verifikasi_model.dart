// To parse this JSON data, do
//
//     final konfirmasiVerifikasiModel = konfirmasiVerifikasiModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

KonfirmasiVerifikasiModel konfirmasiVerifikasiModelFromJson(String str) => KonfirmasiVerifikasiModel.fromJson(json.decode(str));

String konfirmasiVerifikasiModelToJson(KonfirmasiVerifikasiModel data) => json.encode(data.toJson());

class KonfirmasiVerifikasiModel {
  final String statusCode;
  final String message;
  final int data;

  KonfirmasiVerifikasiModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory KonfirmasiVerifikasiModel.fromJson(Map<String, dynamic> json) => KonfirmasiVerifikasiModel(
    statusCode: json["status_code"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": data,
  };
}
