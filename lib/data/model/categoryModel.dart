import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_hacks_chat/constant/mainAddress.dart';

class CategoryModel {
  String id;
  String title;
  String image;
  String color;

  CategoryModel(
      {required this.id,
      required this.color,
      required this.image,
      required this.title});

  factory CategoryModel.fromJson(Map<String, dynamic> jsonData) {
    return CategoryModel(
      id: jsonData['id'],
      color: jsonData['color'],
      image:
          '${MainAddress.apiAddress}files/${jsonData['collectionId']}/${jsonData['id']}/${jsonData['image']}',
      title: jsonData['title'],
    );
  }
}
