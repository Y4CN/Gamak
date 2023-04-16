import 'package:game_hacks_chat/data/model/categoryModel.dart';

class GameProductModel {
  String id;
  String categoryId;
  String image;
  String name;
  int rate;
  CategoryModel categoryModel;
  String mode;

  GameProductModel(
      {required this.categoryId,
      required this.id,
      required this.image,
      required this.rate,
      required this.name,
      required this.categoryModel,
      required this.mode});

  factory GameProductModel.fromJson(Map<String, dynamic> jsonData) {
    return GameProductModel(
      categoryId: jsonData['category_id'],
      id: jsonData['id'],
      image:
          'http://127.0.0.1:8090/api/files/${jsonData['collectionId']}/${jsonData['id']}/${jsonData['image']}',
      rate: jsonData['rate'],
      name: jsonData['name'],
      categoryModel: CategoryModel.fromJson(jsonData['expand']['category_id']),
      mode: jsonData['mode'],
    );
  }
}

            //   "category_id": "ileih7ti0udkzo7",
            // "collectionId": "j5teip9lua94ao4",
            // "collectionName": "games_product",
            // "created": "2023-04-15 05:07:53.652Z",
            // "expand": {
            //     "category_id": {
            //         "collectionId": "3utribq7q2bk3na",
            //         "collectionName": "category_games",
            //         "color": "CAD28E",
            //         "created": "2023-04-11 07:30:24.229Z",
            //         "id": "ileih7ti0udkzo7",
            //         "image": "gun_ttjjmxYam7.png",
            //         "title": "اكشن",
            //         "updated": "2023-04-12 11:18:21.287Z"
            //     }
            // },
            // "id": "fevka2fmukvb41f",
            // "image": "csgo_ICYv2neYO6.png",
            // "name": "Counter-Strike: Global Offensive",
            // "rate": 3,
            // "updated": "2023-04-15 05:59:27.948Z"