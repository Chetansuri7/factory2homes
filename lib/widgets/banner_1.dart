import 'package:factory2homes/models/carouselslider.dart';
import 'package:factory2homes/repository/slider_banners_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Banner1Slot extends StatefulWidget {
  @override
  _TopCategoriesListState createState() => _TopCategoriesListState();
}

class _TopCategoriesListState extends State<Banner1Slot> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Banner1>>(
      future: getBanner1(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? Banner1Image(
                banner1: snapshot.data,
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

class Banner1Image extends StatelessWidget {
  final List<Banner1> banner1;

  Banner1Image({this.banner1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: banner1.length,
          itemBuilder: (context, index) {
            return Card(
                elevation: 0,
                child: Container(
                  height: 165,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        banner1[index].banner1SlotImage,
                        fit: BoxFit.fill,
                      )),
                ));
          }),
    );
  }
}
