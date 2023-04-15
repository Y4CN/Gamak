class GameProductModel {
  String id;
  String categoryId;
  String image;
  String title;
  int rate;

  GameProductModel(
      {required this.categoryId,
      required this.id,
      required this.image,
      required this.rate,
      required this.title});

  factory GameProductModel.fromJson(Map<String, dynamic> jsonData) {
    return GameProductModel(
      categoryId: jsonData['category_id'],
      id: jsonData['id'],
      image:
          'http://127.0.0.1:8090/api/files/${jsonData['collectionId']}/${jsonData['id']}/${jsonData['image']}',
      rate: jsonData['rate'],
      title: jsonData['title'],
    );
  }
}


  // "category_id": "ileih7ti0udkzo7",
  //           "collectionId": "j5teip9lua94ao4",
  //           "collectionName": "games_product",
  //           "created": "2023-04-15 05:07:53.652Z",
  //           "id": "fevka2fmukvb41f",
  //           "image": "csgo_ICYv2neYO6.png",
  //           "name": "Counter-Strike: Global Offensive",
  //           "rate": 0,
  //           "updated": "2023-04-15 05:07:53.652Z"