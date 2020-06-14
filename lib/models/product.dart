// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.productId,
    this.productSku,
    this.productName,
    this.productListPrice,
    this.productSalePrice,
    this.productDiscount,
    this.productTax,
    this.productPhoto,
    this.productDescription,
    this.productWarranty,
    this.productIsHotProduct,
    this.productIsNewArrival,

    this.quantity,
    this.id
  });

  int productId;
  String productSku;
  String productName;
  int productListPrice;
  int productSalePrice;
  int productDiscount;
  int productTax;
  String productPhoto;
  String productDescription;
  String productWarranty;
  int productIsHotProduct;
  int productIsNewArrival;
  int quantity;
  int id;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["productId"],
    productSku: json["productSKU"],
    productName: json["productName"],
    productListPrice: json["productListPrice"],
    productSalePrice: json["productSalePrice"],
    productDiscount: json["productDiscount"],
    productTax: json["productTax"],
    productPhoto: json["productPhoto"],
    productDescription: json["productDescription"],
    productWarranty: json["productWarranty"],
    productIsHotProduct: json["productIsHotProduct"],
    productIsNewArrival: json["productIsNewArrival"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "productSKU": productSku,
    "productName": productName,
    "productListPrice": productListPrice,
    "productSalePrice": productSalePrice,
    "productDiscount": productDiscount,
    "productTax": productTax,
    "productPhoto": productPhoto,
    "productDescription": productDescription,
    "productWarranty": productWarranty,
    "productIsHotProduct": productIsHotProduct,
    "productIsNewArrival": productIsNewArrival,
  };
}



