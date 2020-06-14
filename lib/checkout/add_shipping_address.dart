import 'package:factory2homes/checkout/add_shipping_address_api.dart';
import 'package:factory2homes/checkout/razorpay.dart';
import 'package:factory2homes/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddShippingAddress extends StatefulWidget {
  @override
  _AddShippingAddressState createState() => _AddShippingAddressState();
}

class _AddShippingAddressState extends State<AddShippingAddress> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: Theme.of(context).accentColor,
        leading: Text(''),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 28.0, right: 28.0, bottom: 14.0),
              child: Text('Shipping Address',
                  style:
                      TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
            ),
            Divider(
              height: 5.0,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: 'Enter your name', labelText: 'Enter your name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
                controller: addressController,
                maxLines: 3,
                decoration:
                    InputDecoration(hintText: 'Address', labelText: 'Address'),
              ),
            ),
            Column(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 320.0,
                  height: 45.0,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    color: Colors.redAccent,
                    onPressed: () async {
                      SharedPreferences _prefs = await SharedPreferences.getInstance();

                      var name = nameController.text;
                      var address = addressController.text;
                      var userId = _prefs.getInt('userId');
                      var result = await addShipping(name, address,userId.toString());

                      if (result['result'] == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PayViaRazorPay()));
                      }
                    },
                    child: Text('Make Payment',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
