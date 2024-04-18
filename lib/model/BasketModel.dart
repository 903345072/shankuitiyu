// To parse this JSON data, do
//
//     final basketModel = basketModelFromJson(jsonString);

import 'dart:convert';

BasketModel basketModelFromJson(String str) =>
    BasketModel.fromJson(json.decode(str));

String basketModelToJson(BasketModel data) => json.encode(data.toJson());

class BasketModel {
  String? msg;
  int? code;
  Data? data;

  BasketModel({
    this.msg,
    this.code,
    this.data,
  });

  factory BasketModel.fromJson(Map<String, dynamic> json) => BasketModel(
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
  List<BasketListElement>? list;
  int? nowTime;

  Data({
    this.list,
    this.nowTime,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: json["list"] == null
            ? []
            : List<BasketListElement>.from(
                json["list"]!.map((x) => BasketListElement.fromJson(x))),
        nowTime: json["now_time"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "now_time": nowTime,
      };
}

class BasketListElement {
  int? id;
  int? competitionId;
  int? homeTeamId;
  int? awayTeamId;
  int? statusId;
  int? matchTime;
  int? surplusSeconds;
  int? neutral;
  int? kind;
  List<int>? homeScores;
  List<int>? awayScores;
  int? periodCount;
  int? mlive;
  int? intelligence;
  int? venueId;
  int? isGuess;
  int? level;
  int? matchTimeFinish;
  int? matchTimeNoFinish;
  int? isHaveIntelligence;
  int? basketballOddsId;
  dynamic homeOdds;
  dynamic awayOdds;
  String? useSeconds;
  String? useSecondsGmDate;
  String? roundNum;
  int? matchId;
  String? theMatchTime;
  String? competitionName;
  String? homeTeamName;
  String? awayTeamName;
  String? homeTeamLogo;
  String? awayTeamLogo;
  int? awayScoresSum;
  int? homeScoresSum;
  String? statusCn;
  int? planNum;
  int? isSubscribe;

  BasketListElement({
    this.id,
    this.competitionId,
    this.homeTeamId,
    this.awayTeamId,
    this.statusId,
    this.matchTime,
    this.surplusSeconds,
    this.neutral,
    this.kind,
    this.homeScores,
    this.awayScores,
    this.periodCount,
    this.mlive,
    this.intelligence,
    this.venueId,
    this.isGuess,
    this.level,
    this.matchTimeFinish,
    this.matchTimeNoFinish,
    this.isHaveIntelligence,
    this.basketballOddsId,
    this.homeOdds,
    this.awayOdds,
    this.useSeconds,
    this.useSecondsGmDate,
    this.roundNum,
    this.matchId,
    this.theMatchTime,
    this.competitionName,
    this.homeTeamName,
    this.awayTeamName,
    this.homeTeamLogo,
    this.awayTeamLogo,
    this.awayScoresSum,
    this.homeScoresSum,
    this.statusCn,
    this.planNum,
    this.isSubscribe,
  });

  factory BasketListElement.fromJson(Map<String, dynamic> json) =>
      BasketListElement(
        id: json["id"],
        competitionId: json["competition_id"],
        homeTeamId: json["home_team_id"],
        awayTeamId: json["away_team_id"],
        statusId: json["status_id"],
        matchTime: json["match_time"],
        surplusSeconds: json["surplus_seconds"],
        neutral: json["neutral"],
        kind: json["kind"],
        homeScores: json["home_scores"] == null
            ? []
            : List<int>.from(json["home_scores"]!.map((x) => x)),
        awayScores: json["away_scores"] == null
            ? []
            : List<int>.from(json["away_scores"]!.map((x) => x)),
        periodCount: json["period_count"],
        mlive: json["mlive"],
        intelligence: json["intelligence"],
        venueId: json["venue_id"],
        isGuess: json["is_guess"],
        level: json["level"],
        matchTimeFinish: json["match_time_finish"],
        matchTimeNoFinish: json["match_time_no_finish"],
        isHaveIntelligence: json["is_have_intelligence"],
        basketballOddsId: json["basketball_odds_id"],
        homeOdds: json["home_odds"],
        awayOdds: json["away_odds"],
        useSeconds: json["use_seconds"].toString(),
        useSecondsGmDate: json["use_seconds_gm_date"],
        roundNum: json["round_num"],
        matchId: json["match_id"],
        theMatchTime: json["the_match_time"],
        competitionName: json["competition_name"],
        homeTeamName: json["home_team_name"],
        awayTeamName: json["away_team_name"],
        homeTeamLogo: json["home_team_logo"],
        awayTeamLogo: json["away_team_logo"],
        awayScoresSum: json["away_scores_sum"],
        homeScoresSum: json["home_scores_sum"],
        statusCn: json["status_cn"]!,
        planNum: json["plan_num"],
        isSubscribe: json["is_subscribe"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "competition_id": competitionId,
        "home_team_id": homeTeamId,
        "away_team_id": awayTeamId,
        "status_id": statusId,
        "match_time": matchTime,
        "surplus_seconds": surplusSeconds,
        "neutral": neutral,
        "kind": kind,
        "home_scores": homeScores == null
            ? []
            : List<dynamic>.from(homeScores!.map((x) => x)),
        "away_scores": awayScores == null
            ? []
            : List<dynamic>.from(awayScores!.map((x) => x)),
        "period_count": periodCount,
        "mlive": mlive,
        "intelligence": intelligence,
        "venue_id": venueId,
        "is_guess": isGuess,
        "level": level,
        "match_time_finish": matchTimeFinish,
        "match_time_no_finish": matchTimeNoFinish,
        "is_have_intelligence": isHaveIntelligence,
        "basketball_odds_id": basketballOddsId,
        "home_odds": homeOdds,
        "away_odds": awayOdds,
        "use_seconds": useSeconds,
        "use_seconds_gm_date": useSecondsGmDate,
        "round_num": roundNum,
        "match_id": matchId,
        "the_match_time": theMatchTime,
        "competition_name": competitionName,
        "home_team_name": homeTeamName,
        "away_team_name": awayTeamName,
        "home_team_logo": homeTeamLogo,
        "away_team_logo": awayTeamLogo,
        "away_scores_sum": awayScoresSum,
        "home_scores_sum": homeScoresSum,
        "status_cn": statusCnValues.reverse[statusCn],
        "plan_num": planNum,
        "is_subscribe": isSubscribe,
      };
}

enum StatusCn { EMPTY }

final statusCnValues = EnumValues({"未": StatusCn.EMPTY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
