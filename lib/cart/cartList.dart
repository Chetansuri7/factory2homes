import 'package:flutter/foundation.dart';
import 'package:factory2homes/cart/db_helpers.dart';

class CartProduct {
  int productId;
  String productSku;
  String productName;
  int productListPrice;
  int productSalePrice;
  int productDiscount;
  int productTax;
  String productPhoto;
  int quantity;
  String id;

  CartProduct(
      {this.productId,
      this.productSku,
      this.productName,
      this.productListPrice,
      this.productSalePrice,
      this.productDiscount,
      this.productTax,
      this.productPhoto,
      this.quantity,
      this.id});
}

class CartItems with ChangeNotifier {
  List<CartProduct> _cartitems = [];

  List<CartProduct> get cartItems {
    return [..._cartitems];
  }

  int get newCartitemListCount {
    return cartItems.length;
  }

  void addCartItems(
    int id,
    int productId,
    String productName,
    int productListPrice,
    int productSalePrice,
    String productSku,
    int quantity,
    int productDiscount,
    int productTax,
    String productPhoto,
  ) {
    final newCartList = CartProduct(
      id: DateTime.now().toString(),
      productId: productId,
      productSku: productSku,
      productName: productName,
      productListPrice: productListPrice,
      productSalePrice: productSalePrice,
      productDiscount: productDiscount,
      productTax: productTax,
      productPhoto: productPhoto.toString(),
      quantity: 1,
    );
    _cartitems.add(newCartList);
    notifyListeners();
    DBHelper.insert('cart', {
      'id': newCartList.id,
      'productId': newCartList.productId,
      'productName': newCartList.productName,
      'productListPrice': newCartList.productListPrice,
      'productSalePrice': newCartList.productSalePrice,
      'productSku': newCartList.productSku,
      'quantity': 10,
      'productDiscount': newCartList.productDiscount,
      'productTax': newCartList.productTax,
      'productPhoto': newCartList.productPhoto,
    });
  }

  Future<void> fetchAndSetCartItemsList() async {
    final dataList = await DBHelper.getCartData('cart');
    _cartitems = dataList
        .map((itemList) => CartProduct(
              productId: itemList['productId'],
              productName: itemList['productName'],
              productSalePrice: itemList['productSalePrice'],
              productListPrice: itemList['productListPrice'],
              productSku: itemList['productSku'],
              quantity: itemList['quantity'],
              productPhoto: itemList['productPhoto'],
            ))
        .toList();
    notifyListeners();
  }
}
