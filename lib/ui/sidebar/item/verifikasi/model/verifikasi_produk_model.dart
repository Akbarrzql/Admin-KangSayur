// To parse this JSON data, do
//
//     final verifikasiProdukModel = verifikasiProdukModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VerifikasiProdukModel verifikasiProdukModelFromJson(String str) => VerifikasiProdukModel.fromJson(json.decode(str));

String verifikasiProdukModelToJson(VerifikasiProdukModel data) => json.encode(data.toJson());

class VerifikasiProdukModel {
  final String statusCode;
  final String message;
  final List<Datum> data;

  VerifikasiProdukModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory VerifikasiProdukModel.fromJson(Map<String, dynamic> json) => VerifikasiProdukModel(
    statusCode: json["status_code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final int id;
  final String namaProduk;
  final dynamic rating;
  final int tokoId;
  final dynamic isOnsale;
  final int produkId;
  final String status;
  final List<Variant> variant;

  Datum({
    required this.id,
    required this.namaProduk,
    required this.rating,
    required this.tokoId,
    required this.isOnsale,
    required this.produkId,
    required this.status,
    required this.variant,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    namaProduk: json["nama_produk"],
    rating: json["rating"],
    tokoId: json["toko_id"],
    isOnsale: json["is_onsale"],
    produkId: json["produk_id"],
    status: json["status"],
    variant: List<Variant>.from(json["variant"].map((x) => Variant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_produk": namaProduk,
    "rating": rating,
    "toko_id": tokoId,
    "is_onsale": isOnsale,
    "produk_id": produkId,
    "status": status,
    "variant": List<dynamic>.from(variant.map((x) => x.toJson())),
  };
}

class Variant {
  final int id;
  final int productId;
  final String variantImg;
  final String variant;
  final String variantDesc;
  final int stok;
  final int hargaVariant;
  final DateTime createdAt;
  final DateTime updatedAt;

  Variant({
    required this.id,
    required this.productId,
    required this.variantImg,
    required this.variant,
    required this.variantDesc,
    required this.stok,
    required this.hargaVariant,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    id: json["id"],
    productId: json["product_id"],
    variantImg: json["variant_img"],
    variant: json["variant"],
    variantDesc: json["variant_desc"],
    stok: json["stok"],
    hargaVariant: json["harga_variant"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "variant_img": variantImg,
    "variant": variant,
    "variant_desc": variantDesc,
    "stok": stok,
    "harga_variant": hargaVariant,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
