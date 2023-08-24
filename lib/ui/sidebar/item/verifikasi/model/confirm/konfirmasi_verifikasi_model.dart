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
  final User user;

  KonfirmasiVerifikasiModel({
    required this.statusCode,
    required this.message,
    required this.data,
    required this.user,
  });

  factory KonfirmasiVerifikasiModel.fromJson(Map<String, dynamic> json) => KonfirmasiVerifikasiModel(
    statusCode: json["status_code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": data.toJson(),
    "user": user.toJson(),
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

class User {
  final int id;
  final String name;
  final String photo;
  final String email;
  final int phoneNumber;
  final String emailVerifiedAt;
  final int sandiId;
  final int jenisKelamin;
  final DateTime tanggalLahir;
  final String address;
  final double longitude;
  final double latitude;
  final String deviceToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.photo,
    required this.email,
    required this.phoneNumber,
    required this.emailVerifiedAt,
    required this.sandiId,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.deviceToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    photo: json["photo"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    emailVerifiedAt: json["email_verified_at"],
    sandiId: json["sandi_id"],
    jenisKelamin: json["jenis_kelamin"],
    tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
    address: json["address"],
    longitude: json["longitude"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
    deviceToken: json["device_token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photo": photo,
    "email": email,
    "phone_number": phoneNumber,
    "email_verified_at": emailVerifiedAt,
    "sandi_id": sandiId,
    "jenis_kelamin": jenisKelamin,
    "tanggal_lahir": tanggalLahir.toIso8601String(),
    "address": address,
    "longitude": longitude,
    "latitude": latitude,
    "device_token": deviceToken,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
