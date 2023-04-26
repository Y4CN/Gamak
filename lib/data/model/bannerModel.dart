import 'package:game_hacks_chat/constant/mainAddress.dart';

class BannerModel {
  String collectionId;
  String id;
  String image;
  String title;

  BannerModel(
      {required this.collectionId,
      required this.id,
      required this.image,
      required this.title});

  factory BannerModel.fromJson(Map<String, dynamic> jsonData) {
    return BannerModel(
      collectionId: jsonData['collectionId'],
      id: jsonData['id'],
      image:
          '${MainAddress.apiAddress}files/${jsonData['collectionId']}/${jsonData['id']}/${jsonData['image']}',
      title: jsonData['title'],
    );
  }
}


    //  "collectionId": "lnjzngjaqjxu2em",
    //         "collectionName": "banner_games",
    //         "created": "2023-04-15 03:55:50.604Z",
    //         "discount_price": "97,000",
    //         "id": "hv3xaazsa5licli",
    //         "image": "tf2_key_bRgI237dmH.png",
    //         "price": "100,000",
    //         "title": "TF2 Key",
    //         "updated": "2023-04-15 03:55:50.604Z"