// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

List<Categories> categoriesFromJson(String str) => List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  Categories({
    this.id,
    this.categoryName,
    this.categoryIcon,
    this.categoryKeyword,
  });

  int id;
  String categoryName;
  String categoryIcon;
  CategoryKeyword categoryKeyword;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    id: json["id"],
    categoryName: json["categoryName"],
    categoryIcon: json["categoryIcon"],
    categoryKeyword: categoryKeywordValues.map[json["categoryKeyword"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryName": categoryName,
    "categoryIcon": categoryIcon,
    "categoryKeyword": categoryKeywordValues.reverse[categoryKeyword],
  };
}

enum CategoryKeyword { FRV1, HDPH }

final categoryKeywordValues = EnumValues({
  "FRV1": CategoryKeyword.FRV1,
  "HDPH": CategoryKeyword.HDPH
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
