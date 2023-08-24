// To parse this JSON data, do
//
//     final takeDownModel = takeDownModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TakeDownModel takeDownModelFromJson(String str) => TakeDownModel.fromJson(json.decode(str));

String takeDownModelToJson(TakeDownModel data) => json.encode(data.toJson());

class TakeDownModel {
  final int status;
  final String message;

  TakeDownModel({
    required this.status,
    required this.message,
  });

  factory TakeDownModel.fromJson(Map<String, dynamic> json) => TakeDownModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
