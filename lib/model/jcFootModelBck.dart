// To parse this JSON data, do
//
//     final jcFootModel = jcFootModelFromJson(jsonString);

import 'dart:convert';

import 'package:jingcai_app/model/jcFootMetModel.dart';

JcFootModel jcFootModelFromJson(String str) =>
    JcFootModel.fromJson(json.decode(str));

String jcFootModelToJson(JcFootModel data) => json.encode(data.toJson());

class JcFootModel {
  int? id;
  int? refereeId;
  int? leagueId;
  int? countryId;
  int? venueId;
  int? seasonId;
  int? stageId;
  int? roundId;
  String? timezone;
  int? startAt;
  dynamic currentPeriodStartAt;
  int? homeTeamId;
  int? awayTeamId;
  int? statusId;
  dynamic elapsed;
  dynamic currentScore;
  dynamic halfScore;
  dynamic fullScore;
  dynamic extraScore;
  dynamic penaltyScore;
  dynamic winner;
  int? hasLiveScore;
  Team? homeTeam;
  Team? awayTeam;
  Leagues? leagues;
  String rangqiu = '0';
  String matchNumStr = '0';
  JcFootMetModel? jcFootMetModel_;
  setJcFootMetModel(JcFootMetModel d) {
    jcFootMetModel_ = d;
  }

  JcFootModel({
    this.id,
    this.refereeId,
    this.leagueId,
    this.countryId,
    this.venueId,
    this.seasonId,
    this.stageId,
    this.roundId,
    this.timezone,
    this.startAt,
    this.currentPeriodStartAt,
    this.homeTeamId,
    this.awayTeamId,
    this.statusId,
    this.elapsed,
    this.currentScore,
    this.halfScore,
    this.fullScore,
    this.extraScore,
    this.penaltyScore,
    this.winner,
    this.hasLiveScore,
    this.homeTeam,
    this.awayTeam,
    this.leagues,
  });

  factory JcFootModel.fromJson(Map<String, dynamic> json) => JcFootModel(
        id: json["id"],
        refereeId: json["referee_id"],
        leagueId: json["league_id"],
        countryId: json["country_id"],
        venueId: json["venue_id"],
        seasonId: json["season_id"],
        stageId: json["stage_id"],
        roundId: json["round_id"],
        timezone: json["timezone"],
        startAt: json["start_at"],
        currentPeriodStartAt: json["current_period_start_at"],
        homeTeamId: json["home_team_id"],
        awayTeamId: json["away_team_id"],
        statusId: json["status_id"],
        elapsed: json["elapsed"],
        currentScore: json["current_score"],
        halfScore: json["half_score"],
        fullScore: json["full_score"],
        extraScore: json["extra_score"],
        penaltyScore: json["penalty_score"],
        winner: json["winner"],
        hasLiveScore: json["has_live_score"],
        homeTeam:
            json["home_team"] == null ? null : Team.fromJson(json["home_team"]),
        awayTeam:
            json["away_team"] == null ? null : Team.fromJson(json["away_team"]),
        leagues:
            json["leagues"] == null ? null : Leagues.fromJson(json["leagues"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "referee_id": refereeId,
        "league_id": leagueId,
        "country_id": countryId,
        "venue_id": venueId,
        "season_id": seasonId,
        "stage_id": stageId,
        "round_id": roundId,
        "timezone": timezone,
        "start_at": startAt,
        "current_period_start_at": currentPeriodStartAt,
        "home_team_id": homeTeamId,
        "away_team_id": awayTeamId,
        "status_id": statusId,
        "elapsed": elapsed,
        "current_score": currentScore,
        "half_score": halfScore,
        "full_score": fullScore,
        "extra_score": extraScore,
        "penalty_score": penaltyScore,
        "winner": winner,
        "has_live_score": hasLiveScore,
        "home_team": homeTeam?.toJson(),
        "away_team": awayTeam?.toJson(),
        "leagues": leagues?.toJson(),
      };
}

class Team {
  int? mid;
  int? id;
  String? name;
  String? nameShort;
  String? nameEn;
  String? nameEnShort;
  String? type;
  String? logo;
  int? leagueId;
  int? countryId;
  String? gender;
  dynamic telephone;
  dynamic email;
  String? website;
  dynamic setupAt;

  Team({
    this.mid,
    this.id,
    this.name,
    this.nameShort,
    this.nameEn,
    this.nameEnShort,
    this.type,
    this.logo,
    this.leagueId,
    this.countryId,
    this.gender,
    this.telephone,
    this.email,
    this.website,
    this.setupAt,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        mid: json["mid"],
        id: json["id"],
        name: json["name"],
        nameShort: json["name_short"],
        nameEn: json["name_en"],
        nameEnShort: json["name_en_short"],
        type: json["type"],
        logo: json["logo"],
        leagueId: json["league_id"],
        countryId: json["country_id"],
        gender: json["gender"],
        telephone: json["telephone"],
        email: json["email"],
        website: json["website"],
        setupAt: json["setup_at"],
      );

  Map<String, dynamic> toJson() => {
        "mid": mid,
        "id": id,
        "name": name,
        "name_short": nameShort,
        "name_en": nameEn,
        "name_en_short": nameEnShort,
        "type": type,
        "logo": logo,
        "league_id": leagueId,
        "country_id": countryId,
        "gender": gender,
        "telephone": telephone,
        "email": email,
        "website": website,
        "setup_at": setupAt,
      };
}

class Leagues {
  int? mid;
  int? id;
  String? name;
  String? nameShort;
  String? nameEn;
  String? nameEnShort;
  String? logo;
  String? type;
  String? gender;
  int? countryId;
  String? color;

  Leagues({
    this.mid,
    this.id,
    this.name,
    this.nameShort,
    this.nameEn,
    this.nameEnShort,
    this.logo,
    this.type,
    this.gender,
    this.countryId,
    this.color,
  });

  factory Leagues.fromJson(Map<String, dynamic> json) => Leagues(
        mid: json["mid"],
        id: json["id"],
        name: json["name"],
        nameShort: json["name_short"],
        nameEn: json["name_en"],
        nameEnShort: json["name_en_short"],
        logo: json["logo"],
        type: json["type"],
        gender: json["gender"],
        countryId: json["country_id"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "mid": mid,
        "id": id,
        "name": name,
        "name_short": nameShort,
        "name_en": nameEn,
        "name_en_short": nameEnShort,
        "logo": logo,
        "type": type,
        "gender": gender,
        "country_id": countryId,
        "color": color,
      };
}
