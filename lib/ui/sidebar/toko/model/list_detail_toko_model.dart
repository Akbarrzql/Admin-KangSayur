// To parse this JSON data, do
//
//     final listDetailTokoModel = listDetailTokoModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ListDetailTokoModel listDetailTokoModelFromJson(String str) => ListDetailTokoModel.fromJson(json.decode(str));

String listDetailTokoModelToJson(ListDetailTokoModel data) => json.encode(data.toJson());

class ListDetailTokoModel {
  final String status;
  final String message;
  final Data data;

  ListDetailTokoModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ListDetailTokoModel.fromJson(Map<String, dynamic> json) => ListDetailTokoModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final SellerInfo sellerInfo;
  final TokoInfo tokoInfo;
  final List<Kategori> kategori;

  Data({
    required this.sellerInfo,
    required this.tokoInfo,
    required this.kategori,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    sellerInfo: SellerInfo.fromJson(json["seller_info"]),
    tokoInfo: TokoInfo.fromJson(json["toko_info"]),
    kategori: List<Kategori>.from(json["kategori"].map((x) => Kategori.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "seller_info": sellerInfo.toJson(),
    "toko_info": tokoInfo.toJson(),
    "kategori": List<dynamic>.from(kategori.map((x) => x.toJson())),
  };
}

class Kategori {
  final int id;
  final String namaKategori;

  Kategori({
    required this.id,
    required this.namaKategori,
  });

  factory Kategori.fromJson(Map<String, dynamic> json) => Kategori(
    id: json["id"],
    namaKategori: json["nama_kategori"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_kategori": namaKategori,
  };
}

class SellerInfo {
  final String namaSeller;
  final dynamic photoProfile;
  final String email;

  SellerInfo({
    required this.namaSeller,
    required this.photoProfile,
    required this.email,
  });

  factory SellerInfo.fromJson(Map<String, dynamic> json) => SellerInfo(
    namaSeller: json["nama_seller"],
    photoProfile: json["photo_profile"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "nama_seller": namaSeller,
    "photo_profile": photoProfile,
    "email": email,
  };
}

class TokoInfo {
  final String deksripsiToko;
  final String alamatToko;
  final JamOperasional jamOperasional;
  final String nomorTelepon;
  final String status;
  final String email;
  final String tanggalBergabung;
  final TitikKoordinat titikKoordinat;

  TokoInfo({
    required this.deksripsiToko,
    required this.alamatToko,
    required this.jamOperasional,
    required this.nomorTelepon,
    required this.status,
    required this.email,
    required this.tanggalBergabung,
    required this.titikKoordinat,
  });

  factory TokoInfo.fromJson(Map<String, dynamic> json) => TokoInfo(
    deksripsiToko: json["deksripsi_toko"],
    alamatToko: json["alamat_toko"],
    jamOperasional: JamOperasional.fromJson(json["jam_operasional"]),
    nomorTelepon: json["nomor_telepon"],
    status: json["status"],
    email: json["email"],
    tanggalBergabung: json["tanggal_bergabung"],
    titikKoordinat: TitikKoordinat.fromJson(json["titik_koordinat"]),
  );

  Map<String, dynamic> toJson() => {
    "deksripsi_toko": deksripsiToko,
    "alamat_toko": alamatToko,
    "jam_operasional": jamOperasional.toJson(),
    "nomor_telepon": nomorTelepon,
    "status": status,
    "email": email,
    "tanggal_bergabung": tanggalBergabung,
    "titik_koordinat": titikKoordinat.toJson(),
  };
}

class JamOperasional {
  final String open;
  final String close;

  JamOperasional({
    required this.open,
    required this.close,
  });

  factory JamOperasional.fromJson(Map<String, dynamic> json) => JamOperasional(
    open: json["open"],
    close: json["close"],
  );

  Map<String, dynamic> toJson() => {
    "open": open,
    "close": close,
  };
}

class TitikKoordinat {
  final double longitude;
  final double latitude;

  TitikKoordinat({
    required this.longitude,
    required this.latitude,
  });

  factory TitikKoordinat.fromJson(Map<String, dynamic> json) => TitikKoordinat(
    longitude: json["longitude"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "longitude": longitude,
    "latitude": latitude,
  };
}
