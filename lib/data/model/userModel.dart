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
      avatar: 'http://127.0.0.1:8090/api/files/${jsonData['collectionId']}/${jsonData['id']}/${jsonData['avatar']}',
      id: jsonData['id'],
      name: jsonData['name'],
      username: jsonData['username'],
      verified: jsonData['verified'],
    );
  }
}