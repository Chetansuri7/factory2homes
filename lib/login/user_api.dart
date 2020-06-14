

import 'package:http/http.dart' as http;
import 'dart:convert';


Future loginUser(String email, String password) async {
  String url = 'https://androidapp.factory2homes.com/api/login';
  final response =  await http.post(url, body: {'email': email, 'password': password});
  print(response.body);
  var result = jsonDecode(response.body);
  return result;


}