// To parse this JSON data, do
//
//     final basketScreenModel = basketScreenModelFromJson(jsonString);

import 'dart:convert';

BasketScreenModel basketScreenModelFromJson(String str) =>
    BasketScreenModel.fromJson(json.decode(str));

String basketScreenModelToJson(BasketScreenModel data) =>
    json.encode(data.toJson());

class BasketScreenModel {
  String? msg;
  int? code;
  Data? data;

  BasketScreenModel({
    this.msg,
    this.code,
    this.data,
  });

  factory BasketScreenModel.fromJson(Map<String, dynamic> json) =>
      BasketScreenModel(
        msg: json["msg"],
        code: json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "code": code,
        "data": data?.toJson(),
      };
}

class Data {
  List<GetGuess>? hotMatch;
  List<AllMatched>? allMatch;
  List<GetGuess>? getGuess;

  Data({
    this.hotMatch,
    this.allMatch,
    this.getGuess,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        hotMatch: json["hot_match"] == null
            ? []
            : List<GetGuess>.from(
                json["hot_match"]!.map((x) => GetGuess.fromJson(x))),
        allMatch: json["all_match"] == null
            ? []
            : List<AllMatched>.from(
                json["all_match"]!.map((x) => AllMatched.fromJson(x))),
        getGuess: json["get_guess"] == null
            ? []
            : List<GetGuess>.from(
                json["get_guess"]!.map((x) => GetGuess.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "hot_match": hotMatch == null
            ? []
            : List<dynamic>.from(hotMatch!.map((x) => x.toJson())),
        "all_match": allMatch == null
            ? []
            : List<dynamic>.from(allMatch!.map((x) => x.toJson())),
        "get_guess": getGuess == null
            ? []
            : List<dynamic>.from(getGuess!.map((x) => x.toJson())),
      };
}

class AllMatched {
  String? initials;
  List<basketElement>? list;

  AllMatched({
    this.initials,
    this.list,
  });

  factory AllMatched.fromJson(Map<String, dynamic> json) => AllMatched(
        initials: json["initials"],
        list: json["list"] == null
            ? []
            : List<basketElement>.from(
                json["list"]!.map((x) => basketElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "initials": initials,
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class basketElement {
  int? competitionId;
  String? shortNameZh;
  String? nameZh;
  int? matchNum;
  String? logo;
  int? categoryId;
  int? checked = 1;

  basketElement({
    this.competitionId,
    this.shortNameZh,
    this.nameZh,
    this.matchNum,
    this.logo,
    this.categoryId,
  });

  factory basketElement.fromJson(Map<String, dynamic> json) => basketElement(
        competitionId: json["competition_id"],
        shortNameZh: json["short_name_zh"],
        nameZh: json["name_zh"],
        matchNum: json["match_num"],
        logo: json["logo"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "competition_id": competitionId,
        "short_name_zh": shortNameZh,
        "name_zh": nameZh,
        "match_num": matchNum,
        "logo": logo,
        "category_id": categoryId,
      };
}

class GetGuess {
  int? competitionId;
  String? shortNameZh;
  String? nameZh;
  int? checked = 1;

  GetGuess({
    this.competitionId,
    this.shortNameZh,
    this.nameZh,
  });

  factory GetGuess.fromJson(Map<String, dynamic> json) => GetGuess(
        competitionId: json["competition_id"],
        shortNameZh: json["short_name_zh"],
        nameZh: json["name_zh"],
      );

  Map<String, dynamic> toJson() => {
        "competition_id": competitionId,
        "short_name_zh": shortNameZh,
        "name_zh": nameZh,
      };
}
