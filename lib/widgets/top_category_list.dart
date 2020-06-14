import 'package:factory2homes/models/categories.dart';
import 'package:factory2homes/repository/categories_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TopCategoriesList extends StatefulWidget {
  @override
  _TopCategoriesListState createState() => _TopCategoriesListState();
}

class _TopCategoriesListState extends State<TopCategoriesList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Categories>>(
      future: getTopCategory(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? TopCategoryGrid(
          topCategories: snapshot.data,
        )
            : Center(
                child: CircularProgressIndicator(backgroundColor: Colors.black26,),
              );
      },
    );
  }
}

class TopCategoryGrid extends StatelessWidget {
  final List<Categories> topCategories;

  TopCategoryGrid({this.topCategories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10.0,right: 10),
      child: ListView.builder(
        itemCount: topCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Card(
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width/6
                  ,
                  child: Image.network(topCategories[index].categoryIcon),
                ),
              ),
              Text(
              topCategories[index].categoryName,
                style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
              ),
            ],
          );
          }),
    );
  }
}
