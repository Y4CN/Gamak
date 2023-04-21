import 'package:game_hacks_chat/data/model/userModel.dart';

class TrickModel {
  String authorId;
  String description;
  String collectionId;
  UserModel userModel;
  String gameId;
  String id;
  List<String> images;
  String status;

  TrickModel({
    required this.authorId,
    required this.description,
    required this.gameId,
    required this.id,
    required this.images,
    required this.status,
    required this.userModel,
    required this.collectionId,
  });

  factory TrickModel.fromJson(Map<String, dynamic> jsonData) {
    return TrickModel(
      authorId: jsonData['author_id'],
      description: jsonData['description'],
      userModel: UserModel.fromJson(jsonData['expand']['author_id']),
      gameId: jsonData['game_id'],
      id: jsonData['id'],
      images: (jsonData['image'] as List<dynamic>)
          .map((e) =>
              'http://127.0.0.1:8090/api/files/${jsonData['collectionId']}/${jsonData['id']}/${e}')
          .toList()
          .cast<String>(),
      status: jsonData['status'],
      collectionId: jsonData['collectionId'],
    );
  }
}

// List<String> getListImage(Map<String, dynamic> map,
//     Map<String, String> collectionId, Map<String, String> id) {
//   List<String> imageLst = [];
//   map.forEach((key, value) {
//     imageLst
//         .add('http://127.0.0.1:8090/api/files/${collectionId}/${id}/${value}');
//   });
//   return imageLst;
// }



// "author_id": "kexnleai6cur57e",
//             "collectionId": "b76kipys2baeffa",
//             "collectionName": "trick_games",
//             "created": "2023-04-20 09:02:57.619Z",
//             "description": "dadadadad",
//             "expand": {
//                 "author_id": {
//                     "avatar": "img_0008_mYAYzZsDob.png",
//                     "collectionId": "_pb_users_auth_",
//                     "collectionName": "users",
//                     "created": "2023-04-15 03:38:58.366Z",
//                     "emailVisibility": false,
//                     "id": "kexnleai6cur57e",
//                     "name": "yasin",
//                     "updated": "2023-04-15 03:38:58.366Z",
//                     "username": "yasin12345",
//                     "verified": false
//                 }
//             },
//             "game_id": "vagjyvgtbhheppt",
//             "id": "2ndhwyitcf2qqd3",
//             "image": [
//                 "call_of_duty_warzone_game_pNY3FsKTXC.png",
//                 "warzone_2_Et2AXj3ILR.png"
//             ],
//             "status": "checking",
//             "updated": "2023-04-20 09:02:57.619Z"