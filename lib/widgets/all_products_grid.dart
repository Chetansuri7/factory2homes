import 'package:factory2homes/models/product.dart';
import 'package:factory2homes/repository/product_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllProduct extends StatefulWidget {
  @override
  _AllProductState createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: getProduct(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? AllProductGrid(
                product: snapshot.data,
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

class AllProductGrid extends StatelessWidget {
  final List<Product> product;

  AllProductGrid({this.product});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
        ),
        itemCount: product.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 150,
                  child: Image.network(
                    product[index].productPhoto,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Divider(),
                Text(
                  product[index].productName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      '₹: ${product[index].productSalePrice}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    Text('MRP: ${product[index].productListPrice}'),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
