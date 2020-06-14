import 'package:factory2homes/models/carouselslider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

Future<List<CarouselSlider>> getCarouselSlider(http.Client client) async {
  final response = await client.get('https://androidapp.factory2homes.com/api/carouselslider');
  return compute(parseCarouselSlider, response.body);
}


List<CarouselSlider> parseCarouselSlider(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<CarouselSlider>((json) => CarouselSlider.fromJson(json)).toList();
}
///
Future<List<Banner1>> getBanner1(http.Client client) async {
  final response = await client.get('https://androidapp.factory2homes.com/api/banner1slot');
  return compute(parseBanner1, response.body);
}


List<Banner1> parseBanner1(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Banner1>((json) => Banner1.fromJson(json)).toList();
}
///