// To parse this JSON data, do
//
//     final verifikasiDitolakModel = verifikasiDitolakModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VerifikasiDitolakModel verifikasiDitolakModelFromJson(String str) => VerifikasiDitolakModel.fromJson(json.decode(str));

String verifikasiDitolakModelToJson(VerifikasiDitolakModel data) => json.encode(data.toJson());

class VerifikasiDitolakModel {
  final String statusCode;
  final String message;
  final String alasan;

  VerifikasiDitolakModel({
    required this.statusCode,
    required this.message,
    required this.alasan,
  });

  factory VerifikasiDitolakModel.fromJson(Map<String, dynamic> json) => VerifikasiDitolakModel(
    statusCode: json["status_code"],
    message: json["message"],
    alasan: json["alasan"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "alasan": alasan,
  };
}
