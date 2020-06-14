import 'package:factory2homes/cart/cart.dart';
import 'package:factory2homes/cart/cartList.dart';
import 'package:factory2homes/home_screen.dart';
import 'package:factory2homes/widgets/hot_products_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart/cart_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: CartItems()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Factory2Homes",
        theme: ThemeData(

          accentColor: Colors.redAccent,
          fontFamily: 'Lato',
        ),
        home: HomeScreen(),

        routes:{
          AllHotProductsPage.routeName: (ctx) => AllHotProductsPage(),
          CartScreen.routeName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
