import 'package:factory2homes/cart/cart.dart';
import 'package:factory2homes/cart/cart_screen.dart';
import 'package:factory2homes/helpers/badge.dart';
import 'package:factory2homes/screens/product_detail_landing_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:factory2homes/models/product.dart';
import 'package:factory2homes/repository/product_api.dart';
import 'package:provider/provider.dart';

class HotProducts extends StatefulWidget {
  @override
  _TopCategoriesListState createState() => _TopCategoriesListState();
}

class _TopCategoriesListState extends State<HotProducts> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: getHotProducts(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? HotProductsView(
                hotProducts: snapshot.data,
              )
            : Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black26,
                ),
              );
      },
    );
  }
}

class HotProductsView extends StatelessWidget {
  final List<Product> hotProducts;

  HotProductsView({this.hotProducts});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.9,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemCount: hotProducts.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailLandingPage(hotProducts[index])));},
            child: Card(
              child: Column(
                children: <Widget>[
                  SizedBox(
                      height: 85,
                      width: double.infinity,
                      child: Image.network(
                        hotProducts[index].productPhoto,
                        fit: BoxFit.contain,
                      )),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 9, top: 5),
                    child: Text('Price: ${hotProducts[index].productSalePrice}'),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class AllHotProductsPage extends StatefulWidget {
  static const routeName = '/AllHotProductsPage';

  @override
  _AllHotProductsPageState createState() => _AllHotProductsPageState();
}

class _AllHotProductsPageState extends State<AllHotProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: FutureBuilder<List<Product>>(
        future: getHotProducts(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? AllHotProductsPageView(
                  allHotProducts: snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black26,
                  ),
                );
        },
      ),
    );
  }
}

class AllHotProductsPageView extends StatelessWidget {
  final List<Product> allHotProducts;

  AllHotProductsPageView({this.allHotProducts});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
        ),
        itemCount: allHotProducts.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailLandingPage(allHotProducts[index])));
            },
            child: Card(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 150,
                    child: Image.network(
                      allHotProducts[index].productPhoto,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Divider(),
                  Text(
                    allHotProducts[index].productName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        '₹: ${allHotProducts[index].productSalePrice}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      Text('MRP: ${allHotProducts[index].productListPrice}'),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
