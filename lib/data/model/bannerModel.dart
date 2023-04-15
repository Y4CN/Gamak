class BannerModel {
  String collectionId;
  String discountPrice;
  String id;
  String image;
  String price;
  String title;

  BannerModel(
      {required this.collectionId,
      required this.discountPrice,
      required this.id,
      required this.image,
      required this.price,
      required this.title});

  factory BannerModel.fromJson(Map<String, dynamic> jsonData) {
    return BannerModel(
      collectionId: jsonData['collectionId'],
      discountPrice: jsonData['discount_price'],
      id: jsonData['id'],
      image:
          'http://127.0.0.1:8090/api/files/${jsonData['collectionId']}/${jsonData['id']}/${jsonData['image']}',
      price: jsonData['price'],
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