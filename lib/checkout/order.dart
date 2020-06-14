import 'package:factory2homes/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Order {
  int id;
  int quantity;
  double amount;
  int productId;
  Product product = Product();
}

Future addOrderRazorPay(List<Product> cartProduct, double total) async {
  String url = 'https://androidapp.factory2homes.com/api/make-payment-razorpay';
  final response =
  await http.post(url, body: {
    'products': cartProduct.map((cp) => {
      'product_id': cp.productId,
      'user_id':3,
      'quantity': cp.quantity,
      'amount':cp.productSalePrice,

    })

  });
  print(response.body);
  var result = jsonDecode(response.body);
  return result;
}