// To parse this JSON data, do
//
//     final footMatchModel = footMatchModelFromJson(jsonString);

import 'dart:convert';

FootMatchModel footMatchModelFromJson(String str) =>
    FootMatchModel.fromJson(json.decode(str));

String footMatchModelToJson(FootMatchModel data) => json.encode(data.toJson());

class FootMatchModel {
  String? msg;
  int? code;
  footMatchElement? data;

  FootMatchModel({
    this.msg,
    this.code,
    this.data,
  });

  factory FootMatchModel.fromJson(Map<String, dynamic> json) => FootMatchModel(
        msg: json["msg"],
        code: json["code"],
        data: json["data"] == null
            ? null
            : footMatchElement.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "code": code,
        "data": data?.toJson(),
      };
}

class footMatchElement {
  int? id;
  int? seasonId;
  int? competitionId;
  int? homeTeamId;
  int? awayTeamId;
  int? statusId;
  int? matchTime;
  String? homeScores;
  String? awayScores;
  String? homePosition;
  String? awayPosition;
  int? coverageMlive;
  int? coverageIntelligence;
  int? coverageLineup;
  int? venueId;
  int? refereeId;
  int? stageId;
  int? groupNum;
  String? roundNum;
  int? isGuess;
  int? isBd;
  int? secondHalfTime;
  int? isPlanIndex;
  String? issueNum;
  int? isReverse;
  int? neutral;
  String? note;
  int? isHaveOvertime;
  int? isHavePenalty;
  String? incidents;
  Competition? competition;
  Team? homeTeam;
  Team? awayTeam;
  DateTime? getMatchTime;
  int? homeHalfScore;
  int? awayHalfScore;
  int? homeAllScore;
  int? awayAllScore;
  int? homeCorner;
  int? awayCorner;
  String? cornerScore;
  String? overtimeScore;
  String? penaltyScore;
  int? homeRedCard;
  int? awayRedCard;
  String? redCard;
  int? homeYellowCard;
  int? awayYellowCard;
  String? yellowCard;
  int? firstHalfTime;
  String? liveUrl;
  int? curTime;
  String? groupNumNew;
  String? roundNumTwo;
  String? roundNumOne;
  String? statusCn;
  String? winningTeam;
  String? referee;
  String? venue;
  int? isSubscribe;
  int? isCollection;
  int? planNum;

  footMatchElement({
    this.id,
    this.seasonId,
    this.competitionId,
    this.homeTeamId,
    this.awayTeamId,
    this.statusId,
    this.matchTime,
    this.homeScores,
    this.awayScores,
    this.homePosition,
    this.awayPosition,
    this.coverageMlive,
    this.coverageIntelligence,
    this.coverageLineup,
    this.venueId,
    this.refereeId,
    this.stageId,
    this.groupNum,
    this.roundNum,
    this.isGuess,
    this.isBd,
    this.secondHalfTime,
    this.isPlanIndex,
    this.issueNum,
    this.isReverse,
    this.neutral,
    this.note,
    this.isHaveOvertime,
    this.isHavePenalty,
    this.incidents,
    this.competition,
    this.homeTeam,
    this.awayTeam,
    this.getMatchTime,
    this.homeHalfScore,
    this.awayHalfScore,
    this.homeAllScore,
    this.awayAllScore,
    this.homeCorner,
    this.awayCorner,
    this.cornerScore,
    this.overtimeScore,
    this.penaltyScore,
    this.homeRedCard,
    this.awayRedCard,
    this.redCard,
    this.homeYellowCard,
    this.awayYellowCard,
    this.yellowCard,
    this.firstHalfTime,
    this.liveUrl,
    this.curTime,
    this.groupNumNew,
    this.roundNumTwo,
    this.roundNumOne,
    this.statusCn,
    this.winningTeam,
    this.referee,
    this.venue,
    this.isSubscribe,
    this.isCollection,
    this.planNum,
  });

  factory footMatchElement.fromJson(Map<String, dynamic> json) =>
      footMatchElement(
        id: json["id"],
        seasonId: json["season_id"],
        competitionId: json["competition_id"],
        homeTeamId: json["home_team_id"],
        awayTeamId: json["away_team_id"],
        statusId: json["status_id"],
        matchTime: json["match_time"],
        homeScores: json["home_scores"],
        awayScores: json["away_scores"],
        homePosition: json["home_position"],
        awayPosition: json["away_position"],
        coverageMlive: json["coverage_mlive"],
        coverageIntelligence: json["coverage_intelligence"],
        coverageLineup: json["coverage_lineup"],
        venueId: json["venue_id"],
        refereeId: json["referee_id"],
        stageId: json["stage_id"],
        groupNum: json["group_num"],
        roundNum: json["round_num"],
        isGuess: json["is_guess"],
        isBd: json["is_bd"],
        secondHalfTime: json["second_half_time"],
        isPlanIndex: json["is_plan_index"],
        issueNum: json["issue_num"],
        isReverse: json["is_reverse"],
        neutral: json["neutral"],
        note: json["note"],
        isHaveOvertime: json["is_have_overtime"],
        isHavePenalty: json["is_have_penalty"],
        incidents: json["incidents"],
        competition: json["competition"] == null
            ? null
            : Competition.fromJson(json["competition"]),
        homeTeam:
            json["home_team"] == null ? null : Team.fromJson(json["home_team"]),
        awayTeam:
            json["away_team"] == null ? null : Team.fromJson(json["away_team"]),
        getMatchTime: json["get_match_time"] == null
            ? null
            : DateTime.parse(json["get_match_time"]),
        homeHalfScore: json["home_half_score"],
        awayHalfScore: json["away_half_score"],
        homeAllScore: json["home_all_score"],
        awayAllScore: json["away_all_score"],
        homeCorner: json["home_corner"],
        awayCorner: json["away_corner"],
        cornerScore: json["corner_score"],
        overtimeScore: json["overtime_score"],
        penaltyScore: json["penalty_score"],
        homeRedCard: json["home_red_card"],
        awayRedCard: json["away_red_card"],
        redCard: json["red_card"],
        homeYellowCard: json["home_yellow_card"],
        awayYellowCard: json["away_yellow_card"],
        yellowCard: json["yellow_card"],
        firstHalfTime: json["first_half_time"],
        liveUrl: json["live_url"],
        curTime: json["cur_time"],
        groupNumNew: json["group_num_new"],
        roundNumTwo: json["round_num_two"],
        roundNumOne: json["round_num_one"],
        statusCn: json["status_cn"],
        winningTeam: json["winning_team"],
        referee: json["referee"],
        venue: json["venue"],
        isSubscribe: json["is_subscribe"],
        isCollection: json["is_collection"],
        planNum: json["plan_num"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "season_id": seasonId,
        "competition_id": competitionId,
        "home_team_id": homeTeamId,
        "away_team_id": awayTeamId,
        "status_id": statusId,
        "match_time": matchTime,
        "home_scores": homeScores,
        "away_scores": awayScores,
        "home_position": homePosition,
        "away_position": awayPosition,
        "coverage_mlive": coverageMlive,
        "coverage_intelligence": coverageIntelligence,
        "coverage_lineup": coverageLineup,
        "venue_id": venueId,
        "referee_id": refereeId,
        "stage_id": stageId,
        "group_num": groupNum,
        "round_num": roundNum,
        "is_guess": isGuess,
        "is_bd": isBd,
        "second_half_time": secondHalfTime,
        "is_plan_index": isPlanIndex,
        "issue_num": issueNum,
        "is_reverse": isReverse,
        "neutral": neutral,
        "note": note,
        "is_have_overtime": isHaveOvertime,
        "is_have_penalty": isHavePenalty,
        "incidents": incidents,
        "competition": competition?.toJson(),
        "home_team": homeTeam?.toJson(),
        "away_team": awayTeam?.toJson(),
        "get_match_time": getMatchTime?.toIso8601String(),
        "home_half_score": homeHalfScore,
        "away_half_score": awayHalfScore,
        "home_all_score": homeAllScore,
        "away_all_score": awayAllScore,
        "home_corner": homeCorner,
        "away_corner": awayCorner,
        "corner_score": cornerScore,
        "overtime_score": overtimeScore,
        "penalty_score": penaltyScore,
        "home_red_card": homeRedCard,
        "away_red_card": awayRedCard,
        "red_card": redCard,
        "home_yellow_card": homeYellowCard,
        "away_yellow_card": awayYellowCard,
        "yellow_card": yellowCard,
        "first_half_time": firstHalfTime,
        "live_url": liveUrl,
        "cur_time": curTime,
        "group_num_new": groupNumNew,
        "round_num_two": roundNumTwo,
        "round_num_one": roundNumOne,
        "status_cn": statusCn,
        "winning_team": winningTeam,
        "referee": referee,
        "venue": venue,
        "is_subscribe": isSubscribe,
        "is_collection": isCollection,
        "plan_num": planNum,
      };
}

class Team {
  int? id;
  String? nameZh;
  String? shortNameZh;
  String? logo;

  Team({
    this.id,
    this.nameZh,
    this.shortNameZh,
    this.logo,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        nameZh: json["name_zh"],
        shortNameZh: json["short_name_zh"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_zh": nameZh,
        "short_name_zh": shortNameZh,
        "logo": logo,
      };
}

class Competition {
  int? id;
  String? nameZh;
  String? shortNameZh;
  String? logo;
  String? primaryColor;
  String? secondaryColor;
  int? weight;
  int? type;

  Competition({
    this.id,
    this.nameZh,
    this.shortNameZh,
    this.logo,
    this.primaryColor,
    this.secondaryColor,
    this.weight,
    this.type,
  });

  factory Competition.fromJson(Map<String, dynamic> json) => Competition(
        id: json["id"],
        nameZh: json["name_zh"],
        shortNameZh: json["short_name_zh"],
        logo: json["logo"],
        primaryColor: json["primary_color"],
        secondaryColor: json["secondary_color"],
        weight: json["weight"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_zh": nameZh,
        "short_name_zh": shortNameZh,
        "logo": logo,
        "primary_color": primaryColor,
        "secondary_color": secondaryColor,
        "weight": weight,
        "type": type,
      };
}
