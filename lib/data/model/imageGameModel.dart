class ImageGameModel {
  String id;
  String image;
  String gameId;

  ImageGameModel({
    required this.gameId,
    required this.id,
    required this.image,
  });

  factory ImageGameModel.fromJson(Map<String, dynamic> jsonData) {
    return ImageGameModel(
      gameId: jsonData['game_id'],
      id: jsonData['id'],
      image: 'http://127.0.0.1:8090/api/files/${jsonData['collectionId']}/${jsonData['id']}/${jsonData['image']}',
    );
  }
}