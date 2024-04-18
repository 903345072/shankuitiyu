// To parse this JSON data, do
//
//     final aiSwiperModel = aiSwiperModelFromJson(jsonString);

import 'dart:convert';

AiSwiperModel aiSwiperModelFromJson(String str) =>
    AiSwiperModel.fromJson(json.decode(str));

String aiSwiperModelToJson(AiSwiperModel data) => json.encode(data.toJson());

class AiSwiperModel {
  String? msg;
  int? code;
  List<AiSwiperDatum>? data;

  AiSwiperModel({
    this.msg,
    this.code,
    this.data,
  });

  factory AiSwiperModel.fromJson(Map<String, dynamic> json) => AiSwiperModel(
        msg: json["msg"],
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<AiSwiperDatum>.from(
                json["data"]!.map((x) => AiSwiperDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "code": code,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AiSwiperDatum {
  int? id;
  int? competitionId;
  int? homeTeamId;
  int? awayTeamId;
  String? matchTime;
  int? homeScores;
  int? awayScores;
  String? roundNum;
  int? groupNum;
  int? isGuess;
  int? statusId;
  int? isReverse;
  int? isPlanIndex;
  String? roundNumTwo;
  String? roundNumOne;
  String? groupNumNew;
  int? firstHalfTime;
  int? secondHalfTime;
  String? issueNum;
  double? bsDraw;
  String? zongJinQiu;
  int? matchId;
  int? getMatchTime;
  String? matchFutureTime;
  String? matchTimeThree;
  String? matchTimeTwo;
  String? competitionName;
  String? competitionLogo;
  int? competitionWeight;
  String? homeTeamName;
  String? awayTeamName;
  String? homeTeamLogo;
  String? awayTeamLogo;
  int? homeFirstHalfScores;
  int? awayFirstHalfScores;
  int? homeCorner;
  int? awayCorner;
  int? homeOvertimeScores;
  int? awayOvertimeScores;
  int? homePenaltyScores;
  int? awayPenaltyScores;
  String? statusCn;
  double? sasiaDraw;
  String? rangQiu;

  AiSwiperDatum({
    this.id,
    this.competitionId,
    this.homeTeamId,
    this.awayTeamId,
    this.matchTime,
    this.homeScores,
    this.awayScores,
    this.roundNum,
    this.groupNum,
    this.isGuess,
    this.statusId,
    this.isReverse,
    this.isPlanIndex,
    this.roundNumTwo,
    this.roundNumOne,
    this.groupNumNew,
    this.firstHalfTime,
    this.secondHalfTime,
    this.issueNum,
    this.bsDraw,
    this.zongJinQiu,
    this.matchId,
    this.getMatchTime,
    this.matchFutureTime,
    this.matchTimeThree,
    this.matchTimeTwo,
    this.competitionName,
    this.competitionLogo,
    this.competitionWeight,
    this.homeTeamName,
    this.awayTeamName,
    this.homeTeamLogo,
    this.awayTeamLogo,
    this.homeFirstHalfScores,
    this.awayFirstHalfScores,
    this.homeCorner,
    this.awayCorner,
    this.homeOvertimeScores,
    this.awayOvertimeScores,
    this.homePenaltyScores,
    this.awayPenaltyScores,
    this.statusCn,
    this.sasiaDraw,
    this.rangQiu,
  });

  factory AiSwiperDatum.fromJson(Map<String, dynamic> json) => AiSwiperDatum(
        id: json["id"],
        competitionId: json["competition_id"],
        homeTeamId: json["home_team_id"],
        awayTeamId: json["away_team_id"],
        matchTime: json["match_time"],
        homeScores: json["home_scores"],
        awayScores: json["away_scores"],
        roundNum: json["round_num"],
        groupNum: json["group_num"],
        isGuess: json["is_guess"],
        statusId: json["status_id"],
        isReverse: json["is_reverse"],
        isPlanIndex: json["is_plan_index"],
        roundNumTwo: json["round_num_two"],
        roundNumOne: json["round_num_one"],
        groupNumNew: json["group_num_new"],
        firstHalfTime: json["first_half_time"],
        secondHalfTime: json["second_half_time"],
        issueNum: json["issue_num"],
        bsDraw: json["bs_draw"]?.toDouble(),
        zongJinQiu: json["zong_jin_qiu"],
        matchId: json["match_id"],
        getMatchTime: json["get_match_time"],
        matchFutureTime: json["match_future_time"],
        matchTimeThree: json["match_time_three"],
        matchTimeTwo: json["match_time_two"],
        competitionName: json["competition_name"],
        competitionLogo: json["competition_logo"],
        competitionWeight: json["competition_weight"],
        homeTeamName: json["home_team_name"],
        awayTeamName: json["away_team_name"],
        homeTeamLogo: json["home_team_logo"],
        awayTeamLogo: json["away_team_logo"],
        homeFirstHalfScores: json["home_first_half_scores"],
        awayFirstHalfScores: json["away_first_half_scores"],
        homeCorner: json["home_corner"],
        awayCorner: json["away_corner"],
        homeOvertimeScores: json["home_overtime_scores"],
        awayOvertimeScores: json["away_overtime_scores"],
        homePenaltyScores: json["home_penalty_scores"],
        awayPenaltyScores: json["away_penalty_scores"],
        statusCn: json["status_cn"],
        sasiaDraw: json["sasia_draw"]?.toDouble(),
        rangQiu: json["rang_qiu"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "competition_id": competitionId,
        "home_team_id": homeTeamId,
        "away_team_id": awayTeamId,
        "match_time": matchTime,
        "home_scores": homeScores,
        "away_scores": awayScores,
        "round_num": roundNum,
        "group_num": groupNum,
        "is_guess": isGuess,
        "status_id": statusId,
        "is_reverse": isReverse,
        "is_plan_index": isPlanIndex,
        "round_num_two": roundNumTwo,
        "round_num_one": roundNumOne,
        "group_num_new": groupNumNew,
        "first_half_time": firstHalfTime,
        "second_half_time": secondHalfTime,
        "issue_num": issueNum,
        "bs_draw": bsDraw,
        "zong_jin_qiu": zongJinQiu,
        "match_id": matchId,
        "get_match_time": getMatchTime,
        "match_future_time": matchFutureTime,
        "match_time_three": matchTimeThree,
        "match_time_two": matchTimeTwo,
        "competition_name": competitionName,
        "competition_logo": competitionLogo,
        "competition_weight": competitionWeight,
        "home_team_name": homeTeamName,
        "away_team_name": awayTeamName,
        "home_team_logo": homeTeamLogo,
        "away_team_logo": awayTeamLogo,
        "home_first_half_scores": homeFirstHalfScores,
        "away_first_half_scores": awayFirstHalfScores,
        "home_corner": homeCorner,
        "away_corner": awayCorner,
        "home_overtime_scores": homeOvertimeScores,
        "away_overtime_scores": awayOvertimeScores,
        "home_penalty_scores": homePenaltyScores,
        "away_penalty_scores": awayPenaltyScores,
        "status_cn": statusCn,
        "sasia_draw": sasiaDraw,
        "rang_qiu": rangQiu,
      };
}
