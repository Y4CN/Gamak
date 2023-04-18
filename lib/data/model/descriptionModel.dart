class DescriptionModel {
  String id;
  String description;
  String gameId;

  DescriptionModel(
      {required this.description, required this.gameId, required this.id});

  factory DescriptionModel.fromJson(Map<String, dynamic> jsonData) {
    return DescriptionModel(
      description: jsonData['description'],
      gameId: jsonData['game_id'],
      id: jsonData['id'],
    );
  }
}

