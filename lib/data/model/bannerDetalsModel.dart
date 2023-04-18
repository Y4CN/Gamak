class BannerDetailsModel {
  String bannerId;
  String discountPrice;
  String id;
  String price;
  String title;
  String image;

  BannerDetailsModel({
    required this.bannerId,
    required this.discountPrice,
    required this.id,
    required this.price,
    required this.title,
    required this.image,
  });

  factory BannerDetailsModel.fromJson(Map<String, dynamic> jsonData) {
    return BannerDetailsModel(
      bannerId: jsonData['banner_id'],
      discountPrice: jsonData['discount_price'],
      id: jsonData['id'],
      price: jsonData['price'],
      title: jsonData['title'],
      image:
          'http://127.0.0.1:8090/api/files/${jsonData['collectionId']}/${jsonData['id']}/${jsonData['image']}',
    );
  }
}




      // "banner_id": "swuu7zng51pi6gn",
      //       "collectionId": "de4ncv100bd73oe",
      //       "collectionName": "banner_details",
      //       "created": "2023-04-18 06:24:11.095Z",
      //       "discount_price": "999,000",
      //       "id": "m5umnblrw0yrnr4",
      //       "image": "awp_oni_taiji_mkYMKgpEXr.png",
      //       "price": "1,000,000",
      //       "title": "AWP | Oni Taiji",
      //       "updated": "2023-04-18 06:31:40.169Z"