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
  final Data data;
  final String deviceToken;
  final String? fcmServiceKey;

  KonfirmasiVerifikasiModel({
    required this.statusCode,
    required this.message,
    required this.data,
    required this.deviceToken,
    required this.fcmServiceKey,
  });

  factory KonfirmasiVerifikasiModel.fromJson(Map<String, dynamic> json) => KonfirmasiVerifikasiModel(
    statusCode: json["status_code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    deviceToken: json["device_token"],
    fcmServiceKey: json["FCM_SERVICE_KEY"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": data.toJson(),
    "device_token": deviceToken,
    "FCM_SERVICE_KEY": fcmServiceKey,
  };
}

class Data {
  final List<String> registrationIds;
  final Notification notification;

  Data({
    required this.registrationIds,
    required this.notification,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    registrationIds: List<String>.from(json["registration_ids"].map((x) => x)),
    notification: Notification.fromJson(json["notification"]),
  );

  Map<String, dynamic> toJson() => {
    "registration_ids": List<dynamic>.from(registrationIds.map((x) => x)),
    "notification": notification.toJson(),
  };
}

class Notification {
  final String title;
  final String body;
  final bool contentAvailable;
  final String priority;

  Notification({
    required this.title,
    required this.body,
    required this.contentAvailable,
    required this.priority,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    title: json["title"],
    body: json["body"],
    contentAvailable: json["content_available"],
    priority: json["priority"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "body": body,
    "content_available": contentAvailable,
    "priority": priority,
  };
}
