// To parse this JSON data, do
//
//     final profitIndexModel = profitIndexModelFromJson(jsonString);

import 'dart:convert';

ProfitIndexModel profitIndexModelFromJson(String str) =>
    ProfitIndexModel.fromJson(json.decode(str));

String profitIndexModelToJson(ProfitIndexModel data) =>
    json.encode(data.toJson());

class ProfitIndexModel {
  String? msg;
  int? code;
  profitData? data;

  ProfitIndexModel({
    this.msg,
    this.code,
    this.data,
  });

  factory ProfitIndexModel.fromJson(Map<String, dynamic> json) =>
      ProfitIndexModel(
        msg: json["msg"],
        code: json["code"],
        data: json["data"] == null ? null : profitData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "code": code,
        "data": data?.toJson(),
      };
}

class profitData {
  List<Jq>? rq;
  List<Jq>? jqs;

  profitData({
    this.rq,
    this.jqs,
  });

  factory profitData.fromJson(Map<String, dynamic> json) => profitData(
        rq: json["rq"] == null
            ? []
            : List<Jq>.from(json["rq"]!.map((x) => Jq.fromJson(x))),
        jqs: json["jqs"] == null
            ? []
            : List<Jq>.from(json["jqs"]!.map((x) => Jq.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "rq": rq == null ? [] : List<dynamic>.from(rq!.map((x) => x.toJson())),
        "jqs":
            jqs == null ? [] : List<dynamic>.from(jqs!.map((x) => x.toJson())),
      };
}

class Jq {
  String? title;
  int? count;
  String? yl;
  String? ylDesc;
  String? ylDescColor;
  int? qy;
  int? qs;
  int? yb;
  int? sb;
  int? zs;
  int? qyPercent;
  int? qsPercent;
  int? ybPercent;
  int? sbPercent;
  int? zsPercent;

  Jq({
    this.title,
    this.count,
    this.yl,
    this.ylDesc,
    this.ylDescColor,
    this.qy,
    this.qs,
    this.yb,
    this.sb,
    this.zs,
    this.qyPercent,
    this.qsPercent,
    this.ybPercent,
    this.sbPercent,
    this.zsPercent,
  });

  factory Jq.fromJson(Map<String, dynamic> json) => Jq(
        title: json["title"],
        count: json["count"],
        yl: json["yl"],
        ylDesc: json["yl_desc"],
        ylDescColor: json["yl_desc_color"],
        qy: json["qy"],
        qs: json["qs"],
        yb: json["yb"],
        sb: json["sb"],
        zs: json["zs"],
        qyPercent: json["qy_percent"],
        qsPercent: json["qs_percent"],
        ybPercent: json["yb_percent"],
        sbPercent: json["sb_percent"],
        zsPercent: json["zs_percent"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "count": count,
        "yl": yl,
        "yl_desc": ylDesc,
        "yl_desc_color": ylDescColor,
        "qy": qy,
        "qs": qs,
        "yb": yb,
        "sb": sb,
        "zs": zs,
        "qy_percent": qyPercent,
        "qs_percent": qsPercent,
        "yb_percent": ybPercent,
        "sb_percent": sbPercent,
        "zs_percent": zsPercent,
      };
}
