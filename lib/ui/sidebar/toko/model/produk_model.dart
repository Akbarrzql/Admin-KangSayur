// To parse this JSON data, do
//
//     final produkModel = produkModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProdukModel produkModelFromJson(String str) => ProdukModel.fromJson(json.decode(str));

String produkModelToJson(ProdukModel data) => json.encode(data.toJson());

class ProdukModel {
  final String status;
  final String message;
  final List<Produk> produk;

  ProdukModel({
    required this.status,
    required this.message,
    required this.produk,
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json) => ProdukModel(
    status: json["status"],
    message: json["message"],
    produk: List<Produk>.from(json["produk"].map((x) => Produk.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "produk": List<dynamic>.from(produk.map((x) => x.toJson())),
  };
}

class Produk {
  final int id;
  final String namaProduk;
  final double? rating;
  final int tokoId;
  final int isOnsale;
  final int productId;
  final String variantImg;
  final String variant;
  final String variantDesc;
  final int stok;
  final int hargaVariant;

  Produk({
    required this.id,
    required this.namaProduk,
    required this.rating,
    required this.tokoId,
    required this.isOnsale,
    required this.productId,
    required this.variantImg,
    required this.variant,
    required this.variantDesc,
    required this.stok,
    required this.hargaVariant,
  });

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
    id: json["id"],
    namaProduk: json["nama_produk"],
    rating: json["rating"]?.toDouble(),
    tokoId: json["toko_id"],
    isOnsale: json["is_onsale"],
    productId: json["product_id"],
    variantImg: json["variant_img"],
    variant: json["variant"],
    variantDesc: json["variant_desc"],
    stok: json["stok"],
    hargaVariant: json["harga_variant"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_produk": namaProduk,
    "rating": rating,
    "toko_id": tokoId,
    "is_onsale": isOnsale,
    "product_id": productId,
    "variant_img": variantImg,
    "variant": variant,
    "variant_desc": variantDesc,
    "stok": stok,
    "harga_variant": hargaVariant,
  };
}
