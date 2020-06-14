import 'package:factory2homes/cart/cart.dart';
import 'package:factory2homes/checkout/add_shipping_address.dart';
import 'package:factory2homes/checkout/razorpay.dart';
import 'package:factory2homes/login/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cartscreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  
  void _checkOut() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int _userId = _prefs.getInt('userId');
    if (_userId != null && _userId > 0) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PayViaRazorPay()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Chip(
                    backgroundColor: Colors.lightBlueAccent,
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  FlatButton(
                    color: Colors.lightBlueAccent,
                    child: Text(
                      'Order Now',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PayViaRazorPay(cart: cart,)));
                    },
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                  color: Colors.green,
                );
              },
              itemCount: cart.ItemList.length,
              itemBuilder: (context, index) => Container(
                height: MediaQuery.of(context).size.height / 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            cart.ItemList.values.toList()[index].productPhoto,
                            fit: BoxFit.fitHeight,
                          )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            cart.ItemList.values.toList()[index].productName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height / 20,
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {},
                                      iconSize: 10,
                                    ),
                                    Text(
                                      '${cart.ItemList.values.toList()[index].quantity}',
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {},
                                        iconSize: 10),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 20,
                            child: RaisedButton(
                                color: Colors.redAccent,
                                child: Text(
                                  'Remove',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {}),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 5,
                      child: Center(
                        child: Text(
                            '${cart.ItemList.values.toList()[index].productSalePrice * cart.ItemList.values.toList()[index].quantity}'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
