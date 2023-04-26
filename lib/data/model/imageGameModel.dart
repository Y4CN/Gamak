import 'package:game_hacks_chat/constant/mainAddress.dart';

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
      image: '${MainAddress.apiAddress}files/${jsonData['collectionId']}/${jsonData['id']}/${jsonData['image']}',
    );
  }
}