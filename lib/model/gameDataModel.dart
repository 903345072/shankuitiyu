// To parse this JSON data, do
//
//     final gameDataModel = gameDataModelFromJson(jsonString);

class CateCompetition {
  int? id;

  String? competitionLogo;
  int? matchesNum;
  String? competitionName;
  String? fullName;
  CateCompetition(
      {this.id,
      this.competitionLogo,
      this.matchesNum,
      this.competitionName,
      this.fullName});

  factory CateCompetition.fromJson(Map<String, dynamic> json) =>
      CateCompetition(
          id: json["id"],
          competitionLogo: json["logo"],
          matchesNum: json["matches_num"],
          competitionName: json["name_short"],
          fullName: json["name"]);

  Map<String, dynamic> toJson() => {
        "competition_id": id,
        "competition_logo": competitionLogo,
        "matches_num": matchesNum,
        "competition_name": competitionName,
      };
}

class gameData {
  int? id;

  String? cate_name;

  List<CateCompetition>? childs;

  gameData({
    this.cate_name,
    this.id,
    this.childs,
  });

  factory gameData.fromJson(Map<String, dynamic> json) => gameData(
        cate_name: json["name"],
        childs: json["childs"] == null
            ? []
            : List<CateCompetition>.from(
                json["childs"]!.map((x) => CateCompetition.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cate_name": cate_name,
        "id": id,
      };
}
