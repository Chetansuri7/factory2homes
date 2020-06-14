import 'package:factory2homes/cart/cart.dart';
import 'package:factory2homes/cart/cartList.dart';
import 'package:factory2homes/cart/cart_screen.dart';
import 'package:factory2homes/helpers/badge.dart';
import 'package:factory2homes/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailLandingPage extends StatefulWidget {
  final Product product;

  ProductDetailLandingPage(this.product);

  @override
  _ProductDetailLandingPageState createState() =>
      _ProductDetailLandingPageState();
}

class _ProductDetailLandingPageState extends State<ProductDetailLandingPage> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            'Factory2Homes',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                child: ch,
                value: cart.itemListCount.toString(),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {Navigator.of(context).pushNamed(CartScreen.routeName);},
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image.network(this.widget.product.productPhoto),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(this.widget.product.productName),
                ),
              ),
              Divider(),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            '₹' + '${this.widget.product.productSalePrice}',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Center(
                        child: Text(
                            'MRP:' + '${this.widget.product.productListPrice}'),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(this.widget.product.productDescription),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 45.0,
          child: RaisedButton(
            onPressed: () {
              cart.addToCart(

                widget.product.productId,
                widget.product.productName,
                widget.product.productListPrice,
                widget.product.productSalePrice,
                widget.product.productSku,
                widget.product.quantity,
                widget.product.productDiscount,
                widget.product.productTax,
                widget.product.productPhoto,
              );

            },
            color: Colors.redAccent,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.card_travel,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    "ADD TO CART",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
