import 'package:game_hacks_chat/constant/mainAddress.dart';

class ClientTrickModel {
  String id;
  String status;
  String authorId;
  String description;
  List<String> images;
  String title;

  ClientTrickModel({
    required this.authorId,
    required this.description,
    required this.id,
    required this.images,
    required this.status,
    required this.title,
  });

  factory ClientTrickModel.fromJson(Map<String, dynamic> jsonData) {
    return ClientTrickModel(
      authorId: jsonData['author_id'],
      description: jsonData['description'],
      id: jsonData['id'],
      images: (jsonData['image'] as List<dynamic>)
          .map((e) =>
              '${MainAddress.apiAddress}files/${jsonData['collectionId']}/${jsonData['id']}/${e}')
          .toList()
          .cast<String>(),
      status: jsonData['status'],
      title: jsonData['title'],
    );
  }
}




// {
//             "author_id": "kexnleai6cur57e",
//             "collectionId": "b76kipys2baeffa",
//             "collectionName": "trick_games",
//             "created": "2023-04-21 07:43:13.327Z",
//             "description": "این مثلا یک ترفند براد بازی کانتر استریک است ",
//             "game_id": "fevka2fmukvb41f",
//             "id": "14yg8mxaj5owzv0",
//             "image": [
//                 "csgo_Y7DfN28fCD.jpeg",
//                 "csgo3_QpAAfqSfQF.jpeg"
//             ],
//             "status": "good",
//             "title": "ترفندی برای بازی انتر استریک",
//             "updated": "2023-04-21 08:29:05.229Z"
//         }