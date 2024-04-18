// To parse this JSON data, do
//
//     final jcFootModel = jcFootModelFromJson(jsonString);

import 'dart:convert';

import 'package:jingcai_app/model/jcFootMetModel.dart';

JcFootModel jcFootModelFromJson(String str) =>
    JcFootModel.fromJson(json.decode(str));

String jcFootModelToJson(JcFootModel data) => json.encode(data.toJson());

class JcFootModel {
  int? mid;
  int? id;
  dynamic refereeId;
  int? leagueId;
  int? countryId;
  dynamic venueId;
  int? seasonId;
  int? stageId;
  int? roundId;
  String? timezone;
  String? startAt;
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
  int? change_id;
  int? has_ani;
  String? q1_score;
  String? q2_score;
  String? q3_score;
  String? q4_score;
  Round? round;
  Leagues? leagues;
  String? basket_handicap = "0";
  int? plan_num;
  Jc? jc;
  JcFootMetModel? jcFootMetModel_;
  List<RqPl>? rqPl;
  List<jqPl>? dxqPl;
  List<spfPl>? spfPls;
  int? flow;
  setJcFootMetModel(JcFootMetModel d) {
    jcFootMetModel_ = d;
  }

  JcFootModel(
      {this.mid,
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
      this.change_id,
      this.jc,
      this.rqPl,
      this.jcFootMetModel_,
      this.spfPls,
      this.plan_num,
      this.round,
      this.flow,
      this.q1_score,
      this.basket_handicap,
      this.q2_score,
      this.q3_score,
      this.q4_score,
      this.has_ani,
      this.dxqPl});

  factory JcFootModel.fromJson(Map<String, dynamic> json) => JcFootModel(
        mid: json["mid"],
        id: json["id"],
        q1_score: json["q1_score"],
        q2_score: json["q2_score"],
        q3_score: json["q3_score"],
        q4_score: json["q4_score"],
        plan_num: json["plan_num"],
        refereeId: json["referee_id"],
        leagueId: json["league_id"],
        countryId: json["country_id"],
        venueId: json["venue_id"],
        seasonId: json["season_id"],
        stageId: json["stage_id"],
        roundId: json["round_id"],
        has_ani: json["has_animation"] ?? 0,
        change_id: json["change_id"] == null
            ? 0
            : int.parse(json["change_id"].toString()),
        timezone: json["timezone"],
        startAt: json["start_at"],
        currentPeriodStartAt: json["current_period_start_at"],
        homeTeamId: json["home_team_id"],
        awayTeamId: json["away_team_id"],
        statusId: json["status_id"],
        elapsed: json["elapsed"] ?? "0",
        currentScore: json["current_score"],
        halfScore: json["half_score"],
        fullScore: json["full_score"],
        basket_handicap: json["basket_handicap"],
        extraScore: json["extra_score"],
        penaltyScore: json["penalty_score"],
        winner: json["winner"],
        hasLiveScore: json["has_live_score"],
        flow: json["flow"],
        round: json["round"] == null ? null : Round.fromJson(json["round"]),
        homeTeam:
            json["home_team"] == null ? null : Team.fromJson(json["home_team"]),
        jcFootMetModel_:
            json["jfm"] == null ? null : JcFootMetModel.fromJson(json["jfm"]),
        awayTeam:
            json["away_team"] == null ? null : Team.fromJson(json["away_team"]),
        leagues:
            json["leagues"] == null ? null : Leagues.fromJson(json["leagues"]),
        jc: json["jc"] == null ? null : Jc.fromJson(json["jc"]),
        rqPl: json["rq_pl"] == null
            ? []
            : List<RqPl>.from(json["rq_pl"]!.map((x) => RqPl.fromJson(x))),
        dxqPl: json["dxq_pl"] == null
            ? []
            : List<jqPl>.from(json["dxq_pl"]!.map((x) => jqPl.fromJson(x))),
        spfPls: json["spf_pl"] == null
            ? []
            : List<spfPl>.from(json["spf_pl"]!.map((x) => spfPl.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mid": mid,
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
        "flow": flow,
        "elapsed": elapsed,
        "current_score": currentScore,
        "half_score": halfScore,
        "full_score": fullScore,
        "extra_score": extraScore,
        "penalty_score": penaltyScore,
        "winner": winner,
        "has_live_score": hasLiveScore,
        "home_team": homeTeam?.toJson(),
        "round": round?.toJson(),
        "away_team": awayTeam?.toJson(),
        "leagues": leagues?.toJson(),
        "jfm": jcFootMetModel_?.toJson(),
        "jc": jc?.toJson(),
        "rq_pl": rqPl == null
            ? []
            : List<dynamic>.from(rqPl!.map((x) => x.toJson())),
        "dxq_pl": dxqPl == null
            ? []
            : List<dynamic>.from(dxqPl!.map((x) => x.toJson())),
      };

  Map<String, dynamic> toSimPleJson() => {
        "id": id,
        "start_at": startAt,
        "jfm": jcFootMetModel_?.toSimpleJson(),
        "match_txt":
            "${leagues!.nameShort} ${startAt!.substring(5, 16)} ${jc?.matchNumStr ?? ""} ${homeTeam!.nameShort} vs ${awayTeam!.nameShort}"
      };
}

class RqPl {
  int? id;
  int? matchId;
  int? bookmakerId;
  int? marketId;
  int? type;
  int? status;
  String? win;
  String? loss;
  String? handicap;
  int? changeAt;

  RqPl(
      {this.id,
      this.matchId,
      this.bookmakerId,
      this.marketId,
      this.type,
      this.status,
      this.win,
      this.loss,
      this.changeAt,
      this.handicap});

  factory RqPl.fromJson(Map<String, dynamic> json) => RqPl(
        id: json["id"],
        matchId: json["match_id"],
        bookmakerId: json["bookmaker_id"],
        marketId: json["market_id"],
        type: json["type"],
        status: json["status"],
        win: json["win"],
        loss: json["loss"],
        handicap: json["handicap"],
        changeAt: json["change_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "match_id": matchId,
        "bookmaker_id": bookmakerId,
        "market_id": marketId,
        "type": type,
        "status": status,
        "win": win,
        "loss": loss,
        "change_at": changeAt,
        "handicap": handicap
      };
}

class spfPl {
  int? id;
  int? matchId;
  int? bookmakerId;
  int? marketId;
  int? type;
  int? status;
  String? win;
  String? draw;
  String? loss;

  int? changeAt;

  spfPl(
      {this.id,
      this.matchId,
      this.bookmakerId,
      this.marketId,
      this.type,
      this.status,
      this.win,
      this.draw,
      this.loss,
      this.changeAt});

  factory spfPl.fromJson(Map<String, dynamic> json) => spfPl(
        id: json["id"],
        matchId: json["match_id"],
        bookmakerId: json["bookmaker_id"],
        marketId: json["market_id"],
        type: json["type"],
        status: json["status"],
        win: json["win"],
        draw: json["draw"],
        loss: json["loss"],
        changeAt: json["change_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "match_id": matchId,
        "bookmaker_id": bookmakerId,
        "market_id": marketId,
        "type": type,
        "status": status,
        "win": win,
        "draw": draw,
        "loss": loss,
        "change_at": changeAt
      };
}

class jqPl {
  int? id;
  int? matchId;
  int? bookmakerId;
  int? marketId;
  int? type;
  int? status;
  String? dq;
  String? xq;
  String? handicap;
  int? changeAt;

  jqPl(
      {this.id,
      this.matchId,
      this.bookmakerId,
      this.marketId,
      this.type,
      this.status,
      this.dq,
      this.xq,
      this.changeAt,
      this.handicap});

  factory jqPl.fromJson(Map<String, dynamic> json) => jqPl(
        id: json["id"],
        matchId: json["match_id"],
        bookmakerId: json["bookmaker_id"],
        marketId: json["market_id"],
        type: json["type"],
        status: json["status"],
        dq: json["dq"],
        xq: json["xq"],
        handicap: json["handicap"],
        changeAt: json["change_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "match_id": matchId,
        "bookmaker_id": bookmakerId,
        "market_id": marketId,
        "type": type,
        "status": status,
        "dq": dq,
        "xq": xq,
        "change_at": changeAt,
        "handicap": handicap
      };
}

class Odd {
  String? label;
  String? value;
  bool? blocked;
  String? handicap;

  Odd({
    this.label,
    this.value,
    this.blocked,
    this.handicap,
  });

  factory Odd.fromJson(Map<String, dynamic> json) => Odd(
        label: json["label"]!,
        value: json["value"].toString(),
        blocked: json["blocked"],
        handicap: json["handicap"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
        "blocked": blocked,
        "handicap": handicap,
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
  TeamData? teamData;

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
    this.teamData,
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
        teamData: json["team_data"] == null
            ? null
            : TeamData.fromJson(json["team_data"]),
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
        "team_data": teamData?.toJson(),
      };
}

class Jc {
  int? mid;
  int? id;
  int? v5Id;
  String? issueNum;
  String? matchNum;
  String? matchNumStr;
  String? weekday;
  int? businessAt;
  int? startAt;
  String? leagueName;
  String? leagueNameShort;
  String? leagueColor;
  String? homeTeamName;
  String? homeTeamNameShort;
  String? homeRank;
  String? awayTeamName;
  String? awayTeamNameShort;
  String? awayRank;
  dynamic halfScore;
  dynamic fullScore;
  int? sellStatusId;
  String? remark;
  int? isReverse;
  int? hasResult;
  dynamic win;
  dynamic draw;
  dynamic loss;
  dynamic handicap;
  dynamic rqWin;
  dynamic rqDraw;
  dynamic rqLoss;
  List<jcPl>? spfPl;
  List<jcPl>? rqPl;

  Jc({
    this.mid,
    this.id,
    this.v5Id,
    this.issueNum,
    this.matchNum,
    this.matchNumStr,
    this.weekday,
    this.businessAt,
    this.startAt,
    this.leagueName,
    this.leagueNameShort,
    this.leagueColor,
    this.homeTeamName,
    this.homeTeamNameShort,
    this.homeRank,
    this.awayTeamName,
    this.awayTeamNameShort,
    this.awayRank,
    this.halfScore,
    this.fullScore,
    this.sellStatusId,
    this.remark,
    this.isReverse,
    this.hasResult,
    this.win,
    this.draw,
    this.loss,
    this.handicap,
    this.rqWin,
    this.rqDraw,
    this.rqLoss,
    this.spfPl,
    this.rqPl,
  });

  factory Jc.fromJson(Map<String, dynamic> json) => Jc(
        mid: json["mid"],
        id: json["id"],
        v5Id: json["v5_id"],
        issueNum: json["issue_num"],
        matchNum: json["match_num"],
        matchNumStr: json["match_num_str"],
        weekday: json["weekday"],
        businessAt: json["business_at"],
        startAt: json["start_at"],
        leagueName: json["league_name"],
        leagueNameShort: json["league_name_short"],
        leagueColor: json["league_color"],
        homeTeamName: json["home_team_name"],
        homeTeamNameShort: json["home_team_name_short"],
        homeRank: json["home_rank"],
        awayTeamName: json["away_team_name"],
        awayTeamNameShort: json["away_team_name_short"],
        awayRank: json["away_rank"],
        halfScore: json["half_score"],
        fullScore: json["full_score"],
        sellStatusId: json["sell_status_id"],
        remark: json["remark"],
        isReverse: json["is_reverse"],
        hasResult: json["has_result"],
        win: json["win"],
        draw: json["draw"],
        loss: json["loss"],
        handicap: json["handicap"],
        rqWin: json["rq_win"],
        rqDraw: json["rq_draw"],
        rqLoss: json["rq_loss"],
        spfPl: json["spf_pl"] == null
            ? []
            : List<jcPl>.from(json["spf_pl"]!.map((x) => jcPl.fromJson(x))),
        rqPl: json["rq_pl"] == null
            ? []
            : List<jcPl>.from(json["rq_pl"]!.map((x) => jcPl.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mid": mid,
        "id": id,
        "v5_id": v5Id,
        "issue_num": issueNum,
        "match_num": matchNum,
        "match_num_str": matchNumStr,
        "weekday": weekday,
        "business_at": businessAt,
        "start_at": startAt,
        "league_name": leagueName,
        "league_name_short": leagueNameShort,
        "league_color": leagueColor,
        "home_team_name": homeTeamName,
        "home_team_name_short": homeTeamNameShort,
        "home_rank": homeRank,
        "away_team_name": awayTeamName,
        "away_team_name_short": awayTeamNameShort,
        "away_rank": awayRank,
        "half_score": halfScore,
        "full_score": fullScore,
        "sell_status_id": sellStatusId,
        "remark": remark,
        "is_reverse": isReverse,
        "has_result": hasResult,
        "win": win,
        "draw": draw,
        "loss": loss,
        "handicap": handicap,
        "rq_win": rqWin,
        "rq_draw": rqDraw,
        "rq_loss": rqLoss,
        "spf_pl": spfPl == null
            ? []
            : List<dynamic>.from(spfPl!.map((x) => x.toJson())),
        "rq_pl": rqPl == null
            ? []
            : List<dynamic>.from(rqPl!.map((x) => x.toJson())),
      };
}

class jcPl {
  int? id;
  int? matchId;
  int? single;
  int? typeId;
  String? handicap;
  String? win;
  String? draw;
  String? loss;
  int? changeAt;

  jcPl({
    this.id,
    this.matchId,
    this.single,
    this.typeId,
    this.handicap,
    this.win,
    this.draw,
    this.loss,
    this.changeAt,
  });

  factory jcPl.fromJson(Map<String, dynamic> json) => jcPl(
        id: json["id"],
        matchId: json["match_id"],
        single: json["single"],
        typeId: json["type_id"],
        handicap: json["handicap"],
        win: json["win"],
        draw: json["draw"],
        loss: json["loss"],
        changeAt: json["change_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "match_id": matchId,
        "single": single,
        "type_id": typeId,
        "handicap": handicap,
        "win": win,
        "draw": draw,
        "loss": loss,
        "change_at": changeAt,
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

class Round {
  int? id;
  String? name;

  Round({
    this.id,
    this.name,
  });

  factory Round.fromJson(Map<String, dynamic> json) => Round(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class TeamData {
  int? id;
  String? teamId;
  String? matchId;
  String? period;
  String? goals;
  String? goalsAgainst;
  String? ballPossession;
  String? shots;
  String? shotsOnGoal;
  String? shotsOffGoal;
  dynamic blockedShots;
  dynamic freeKicks;
  String? cornerKicks;
  dynamic goalKicks;
  dynamic offsides;
  dynamic throwIns;
  dynamic goalkeeperSaves;
  dynamic fouls;
  String? redCards;
  String? yellowCards;
  dynamic passes;
  dynamic passesAccuracy;
  dynamic passesPercentage;
  dynamic tackles;
  String? attacks;
  String? dangerousAttacks;
  String? penaltyWon;
  String? penaltyScored;
  String? penaltyMissed;
  dynamic clearances;
  dynamic crossesAccuracy;
  dynamic crosses;
  dynamic interceptions;

  TeamData({
    this.id,
    this.teamId,
    this.matchId,
    this.period,
    this.goals,
    this.goalsAgainst,
    this.ballPossession,
    this.shots,
    this.shotsOnGoal,
    this.shotsOffGoal,
    this.blockedShots,
    this.freeKicks,
    this.cornerKicks,
    this.goalKicks,
    this.offsides,
    this.throwIns,
    this.goalkeeperSaves,
    this.fouls,
    this.redCards,
    this.yellowCards,
    this.passes,
    this.passesAccuracy,
    this.passesPercentage,
    this.tackles,
    this.attacks,
    this.dangerousAttacks,
    this.penaltyWon,
    this.penaltyScored,
    this.penaltyMissed,
    this.clearances,
    this.crossesAccuracy,
    this.crosses,
    this.interceptions,
  });

  factory TeamData.fromJson(Map<String, dynamic> json) => TeamData(
        id: json["id"],
        teamId: json["team_id"],
        matchId: json["match_id"],
        period: json["period"],
        goals: json["goals"],
        goalsAgainst: json["goals_against"],
        ballPossession: json["ball_possession"],
        shots: json["shots"],
        shotsOnGoal: json["shots_on_goal"],
        shotsOffGoal: json["shots_off_goal"],
        blockedShots: json["blocked_shots"],
        freeKicks: json["free_kicks"],
        cornerKicks: json["corner_kicks"],
        goalKicks: json["goal_kicks"],
        offsides: json["offsides"],
        throwIns: json["throw_ins"],
        goalkeeperSaves: json["goalkeeper_saves"],
        fouls: json["fouls"],
        redCards: json["red_cards"],
        yellowCards: json["yellow_cards"],
        passes: json["passes"],
        passesAccuracy: json["passes_accuracy"],
        passesPercentage: json["passes_percentage"],
        tackles: json["tackles"],
        attacks: json["attacks"],
        dangerousAttacks: json["dangerous_attacks"],
        penaltyWon: json["penalty_won"],
        penaltyScored: json["penalty_scored"],
        penaltyMissed: json["penalty_missed"],
        clearances: json["clearances"],
        crossesAccuracy: json["crosses_accuracy"],
        crosses: json["crosses"],
        interceptions: json["interceptions"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "team_id": teamId,
        "match_id": matchId,
        "period": period,
        "goals": goals,
        "goals_against": goalsAgainst,
        "ball_possession": ballPossession,
        "shots": shots,
        "shots_on_goal": shotsOnGoal,
        "shots_off_goal": shotsOffGoal,
        "blocked_shots": blockedShots,
        "free_kicks": freeKicks,
        "corner_kicks": cornerKicks,
        "goal_kicks": goalKicks,
        "offsides": offsides,
        "throw_ins": throwIns,
        "goalkeeper_saves": goalkeeperSaves,
        "fouls": fouls,
        "red_cards": redCards,
        "yellow_cards": yellowCards,
        "passes": passes,
        "passes_accuracy": passesAccuracy,
        "passes_percentage": passesPercentage,
        "tackles": tackles,
        "attacks": attacks,
        "dangerous_attacks": dangerousAttacks,
        "penalty_won": penaltyWon,
        "penalty_scored": penaltyScored,
        "penalty_missed": penaltyMissed,
        "clearances": clearances,
        "crosses_accuracy": crossesAccuracy,
        "crosses": crosses,
        "interceptions": interceptions,
      };
}
