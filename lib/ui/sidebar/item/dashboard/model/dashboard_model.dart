// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  final String status;
  final String message;
  final TopDashboard topDashboard;

  DashboardModel({
    required this.status,
    required this.message,
    required this.topDashboard,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    status: json["status"],
    message: json["message"],
    topDashboard: TopDashboard.fromJson(json["top_dashboard"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "top_dashboard": topDashboard.toJson(),
  };
}

class TopDashboard {
  final int jumlahToko;
  final int produkVerifikasi;
  final int jumlahPengguna;
  final int pengirimanBerlangsung;

  TopDashboard({
    required this.jumlahToko,
    required this.produkVerifikasi,
    required this.jumlahPengguna,
    required this.pengirimanBerlangsung,
  });

  factory TopDashboard.fromJson(Map<String, dynamic> json) => TopDashboard(
    jumlahToko: json["jumlah_toko"],
    produkVerifikasi: json["produk_verifikasi"],
    jumlahPengguna: json["jumlah_pengguna"],
    pengirimanBerlangsung: json["pengiriman_berlangsung"],
  );

  Map<String, dynamic> toJson() => {
    "jumlah_toko": jumlahToko,
    "produk_verifikasi": produkVerifikasi,
    "jumlah_pengguna": jumlahPengguna,
    "pengiriman_berlangsung": pengirimanBerlangsung,
  };
}