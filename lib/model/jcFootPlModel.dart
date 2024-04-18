// To parse this JSON data, do
//
//     final jcFootPlModel = jcFootPlModelFromJson(jsonString);

import 'dart:convert';

JcFootPlModel jcFootPlModelFromJson(String str) =>
    JcFootPlModel.fromJson(json.decode(str));

String jcFootPlModelToJson(JcFootPlModel data) => json.encode(data.toJson());

class JcFootPlModel {
  Pl? spfPl;
  Pl? rqPl;

  JcFootPlModel({
    this.spfPl,
    this.rqPl,
  });

  factory JcFootPlModel.fromJson(Map<String, dynamic> json) => JcFootPlModel(
        spfPl: json["spf_pl"] == null ? null : Pl.fromJson(json["spf_pl"]),
        rqPl: json["rq_pl"] == null ? null : Pl.fromJson(json["rq_pl"]),
      );

  Map<String, dynamic> toJson() => {
        "spf_pl": spfPl?.toJson(),
        "rq_pl": rqPl?.toJson(),
      };
}

class Pl {
  int? id;
  int? matchId;
  int? single;
  int? typeId;
  String? handicap;
  String? win;
  String? draw;
  String? loss;
  int? changeAt;

  Pl({
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

  factory Pl.fromJson(Map<String, dynamic> json) => Pl(
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
