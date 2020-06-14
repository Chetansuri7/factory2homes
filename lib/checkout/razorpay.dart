import 'package:factory2homes/cart/cart.dart';
import 'package:factory2homes/checkout/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:fluttertoast/fluttertoast.dart';

class PayViaRazorPay extends StatefulWidget {
  final Cart cart;

  PayViaRazorPay({this.cart});

  @override
  _PayViaRazorPayState createState() => _PayViaRazorPayState();
}

class _PayViaRazorPayState extends State<PayViaRazorPay> {
  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Razorpay Sample App'),
      ),
      body: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            RaisedButton(onPressed: openCheckout, child: Text('Open'))
          ])),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    final cart = Provider.of<Cart>(context);
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': cart.totalAmount*100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {


    Fluttertoast.showToast(
      msg: "SUCCESS: " + response.paymentId,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "ERROR: " + response.code.toString() + " - " + response.message,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('Payment done via wallet, order placed');
    Fluttertoast.showToast(msg: "EXTERNAL_WALLET: " + response.walletName);
  }
}
