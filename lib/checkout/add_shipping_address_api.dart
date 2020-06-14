import 'package:http/http.dart' as http;
import 'dart:convert';

Future addShipping(String name, String address, String userId) async {
  String url = 'https://androidapp.factory2homes.com/api/shipping';
  final response =
      await http.post(url, body: {
        'name': name,
        'address': address,
        'userId':userId.toString(),
      });
  print(response.body);
  var result = jsonDecode(response.body);
  return result;
}
