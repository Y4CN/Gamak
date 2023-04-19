class PlatformModel {
  String id;
  String gameId;
  String platform;

  PlatformModel(
      {required this.gameId, required this.id, required this.platform});

  factory PlatformModel.fromJson(Map<String, dynamic> jsonData) {
    return PlatformModel(
      gameId: jsonData['game_id'],
      id: jsonData['id'],
      platform: jsonData['platform'],
    );
  }
}



// "collectionId": "jmmbej8k59svo9p",
//             "collectionName": "game_platform",
//             "created": "2023-04-19 08:42:27.255Z",
//             "game_id": "kes995n97qljspo",
//             "id": "w91kmawjayl8ymx",
//             "platform": "PS4",
//             "updated": "2023-04-19 08:42:27.255Z"