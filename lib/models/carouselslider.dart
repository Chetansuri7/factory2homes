import 'dart:convert';

List<CarouselSlider> carouselSliderFromJson(String str) => List<CarouselSlider>.from(json.decode(str).map((x) => CarouselSlider.fromJson(x)));

String carouselSliderToJson(List<CarouselSlider> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarouselSlider {
  CarouselSlider({
    this.id,
    this.carouselSliderName,
    this.carouselSliderImage,
    this.carouselSliderSlotNumber,
  });

  int id;
  String carouselSliderName;
  String carouselSliderImage;
  int carouselSliderSlotNumber;

  factory CarouselSlider.fromJson(Map<String, dynamic> json) => CarouselSlider(
    id: json["id"],
    carouselSliderName: json["carouselSliderName"],
    carouselSliderImage: json["carouselSliderImage"],
    carouselSliderSlotNumber: json["carouselSliderSlotNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "carouselSliderName": carouselSliderName,
    "carouselSliderImage": carouselSliderImage,
    "carouselSliderSlotNumber": carouselSliderSlotNumber,
  };
}

List<Banner1> banner1FromJson(String str) => List<Banner1>.from(json.decode(str).map((x) => Banner1.fromJson(x)));

String banner1ToJson(List<Banner1> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Banner1 {
  Banner1({
    this.id,
    this.banner1SlotName,
    this.banner1SlotImage,
  });

  int id;
  String banner1SlotName;
  String banner1SlotImage;

  factory Banner1.fromJson(Map<String, dynamic> json) => Banner1(
    id: json["id"],
    banner1SlotName: json["banner1slotName"],
    banner1SlotImage: json["banner1slotImage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "banner1slotName": banner1SlotName,
    "banner1slotImage": banner1SlotImage,
  };
}
