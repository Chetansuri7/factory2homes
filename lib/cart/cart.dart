
import 'package:factory2homes/cart/db_helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:factory2homes/models/product.dart';

class CartProductList {
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

  CartProductList(
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

class Cart with ChangeNotifier {
  Map<String, Product> _itemList = {};

  Map<String, Product> get ItemList {
    return {..._itemList};
  }

  int get itemListCount {
    return ItemList.length;
  }

  double get totalAmount {
    var total = 0.0;
    _itemList.forEach((key, cartItem) {
      total += cartItem.productListPrice * cartItem.quantity;
    });
    return total;
  }

  void addToCart(
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
    if (_itemList.containsKey(productId)) {
      _itemList.update(
          productId.toString(),
          (existingCartItem) => Product(
                productId: existingCartItem.productId,
                productName: productName,
                productListPrice: productListPrice,
                productSalePrice: productSalePrice,
                productSku: productSku,
                quantity: quantity + 1,
                productDiscount: productDiscount,
                productTax: productTax,
                productPhoto: productPhoto,
                id: existingCartItem.id,
              ));
    } else {
      _itemList.putIfAbsent(
          productId.toString(),
          () => Product(
                productId: productId,
                productName: productName,
                productListPrice: productListPrice,
                productSalePrice: productSalePrice,
                productSku: productSku,
                quantity: 1,
                productDiscount: productDiscount,
                productTax: productTax,
                productPhoto: productPhoto,
              ));
      notifyListeners();
      DBHelper.insert('cart', {
        'productId': productId,
        'productName': productName,
        'productListPrice': productListPrice,
        'productSalePrice': productSalePrice,
        'productSku': productSku,
        'quantity': quantity,
        'productDiscount': productDiscount,
        'productTax': productTax,
        'productPhoto': productPhoto,
      });
    }
  }

// Future<void> fetchAndSetCart() async {
//   final dataList = await DBHelper.getCartData('cart');
//   _itemList = dataList.map((itemList) =>
//       CartProduct(
//         productId: itemList['productId'],
//         productName: itemList['productName'],
//         productSalePrice: itemList['productSalePrice'],
//         productListPrice: itemList['productListPrice'],
//         productSku: itemList['productSku'],
//         quantity: itemList['quantity'],
//       )).toList();
//   notifyListeners();
// }
}
