import 'package:game_hacks_chat/constant/mainAddress.dart';

class UserModel {
  String avatar;
  String id;
  String name;
  String username;
  bool verified;

  UserModel({
    required this.avatar,
    required this.id,
    required this.name,
    required this.username,
    required this.verified,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      avatar: '${MainAddress.apiAddress}files/${jsonData['collectionId']}/${jsonData['id']}/${jsonData['avatar']}',
      id: jsonData['id'],
      name: jsonData['name'],
      username: jsonData['username'],
      verified: jsonData['verified'],
    );
  }
}