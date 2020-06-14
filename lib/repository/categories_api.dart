import 'package:factory2homes/models/categories.dart';
import 'package:factory2homes/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

Future<List<Categories>> getCategoryList(http.Client client) async {
  final response =
  await client.get('https://androidapp.factory2homes.com/api/categories');
  return compute(parseCategory, response.body);
}


List<Categories> parseCategory(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Categories>((json) => Categories.fromJson(json)).toList();
}
///
Future<List<Product>> getCategoryByProduct(http.Client client, id) async {
  final response = await client.get('https://androidapp.factory2homes.com/api/get-products-by-category' + "/" + id.toString());
  return compute(parseProductByCategory, response.body);
}
List<Product> parseProductByCategory(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

///
Future<List<Categories>> getTopCategory(http.Client client) async {
  final response = await client.get('https://androidapp.factory2homes.com/api/get-category-by-top-banner');
  return compute(parseTopCategory, response.body);
}

List<Categories> parseTopCategory(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Categories>((json) => Categories.fromJson(json)).toList();
}
