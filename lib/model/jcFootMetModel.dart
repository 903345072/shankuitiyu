// To parse this JSON data, do
//
//     final jcFootMetModel = jcFootMetModelFromJson(jsonString);

import 'dart:convert';

JcFootMetModel jcFootMetModelFromJson(String str) =>
    JcFootMetModel.fromJson(json.decode(str));

String jcFootMetModelToJson(JcFootMetModel data) => json.encode(data.toJson());

class JcFootMetModel {
  Map<String, Rq>? spf;
  Map<String, Rq>? rq;
  Map<String, Rq>? footrq;
  Map<String, Rq>? daxiaoqiu;
  Map<String, Rq>? rfsf;
  Map<String, Rq>? dxf;
  String rqNum = "0";
  String daxiaoNum = "0";

  JcFootMetModel(
      {this.spf, this.rq, this.footrq, this.daxiaoqiu, this.dxf, this.rfsf});

  factory JcFootMetModel.fromJson(Map<String, dynamic> json) => JcFootMetModel(
        spf: json["spf"] != null
            ? Map.from(json["spf"]!)
                .map((k, v) => MapEntry<String, Rq>(k, Rq.fromJson(v)))
            : null,
        rq: json["rq"] != null
            ? Map.from(json["rq"]!)
                .map((k, v) => MapEntry<String, Rq>(k, Rq.fromJson(v)))
            : null,
        footrq: json["footrq"] != null
            ? Map.from(json["footrq"]!)
                .map((k, v) => MapEntry<String, Rq>(k, Rq.fromJson(v)))
            : null,
        daxiaoqiu: json["daxiaoqiu"] != null
            ? Map.from(json["daxiaoqiu"]!)
                .map((k, v) => MapEntry<String, Rq>(k, Rq.fromJson(v)))
            : null,
        rfsf: json["rfsf"] != null
            ? Map.from(json["rfsf"]!)
                .map((k, v) => MapEntry<String, Rq>(k, Rq.fromJson(v)))
            : null,
        dxf: json["dxf"] != null
            ? Map.from(json["dxf"]!)
                .map((k, v) => MapEntry<String, Rq>(k, Rq.fromJson(v)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "spf": Map.from(spf!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "rq": Map.from(rq!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "footrq": Map.from(footrq!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "daxiaoqiu": Map.from(daxiaoqiu!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };

  Map<String, dynamic> toSimpleJson() {
    Map<String, dynamic> m = {};
    Map<String, dynamic> d = {};

    if (spf != null) {
      bool isspf =
          spf!.values.where((element) => element.check == true).isNotEmpty;
      if (isspf) {
        m["spf"] = Map.from(spf!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson()));
      }
    }

    if (rq != null) {
      bool isrq =
          rq!.values.where((element) => element.check == true).isNotEmpty;
      if (isrq) {
        m["rq"] = Map.from(rq!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson()));
      }
    }

    if (footrq != null) {
      bool isfootrq =
          footrq!.values.where((element) => element.check == true).isNotEmpty;
      if (isfootrq) {
        m["footrq"] = Map.from(footrq!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson()));
      }
    }

    if (daxiaoqiu != null) {
      bool isdxq = daxiaoqiu!.values
          .where((element) => element.check == true)
          .isNotEmpty;
      if (isdxq) {
        m["daxiaoqiu"] = Map.from(daxiaoqiu!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson()));
      }
    }

    if (rfsf != null) {
      bool isrfsf =
          rfsf!.values.where((element) => element.check == true).isNotEmpty;
      if (isrfsf) {
        m["rfsf"] = Map.from(rfsf!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson()));
      }
    }

    if (dxf != null) {
      bool isdxf =
          dxf!.values.where((element) => element.check == true).isNotEmpty;
      if (isdxf) {
        m["dxf"] = Map.from(dxf!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson()));
      }
    }

    d["met"] = m;
    d["rq"] = rqNum;
    d["dxq"] = daxiaoNum;
    return d;
  }
}

class Rq {
  String? met;
  String? name;
  String? pl;
  bool? check;

  Rq({
    this.met,
    this.name,
    this.pl,
    this.check,
  });

  factory Rq.fromJson(Map<String, dynamic> json) => Rq(
        met: json["met"],
        name: json["name"],
        pl: json["pl"],
        check: json["check"] is bool
            ? json["check"]
            : bool.tryParse(json["check"]),
      );

  Map<String, dynamic> toJson() => {
        "met": met,
        "name": name,
        "pl": pl,
        "check": check,
      };
}
