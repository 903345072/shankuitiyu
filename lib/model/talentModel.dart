// To parse this JSON data, do
//
//     final talentModel = talentModelFromJson(jsonString);

import 'dart:convert';

TalentModel talentModelFromJson(String str) =>
    TalentModel.fromJson(json.decode(str));

String talentModelToJson(TalentModel data) => json.encode(data.toJson());

class TalentModel {
  String? msg;
  int? code;
  List<Datum>? data;

  TalentModel({
    this.msg,
    this.code,
    this.data,
  });

  factory TalentModel.fromJson(Map<String, dynamic> json) => TalentModel(
        msg: json["msg"],
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "code": code,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  BaseInfo? baseInfo;
  List<ZucaiTuijianMatch>? zucaiTuijianMatch;

  Datum({
    this.baseInfo,
    this.zucaiTuijianMatch,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        baseInfo: json["base_info"] == null
            ? null
            : BaseInfo.fromJson(json["base_info"]),
        zucaiTuijianMatch: json["zucai_tuijian_match"] == null
            ? []
            : List<ZucaiTuijianMatch>.from(json["zucai_tuijian_match"]!
                .map((x) => ZucaiTuijianMatch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "base_info": baseInfo?.toJson(),
        "zucai_tuijian_match": zucaiTuijianMatch == null
            ? []
            : List<dynamic>.from(zucaiTuijianMatch!.map((x) => x.toJson())),
      };
}

class BaseInfo {
  int? tuijianId;
  int? classfly;
  int? time;
  String? refund;
  int? type;
  int? click;
  String? subtitle;
  String? createdAt;
  int? score;
  int? columnId;
  List<Image_>? image;
  int? wl;
  int? sf;
  int? userId;
  String? endTime;
  String? result;
  int? preSale;
  int? billId;
  int? sort;
  int? zhishu;
  String? title;
  String? userName;
  String? userImg;
  Object? mingzhongRate;
  dynamic hong;
  int? count;
  dynamic talentRate;
  int? isAi;
  int? planEndTime;
  String? classflyDesc;
  int? isPay;
  int? isFree;
  int? serverTime;

  BaseInfo({
    this.tuijianId,
    this.classfly,
    this.time,
    this.refund,
    this.type,
    this.click,
    this.subtitle,
    this.createdAt,
    this.score,
    this.columnId,
    this.image,
    this.wl,
    this.sf,
    this.userId,
    this.endTime,
    this.result,
    this.preSale,
    this.billId,
    this.sort,
    this.zhishu,
    this.title,
    this.userName,
    this.userImg,
    this.mingzhongRate,
    this.hong,
    this.count,
    this.talentRate,
    this.isAi,
    this.planEndTime,
    this.classflyDesc,
    this.isPay,
    this.isFree,
    this.serverTime,
  });

  factory BaseInfo.fromJson(Map<String, dynamic> json) => BaseInfo(
        tuijianId: json["tuijian_id"],
        classfly: json["classfly"],
        time: json["time"],
        refund: json["refund"],
        type: json["type"],
        click: json["click"],
        subtitle: json["subtitle"],
        createdAt: json["created_at"],
        score: json["score"],
        columnId: json["column_id"],
        image: json["image"] == null
            ? []
            : List<Image_>.from(json["image"]!.map((x) => Image_.fromJson(x))),
        wl: json["wl"],
        sf: json["sf"],
        userId: json["user_id"],
        endTime: json["end_time"],
        result: json["result"],
        preSale: json["pre_sale"],
        billId: json["bill_id"],
        sort: json["sort"],
        zhishu: json["zhishu"],
        title: json["title"],
        userName: json["user_name"],
        userImg: json["user_img"],
        mingzhongRate: json["mingzhong_rate"],
        hong: json["hong"],
        count: json["count"],
        talentRate: json["talent_rate"],
        isAi: json["is_ai"],
        planEndTime: json["plan_end_time"],
        classflyDesc: json["classfly_desc"],
        isPay: json["is_pay"],
        isFree: json["is_free"],
        serverTime: json["server_time"],
      );

  Map<String, dynamic> toJson() => {
        "tuijian_id": tuijianId,
        "classfly": classfly,
        "time": time,
        "refund": refund,
        "type": type,
        "click": click,
        "subtitle": subtitle,
        "created_at": createdAt,
        "score": score,
        "column_id": columnId,
        "image": image == null
            ? []
            : List<dynamic>.from(image!.map((x) => x.toJson())),
        "wl": wl,
        "sf": sf,
        "user_id": userId,
        "end_time": endTime,
        "result": result,
        "pre_sale": preSale,
        "bill_id": billId,
        "sort": sort,
        "zhishu": zhishu,
        "title": title,
        "user_name": userName,
        "user_img": userImg,
        "mingzhong_rate": mingzhongRate,
        "hong": hong,
        "count": count,
        "talent_rate": talentRate,
        "is_ai": isAi,
        "plan_end_time": planEndTime,
        "classfly_desc": classflyDesc,
        "is_pay": isPay,
        "is_free": isFree,
        "server_time": serverTime,
      };
}

class Image_ {
  String? id;
  String? url;
  int? width;
  int? height;

  Image_({
    this.id,
    this.url,
    this.width,
    this.height,
  });

  factory Image_.fromJson(Map<String, dynamic> json) => Image_(
        id: json["id"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "width": width,
        "height": height,
      };
}

class ZucaiTuijianMatch {
  int? matchId;
  int? isReverse;
  int? homeTeamId;
  int? awayTeamId;
  String? matchTime;
  String? matchFutureTime;
  String? matchLongTime;
  int? getMatchTime;
  String? competitionName;
  String? homeTeamName;
  String? homeTeamLogo;
  String? awayTeamName;
  String? awayTeamLogo;
  int? groupNum;
  int? roundNum;
  int? isGuess;
  int? matchStatus;
  String? matchStatusDesc;
  List<int>? homeScores;
  List<int>? awayScores;
  String? issueNum;
  String? issueWeek;

  ZucaiTuijianMatch({
    this.matchId,
    this.isReverse,
    this.homeTeamId,
    this.awayTeamId,
    this.matchTime,
    this.matchFutureTime,
    this.matchLongTime,
    this.getMatchTime,
    this.competitionName,
    this.homeTeamName,
    this.homeTeamLogo,
    this.awayTeamName,
    this.awayTeamLogo,
    this.groupNum,
    this.roundNum,
    this.isGuess,
    this.matchStatus,
    this.matchStatusDesc,
    this.homeScores,
    this.awayScores,
    this.issueNum,
    this.issueWeek,
  });

  factory ZucaiTuijianMatch.fromJson(Map<String, dynamic> json) =>
      ZucaiTuijianMatch(
        matchId: json["match_id"],
        isReverse: json["is_reverse"],
        homeTeamId: json["home_team_id"],
        awayTeamId: json["away_team_id"],
        matchTime: json["match_time"],
        matchFutureTime: json["match_future_time"],
        matchLongTime: json["match_long_time"]!,
        getMatchTime: json["get_match_time"],
        competitionName: json["competition_name"],
        homeTeamName: json["home_team_name"],
        homeTeamLogo: json["home_team_logo"],
        awayTeamName: json["away_team_name"],
        awayTeamLogo: json["away_team_logo"],
        groupNum: json["group_num"],
        roundNum: json["round_num"],
        isGuess: json["is_guess"],
        matchStatus: json["match_status"],
        matchStatusDesc: json["match_status_desc"],
        homeScores: json["home_scores"] == null
            ? []
            : List<int>.from(json["home_scores"]!.map((x) => x)),
        awayScores: json["away_scores"] == null
            ? []
            : List<int>.from(json["away_scores"]!.map((x) => x)),
        issueNum: json["issue_num"],
        issueWeek: json["issue_week"],
      );

  Map<String, dynamic> toJson() => {
        "match_id": matchId,
        "is_reverse": isReverse,
        "home_team_id": homeTeamId,
        "away_team_id": awayTeamId,
        "match_time": matchTime,
        "match_future_time": matchFutureTime,
        "match_long_time": matchLongTime,
        "get_match_time": getMatchTime,
        "competition_name": competitionName,
        "home_team_name": homeTeamName,
        "home_team_logo": homeTeamLogo,
        "away_team_name": awayTeamName,
        "away_team_logo": awayTeamLogo,
        "group_num": groupNum,
        "round_num": roundNum,
        "is_guess": isGuess,
        "match_status": matchStatus,
        "match_status_desc": matchStatusDesc,
        "home_scores": homeScores == null
            ? []
            : List<dynamic>.from(homeScores!.map((x) => x)),
        "away_scores": awayScores == null
            ? []
            : List<dynamic>.from(awayScores!.map((x) => x)),
        "issue_num": issueNum,
        "issue_week": issueWeek,
      };
}
