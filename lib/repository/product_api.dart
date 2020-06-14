
import 'package:factory2homes/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Product>> getProduct(http.Client client) async {
  final response = await client.get('https://androidapp.factory2homes.com/api/products');
  return compute(parseProduct, response.body);
}

List<Product> parseProduct(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}
///
Future<List<Product>> getHotProducts(http.Client client) async {
  final response = await client.get('https://androidapp.factory2homes.com/api/get-all-hot-products');
  return compute(parseProduct, response.body);
}

List<Product> parseHotProducts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}
