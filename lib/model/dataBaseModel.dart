// To parse this JSON data, do
//
//     final dataBaseModel = dataBaseModelFromJson(jsonString);

import 'dart:convert';

DataBaseModel dataBaseModelFromJson(String str) =>
    DataBaseModel.fromJson(json.decode(str));

String dataBaseModelToJson(DataBaseModel data) => json.encode(data.toJson());

class DataBaseModel {
  String? msg;
  int? code;
  DataBaseDutm? data;

  DataBaseModel({
    this.msg,
    this.code,
    this.data,
  });

  factory DataBaseModel.fromJson(Map<String, dynamic> json) => DataBaseModel(
        msg: json["msg"],
        code: json["code"],
        data: json["data"] == null ? null : DataBaseDutm.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "code": code,
        "data": data?.toJson(),
      };
}

class DataBaseDutm {
  List<BlockName>? blockName;
  List<HotMatch>? hotMatch;
  List<HotCompetition>? hotCompetition;

  DataBaseDutm({
    this.blockName,
    this.hotMatch,
    this.hotCompetition,
  });

  factory DataBaseDutm.fromJson(Map<String, dynamic> json) => DataBaseDutm(
        blockName: json["block_name"] == null
            ? []
            : List<BlockName>.from(
                json["block_name"]!.map((x) => BlockName.fromJson(x))),
        hotMatch: json["hot_match"] == null
            ? []
            : List<HotMatch>.from(
                json["hot_match"]!.map((x) => HotMatch.fromJson(x))),
        hotCompetition: json["hot_competition"] == null
            ? []
            : List<HotCompetition>.from(json["hot_competition"]!
                .map((x) => HotCompetition.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "block_name": blockName == null
            ? []
            : List<dynamic>.from(blockName!.map((x) => x.toJson())),
        "hot_match": hotMatch == null
            ? []
            : List<dynamic>.from(hotMatch!.map((x) => x.toJson())),
        "hot_competition": hotCompetition == null
            ? []
            : List<dynamic>.from(hotCompetition!.map((x) => x.toJson())),
      };
}

class BlockName {
  int? categoryId;
  String? nameZh;
  String? categoryImg;

  BlockName({
    this.categoryId,
    this.nameZh,
    this.categoryImg,
  });

  factory BlockName.fromJson(Map<String, dynamic> json) => BlockName(
        categoryId: json["category_id"],
        nameZh: json["name_zh"],
        categoryImg: json["category_img"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "name_zh": nameZh,
        "category_img": categoryImg,
      };
}

class HotCompetition {
  int? competitionId;
  int? categoryId;
  int? countryId;
  String? nameZh;
  String? shortNameZh;
  String? logo;
  int? category;
  int? sort;
  String? createdAt;
  String? updatedAt;
  int? type;

  HotCompetition({
    this.competitionId,
    this.categoryId,
    this.countryId,
    this.nameZh,
    this.shortNameZh,
    this.logo,
    this.category,
    this.sort,
    this.createdAt,
    this.updatedAt,
    this.type,
  });

  factory HotCompetition.fromJson(Map<String, dynamic> json) => HotCompetition(
        competitionId: json["competition_id"],
        categoryId: json["category_id"],
        countryId: json["country_id"],
        nameZh: json["name_zh"],
        shortNameZh: json["short_name_zh"],
        logo: json["logo"],
        category: json["category"],
        sort: json["sort"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "competition_id": competitionId,
        "category_id": categoryId,
        "country_id": countryId,
        "name_zh": nameZh,
        "short_name_zh": shortNameZh,
        "logo": logo,
        "category": category,
        "sort": sort,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "type": type,
      };
}

class HotMatch {
  int? competitionId;
  String? shortNameZh;
  String? logo;
  int? matchesNum;

  HotMatch({
    this.competitionId,
    this.shortNameZh,
    this.logo,
    this.matchesNum,
  });

  factory HotMatch.fromJson(Map<String, dynamic> json) => HotMatch(
        competitionId: json["competition_id"],
        shortNameZh: json["short_name_zh"],
        logo: json["logo"],
        matchesNum: json["matches_num"],
      );

  Map<String, dynamic> toJson() => {
        "competition_id": competitionId,
        "short_name_zh": shortNameZh,
        "logo": logo,
        "matches_num": matchesNum,
      };
}
