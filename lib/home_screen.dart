import 'package:factory2homes/cart/cart.dart';
import 'package:factory2homes/cart/cart_screen.dart';
import 'package:factory2homes/helpers/badge.dart';
import 'package:factory2homes/helpers/page_route_animation.dart';
import 'package:factory2homes/login/login_screen.dart';
import 'package:factory2homes/widgets/all_products_grid.dart';
import 'package:factory2homes/widgets/banner_1.dart';
import 'package:factory2homes/widgets/carousel_slider_main_banner.dart';
import 'package:factory2homes/widgets/hot_products_widget.dart';
import 'package:factory2homes/widgets/top_category_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          child: FlatButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Text('Login Screen'),
          ),
        ),
      ),
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
              height: 75,
              child: TopCategoriesList(),
            ),
            Container(
              height: 200,
              child: CarouselSliderList(),
            ),
            Container(
              child: InkWell(
                onTap: (){
                  Navigator.push(context,
                      PageRouteAnimation(widget: AllHotProductsPage()));
                },
                  child: Banner1Slot()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 0),
                  child: Text(
                    'Best Seller',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 4),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          PageRouteAnimation(widget: AllHotProductsPage()));
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
            Container(child: HotProducts()),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://androidapp.factory2homes.com/TestImages/5a0a3060cc63df0e.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(child: AllProduct()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Color(0xFF727C8E),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text("Search")),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), title: Text("Cart")),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text("Profile")),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu), title: Text("More")),
          ]),
    );
  }
}
