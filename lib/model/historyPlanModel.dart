// To parse this JSON data, do
//
//     final historyPlanModel = historyPlanModelFromJson(jsonString);

import 'dart:convert';

HistoryPlanModel historyPlanModelFromJson(String str) =>
    HistoryPlanModel.fromJson(json.decode(str));

String historyPlanModelToJson(HistoryPlanModel data) =>
    json.encode(data.toJson());

class HistoryPlanModel {
  String? msg;
  int? code;
  List<historyDatum>? data;

  HistoryPlanModel({
    this.msg,
    this.code,
    this.data,
  });

  factory HistoryPlanModel.fromJson(Map<String, dynamic> json) =>
      HistoryPlanModel(
        msg: json["msg"],
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<historyDatum>.from(
                json["data"]!.map((x) => historyDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "code": code,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class historyDatum {
  BaseInfos? baseInfo;
  List<ZucaiTuijianMatch>? zucaiTuijianMatch;

  historyDatum({
    this.baseInfo,
    this.zucaiTuijianMatch,
  });

  factory historyDatum.fromJson(Map<String, dynamic> json) => historyDatum(
        baseInfo: json["base_info"] == null
            ? null
            : BaseInfos.fromJson(json["base_info"]),
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

class BaseInfos {
  int? id;
  int? userId;
  String? title;
  int? sf;
  String? refund;
  int? time;
  int? wl;
  int? click;
  int? fxNumber;
  int? dzNumber;
  int? classfly;
  String? classflyDesc;
  String? createdAt;
  int? columnId;
  int? tuijianId;
  String? talentRate;
  int? isFree;
  int? isPay;
  String? refundDesc;
  int? mingzhongRate;
  int? hong;
  String? releaseTime;

  BaseInfos({
    this.id,
    this.userId,
    this.title,
    this.sf,
    this.refund,
    this.time,
    this.wl,
    this.click,
    this.fxNumber,
    this.dzNumber,
    this.classfly,
    this.classflyDesc,
    this.createdAt,
    this.columnId,
    this.tuijianId,
    this.talentRate,
    this.isFree,
    this.isPay,
    this.refundDesc,
    this.mingzhongRate,
    this.hong,
    this.releaseTime,
  });

  factory BaseInfos.fromJson(Map<String, dynamic> json) => BaseInfos(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        sf: json["sf"],
        refund: json["refund"],
        time: json["time"],
        wl: json["wl"],
        click: json["click"],
        fxNumber: json["fx_number"],
        dzNumber: json["dz_number"],
        classfly: json["classfly"],
        classflyDesc: json["classfly_desc"],
        createdAt: json["created_at"],
        columnId: json["column_id"],
        tuijianId: json["tuijian_id"],
        talentRate: json["talent_rate"],
        isFree: json["is_free"],
        isPay: json["is_pay"],
        refundDesc: json["refund_desc"],
        mingzhongRate:
            json["mingzhong_rate"] != null && json["mingzhong_rate"] != ""
                ? json["mingzhong_rate"]
                : 0,
        hong: json["hong"],
        releaseTime: json["release_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "sf": sf,
        "refund": refund,
        "time": time,
        "wl": wl,
        "click": click,
        "fx_number": fxNumber,
        "dz_number": dzNumber,
        "classfly": classfly,
        "classfly_desc": classflyDesc,
        "created_at": createdAt,
        "column_id": columnId,
        "tuijian_id": tuijianId,
        "talent_rate": talentRate,
        "is_free": isFree,
        "is_pay": isPay,
        "refund_desc": refundDesc,
        "mingzhong_rate": mingzhongRate,
        "hong": hong,
        "release_time": releaseTime,
      };
}

class ZucaiTuijianMatch {
  int? id;
  int? tuijianId;
  int? eventId;
  int? matchNum;
  int? matchId;
  String? weekNumber;
  int? classfly;
  int? homeTeamId;
  int? isCompare;
  String? classflyDesc;
  int? competitionId;
  String? competitionName;
  int? awayTeamId;
  String? matchTime;
  int? homeScores;
  int? awayScores;
  String? homeTeamName;
  String? awayTeamName;
  String? roundNum;
  int? isReverse;
  String? matchFutureTime;
  String? matchLongTime;
  String? homeTeamLogo;
  String? awayTeamLogo;
  int? groupNum;
  String? issueNum;
  String? isGuess;
  String? competitionColor;

  ZucaiTuijianMatch({
    this.id,
    this.tuijianId,
    this.eventId,
    this.matchNum,
    this.matchId,
    this.weekNumber,
    this.classfly,
    this.homeTeamId,
    this.isCompare,
    this.classflyDesc,
    this.competitionId,
    this.competitionName,
    this.awayTeamId,
    this.matchTime,
    this.homeScores,
    this.awayScores,
    this.homeTeamName,
    this.awayTeamName,
    this.roundNum,
    this.isReverse,
    this.matchFutureTime,
    this.matchLongTime,
    this.homeTeamLogo,
    this.awayTeamLogo,
    this.groupNum,
    this.issueNum,
    this.isGuess,
    this.competitionColor,
  });

  factory ZucaiTuijianMatch.fromJson(Map<String, dynamic> json) =>
      ZucaiTuijianMatch(
        id: json["id"],
        tuijianId: json["tuijian_id"],
        eventId: json["event_id"],
        matchNum: json["match_num"],
        matchId: json["match_id"],
        weekNumber: json["week_number"],
        classfly: json["classfly"],
        homeTeamId: json["home_team_id"],
        isCompare: json["is_compare"],
        classflyDesc: json["classfly_desc"],
        competitionId: json["competition_id"],
        competitionName: json["competition_name"],
        awayTeamId: json["away_team_id"],
        matchTime: json["match_time"],
        homeScores: json["home_scores"],
        awayScores: json["away_scores"],
        homeTeamName: json["home_team_name"],
        awayTeamName: json["away_team_name"],
        roundNum: json["round_num"],
        isReverse: json["is_reverse"],
        matchFutureTime: json["match_future_time"],
        matchLongTime: json["match_long_time"],
        homeTeamLogo: json["home_team_logo"],
        awayTeamLogo: json["away_team_logo"],
        groupNum: json["group_num"],
        issueNum: json["issue_num"],
        isGuess: json["is_guess"],
        competitionColor: json["competition_color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tuijian_id": tuijianId,
        "event_id": eventId,
        "match_num": matchNum,
        "match_id": matchId,
        "week_number": weekNumber,
        "classfly": classfly,
        "home_team_id": homeTeamId,
        "is_compare": isCompare,
        "classfly_desc": classflyDesc,
        "competition_id": competitionId,
        "competition_name": competitionName,
        "away_team_id": awayTeamId,
        "match_time": matchTime,
        "home_scores": homeScores,
        "away_scores": awayScores,
        "home_team_name": homeTeamName,
        "away_team_name": awayTeamName,
        "round_num": roundNum,
        "is_reverse": isReverse,
        "match_future_time": matchFutureTime,
        "match_long_time": matchLongTime,
        "home_team_logo": homeTeamLogo,
        "away_team_logo": awayTeamLogo,
        "group_num": groupNum,
        "issue_num": issueNum,
        "is_guess": isGuess,
        "competition_color": competitionColor,
      };
}
