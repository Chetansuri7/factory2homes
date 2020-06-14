import 'package:factory2homes/models/carouselslider.dart';
import 'package:factory2homes/repository/slider_banners_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;

class CarouselSliderList extends StatefulWidget {
  @override
  _TopCategoriesListState createState() => _TopCategoriesListState();
}

class _TopCategoriesListState extends State<CarouselSliderList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CarouselSlider>>(
      future: getCarouselSlider(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? CarouselSliderBanner(
                carouselSlider: snapshot.data,
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

class CarouselSliderBanner extends StatelessWidget {
  final List<CarouselSlider> carouselSlider;

  CarouselSliderBanner({this.carouselSlider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Swiper(
        curve: Curves.fastOutSlowIn,
        autoplay: true,
        autoplayDelay: 3000,
        pagination: new SwiperPagination(
          margin: EdgeInsets.all(0),
            builder: DotSwiperPaginationBuilder(size: 7,activeColor: Colors.white,activeSize: 7,color: Colors.black38)),
        itemCount: carouselSlider.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(carouselSlider[index].carouselSliderImage,
                    fit: BoxFit.fill),
              ));
        },
      ),
    );
  }
}
