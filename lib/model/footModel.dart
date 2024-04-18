// To parse this JSON data, do
//
//     final footModel = footModelFromJson(jsonString);

import 'dart:convert';

FootModel footModelFromJson(String str) => FootModel.fromJson(json.decode(str));

String footModelToJson(FootModel data) => json.encode(data.toJson());

class FootModel {
  String? msg;
  int? code;
  Data? data;

  FootModel({
    this.msg,
    this.code,
    this.data,
  });

  factory FootModel.fromJson(Map<String, dynamic> json) => FootModel(
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
  List<FootListElement>? list;
  int? nowTime;

  Data({
    this.list,
    this.nowTime,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: json["list"] == null
            ? []
            : List<FootListElement>.from(
                json["list"]!.map((x) => FootListElement.fromJson(x))),
        nowTime: json["now_time"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "now_time": nowTime,
      };
}

class FootListElement {
  int? isHaveIntelligence;
  Stats? stats;
  List<dynamic>? incidents;
  List<Tlive>? tlive;
  List<List<int>>? matchTrend;
  int? isHaveOvertime;
  int? matchId;
  int? neutral;
  String? note;
  int? groupNum;
  String? groupNumNew;
  int? isHaveBigData;
  int? competitionId;
  int? statusId;
  String? statusCn;
  String? beginTime;
  int? firstHalfTime;
  int? secondHalfTime;
  String? score;
  String? halfScore;
  int? homeCorner;
  int? awayCorner;
  String? cornerScore;
  int? homeRedCard;
  int? awayRedCard;
  String? redCard;
  int? homeYellowCard;
  int? awayYellowCard;
  String? yellowCard;
  String? overtimeScore;
  String? penaltyScore;
  int? isHavePenalty;
  int? planNum;
  int? isSubscribe;
  String? roundNumTwo;
  String? roundNumOne;
  String? roundNum;
  int? homeTeamId;
  int? awayTeamId;
  int? isLive;
  String? competitionName;
  String? homeTeamName;
  String? homeTeamLogo;
  String? homeTeamCountryLogo;
  String? awayTeamName;
  String? awayTeamLogo;
  String? awayTeamCountryLogo;
  String? competitionColor;
  String? matchBeginTime;
  String? winningTeam;
  AsiaDataClass? asiaData;
  AsiaDataClass? bsData;
  AsiaDataClass? euData;

  FootListElement({
    this.isHaveIntelligence,
    this.stats,
    this.incidents,
    this.tlive,
    this.matchTrend,
    this.isHaveOvertime,
    this.matchId,
    this.neutral,
    this.note,
    this.groupNum,
    this.groupNumNew,
    this.isHaveBigData,
    this.competitionId,
    this.statusId,
    this.statusCn,
    this.beginTime,
    this.firstHalfTime,
    this.secondHalfTime,
    this.score,
    this.halfScore,
    this.homeCorner,
    this.awayCorner,
    this.cornerScore,
    this.homeRedCard,
    this.awayRedCard,
    this.redCard,
    this.homeYellowCard,
    this.awayYellowCard,
    this.yellowCard,
    this.overtimeScore,
    this.penaltyScore,
    this.isHavePenalty,
    this.planNum,
    this.isSubscribe,
    this.roundNumTwo,
    this.roundNumOne,
    this.roundNum,
    this.homeTeamId,
    this.awayTeamId,
    this.isLive,
    this.competitionName,
    this.homeTeamName,
    this.homeTeamLogo,
    this.homeTeamCountryLogo,
    this.awayTeamName,
    this.awayTeamLogo,
    this.awayTeamCountryLogo,
    this.competitionColor,
    this.matchBeginTime,
    this.winningTeam,
    this.asiaData,
    this.bsData,
    this.euData,
  });

  factory FootListElement.fromJson(Map<String, dynamic> json) =>
      FootListElement(
        isHaveIntelligence: json["is_have_intelligence"],
        stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
        tlive: json["tlive"] == null
            ? []
            : List<Tlive>.from(json["tlive"]!.map((x) => Tlive.fromJson(x))),
        matchTrend: json["match_trend"] == null
            ? []
            : List<List<int>>.from(json["match_trend"]!
                .map((x) => List<int>.from(x.map((x) => x)))),
        isHaveOvertime: json["is_have_overtime"],
        matchId: json["match_id"],
        neutral: json["neutral"],
        note: json["note"],
        groupNum: json["group_num"],
        groupNumNew: json["group_num_new"],
        isHaveBigData: json["is_have_big_data"],
        competitionId: json["competition_id"],
        statusId: json["status_id"],
        statusCn: json["status_cn"],
        beginTime: json["begin_time"],
        firstHalfTime: json["first_half_time"],
        secondHalfTime: json["second_half_time"],
        score: json["score"],
        halfScore: json["half_score"],
        homeCorner: json["home_corner"],
        awayCorner: json["away_corner"],
        cornerScore: json["corner_score"],
        homeRedCard: json["home_red_card"],
        awayRedCard: json["away_red_card"],
        redCard: json["red_card"],
        homeYellowCard: json["home_yellow_card"],
        awayYellowCard: json["away_yellow_card"],
        yellowCard: json["yellow_card"],
        overtimeScore: json["overtime_score"],
        penaltyScore: json["penalty_score"],
        isHavePenalty: json["is_have_penalty"],
        planNum: json["plan_num"],
        isSubscribe: json["is_subscribe"],
        roundNumTwo: json["round_num_two"],
        roundNumOne: json["round_num_one"],
        roundNum: json["round_num"],
        homeTeamId: json["home_team_id"],
        awayTeamId: json["away_team_id"],
        isLive: json["is_live"],
        competitionName: json["competition_name"],
        homeTeamName: json["home_team_name"],
        homeTeamLogo: json["home_team_logo"],
        homeTeamCountryLogo: json["home_team_country_logo"],
        awayTeamName: json["away_team_name"],
        awayTeamLogo: json["away_team_logo"],
        awayTeamCountryLogo: json["away_team_country_logo"],
        competitionColor: json["competition_color"],
        matchBeginTime: json["match_begin_time"],
        winningTeam: json["winning_team"],
        asiaData: json["asia_data"] == null
            ? null
            : AsiaDataClass.fromJson(json["asia_data"]),
        bsData: json["bs_data"] == null
            ? null
            : AsiaDataClass.fromJson(json["bs_data"]),
        euData: json["eu_data"] == null
            ? null
            : AsiaDataClass.fromJson(json["eu_data"]),
      );

  Map<String, dynamic> toJson() => {
        "is_have_intelligence": isHaveIntelligence,
        "stats": stats?.toJson(),
        "incidents": incidents == null
            ? []
            : List<dynamic>.from(incidents!.map((x) => x)),
        "tlive": tlive == null
            ? []
            : List<dynamic>.from(tlive!.map((x) => x.toJson())),
        "match_trend": matchTrend == null
            ? []
            : List<dynamic>.from(
                matchTrend!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "is_have_overtime": isHaveOvertime,
        "match_id": matchId,
        "neutral": neutral,
        "note": note,
        "group_num": groupNum,
        "group_num_new": groupNumNew,
        "is_have_big_data": isHaveBigData,
        "competition_id": competitionId,
        "status_id": statusId,
        "status_cn": statusCn,
        "begin_time": beginTime,
        "first_half_time": firstHalfTime,
        "second_half_time": secondHalfTime,
        "score": score,
        "half_score": halfScore,
        "home_corner": homeCorner,
        "away_corner": awayCorner,
        "corner_score": cornerScore,
        "home_red_card": homeRedCard,
        "away_red_card": awayRedCard,
        "red_card": redCard,
        "home_yellow_card": homeYellowCard,
        "away_yellow_card": awayYellowCard,
        "yellow_card": yellowCard,
        "overtime_score": overtimeScore,
        "penalty_score": penaltyScore,
        "is_have_penalty": isHavePenalty,
        "plan_num": planNum,
        "is_subscribe": isSubscribe,
        "round_num_two": roundNumTwo,
        "round_num_one": roundNumOne,
        "round_num": roundNum,
        "home_team_id": homeTeamId,
        "away_team_id": awayTeamId,
        "is_live": isLive,
        "competition_name": competitionName,
        "home_team_name": homeTeamName,
        "home_team_logo": homeTeamLogo,
        "home_team_country_logo": homeTeamCountryLogo,
        "away_team_name": awayTeamName,
        "away_team_logo": awayTeamLogo,
        "away_team_country_logo": awayTeamCountryLogo,
        "competition_color": competitionColor,
        "match_begin_time": matchBeginTime,
        "winning_team": winningTeam,
        "asia_data": asiaData?.toJson(),
        "bs_data": bsData?.toJson(),
        "eu_data": euData?.toJson(),
      };
}

class AsiaDataClass {
  String? homeWinner;
  String? draw;
  String? awayWinner;

  AsiaDataClass({
    this.homeWinner,
    this.draw,
    this.awayWinner,
  });

  factory AsiaDataClass.fromJson(Map<String, dynamic> json) => AsiaDataClass(
        homeWinner: json["home_winner"],
        draw: json["draw"],
        awayWinner: json["away_winner"],
      );

  Map<String, dynamic> toJson() => {
        "home_winner": homeWinner,
        "draw": draw,
        "away_winner": awayWinner,
      };
}

class Stats {
  Away? home;
  Away? away;

  Stats({
    this.home,
    this.away,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        home: json["home"] == null ? null : Away.fromJson(json["home"]),
        away: json["away"] == null ? null : Away.fromJson(json["away"]),
      );

  Map<String, dynamic> toJson() => {
        "home": home?.toJson(),
        "away": away?.toJson(),
      };
}

class Away {
  int? attack;
  int? dangerAttack;
  int? possession;
  int? shootCenter;
  int? shootWay;
  int? red;
  int? yellow;
  int? corner;

  Away({
    this.attack,
    this.dangerAttack,
    this.possession,
    this.shootCenter,
    this.shootWay,
    this.red,
    this.yellow,
    this.corner,
  });

  factory Away.fromJson(Map<String, dynamic> json) => Away(
        attack: json["attack"],
        dangerAttack: json["danger_attack"],
        possession: json["possession"],
        shootCenter: json["shoot_center"],
        shootWay: json["shoot_way"],
        red: json["red"],
        yellow: json["yellow"],
        corner: json["corner"],
      );

  Map<String, dynamic> toJson() => {
        "attack": attack,
        "danger_attack": dangerAttack,
        "possession": possession,
        "shoot_center": shootCenter,
        "shoot_way": shootWay,
        "red": red,
        "yellow": yellow,
        "corner": corner,
      };
}

class Tlive {
  String? time;
  int? type;
  String? data;
  int? position;
  int? main;

  Tlive({
    this.time,
    this.type,
    this.data,
    this.position,
    this.main,
  });

  factory Tlive.fromJson(Map<String, dynamic> json) => Tlive(
        time: json["time"],
        type: json["type"],
        data: json["data"],
        position: json["position"],
        main: json["main"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "type": type,
        "data": data,
        "position": position,
        "main": main,
      };
}
