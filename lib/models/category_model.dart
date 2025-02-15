// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

// ignore_for_file: unused_import

import 'package:meta/meta.dart';
import 'dart:convert';

CategoryModel categoryModelFromJson(String str) {
  return CategoryModel.fromJson(json.decode(str));
  // you ca use - json.decode(str) or jsonDecode(str)
}

// String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  List<Category> categories;

  CategoryModel({
    required this.categories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //       "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  //     };
}

class Category {
  String name;
  List<String> subcategory;

  Category({
    required this.name,
    required this.subcategory,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        subcategory: List<String>.from(json["subcategory"].map((x) => x)),
      );

  // Map<String, dynamic> toJson() => {
  //       "name": name,
  //       "subcategory": List<dynamic>.from(subcategory.map((x) => x)),
  //     };
}
