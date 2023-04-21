import 'package:game_hacks_chat/data/model/userModel.dart';

class TrickCommendModel {
  String id;
  String trickId;
  UserModel userModel;
  String commend;

  TrickCommendModel({
    required this.commend,
    required this.id,
    required this.trickId,
    required this.userModel,
  });

  factory TrickCommendModel.fromJson(Map<String, dynamic> jsonData) {
    return TrickCommendModel(
      commend: jsonData['commend'],
      id: jsonData['id'],
      trickId: jsonData['trick_id'],
      userModel: UserModel.fromJson(jsonData['expand']['user_id']),
    );
  }
}



        // {
        //     "collectionId": "obrlsen2qs6hgnh",
        //     "collectionName": "trick_commend",
        //     "commend": "this is a trick for cogs Trick ",
        //     "created": "2023-04-21 08:20:52.055Z",
        //     "expand": {
        //         "user_id": {
        //             "avatar": "img_0008_mYAYzZsDob.png",
        //             "collectionId": "_pb_users_auth_",
        //             "collectionName": "users",
        //             "created": "2023-04-15 03:38:58.366Z",
        //             "emailVisibility": false,
        //             "id": "kexnleai6cur57e",
        //             "name": "yasin",
        //             "updated": "2023-04-15 03:38:58.366Z",
        //             "username": "yasin12345",
        //             "verified": false
        //         }
        //     },
        //     "id": "dkliyhdgxfq214j",
        //     "trick_id": "14yg8mxaj5owzv0",
        //     "updated": "2023-04-21 08:20:52.055Z",
        //     "user_id": "kexnleai6cur57e"
        // }