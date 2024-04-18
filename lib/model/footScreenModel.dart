// To parse this JSON data, do
//
//     final footScreenModel = footScreenModelFromJson(jsonString);

import 'dart:convert';

FootScreenModel footScreenModelFromJson(String str) =>
    FootScreenModel.fromJson(json.decode(str));

String footScreenModelToJson(FootScreenModel data) =>
    json.encode(data.toJson());

class FootScreenModel {
  String? msg;
  int? code;
  Data? data;

  FootScreenModel({
    this.msg,
    this.code,
    this.data,
  });

  factory FootScreenModel.fromJson(Map<String, dynamic> json) =>
      FootScreenModel(
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
  List<GetBd>? hotMatch;
  List<AllMatch>? allMatch;
  List<GetBd>? getGuess;
  List<GetBd>? getBd;

  Data({
    this.hotMatch,
    this.allMatch,
    this.getGuess,
    this.getBd,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        hotMatch: json["hot_match"] == null
            ? []
            : List<GetBd>.from(
                json["hot_match"]!.map((x) => GetBd.fromJson(x))),
        allMatch: json["all_match"] == null
            ? []
            : List<AllMatch>.from(
                json["all_match"]!.map((x) => AllMatch.fromJson(x))),
        getGuess: json["get_guess"] == null
            ? []
            : List<GetBd>.from(
                json["get_guess"]!.map((x) => GetBd.fromJson(x))),
        getBd: json["get_bd"] == null
            ? []
            : List<GetBd>.from(json["get_bd"]!.map((x) => GetBd.fromJson(x))),
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
        "get_bd": getBd == null
            ? []
            : List<dynamic>.from(getBd!.map((x) => x.toJson())),
      };
}

class AllMatch {
  String? initials;
  List<GetBd>? list;

  AllMatch({
    this.initials,
    this.list,
  });

  factory AllMatch.fromJson(Map<String, dynamic> json) => AllMatch(
        initials: json["initials"],
        list: json["list"] == null
            ? []
            : List<GetBd>.from(json["list"]!.map((x) => GetBd.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "initials": initials,
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class GetBd {
  int? competitionId;
  String? shortNameZh;
  String? nameZh;
  int? matchNum;
  String? logo;
  int? categoryId;
  String? initials;
  int? checked = 1;

  GetBd({
    this.competitionId,
    this.shortNameZh,
    this.nameZh,
    this.matchNum,
    this.logo,
    this.categoryId,
    this.initials,
  });

  factory GetBd.fromJson(Map<String, dynamic> json) => GetBd(
        competitionId: json["competition_id"],
        shortNameZh: json["short_name_zh"],
        nameZh: json["name_zh"],
        matchNum: json["match_num"],
        logo: json["logo"],
        categoryId: json["category_id"],
        initials: json["initials"],
      );

  Map<String, dynamic> toJson() => {
        "competition_id": competitionId,
        "short_name_zh": shortNameZh,
        "name_zh": nameZh,
        "match_num": matchNum,
        "logo": logo,
        "category_id": categoryId,
        "initials": initials,
      };
}
