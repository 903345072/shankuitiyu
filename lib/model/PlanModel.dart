// To parse this JSON data, do
//
//     final planModel = planModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:jingcai_app/model/jcFootModel.dart';

PlanModel planModelFromJson(String str) => PlanModel.fromJson(json.decode(str));

String planModelToJson(PlanModel data) => json.encode(data.toJson());

class PlanModel {
  String? title;
  String? introduce;
  String? desc;
  String? type;
  List<JcFootModel>? footmodel;
  double price = 0;
  bool is_bd = false;
  List<String>? files;

  PlanModel(
      {this.title,
      this.introduce,
      this.desc,
      this.footmodel,
      this.type,
      this.files});

  factory PlanModel.fromJson(Map<String, dynamic> json) => PlanModel(
        title: json["title"],
        introduce: json["introduce"],
        desc: json["desc"],
        type: json["type"],
        footmodel: json["footmodel"],
        files: json["files"],
      );

  factory PlanModel.fromdJson(Map<String, dynamic> json) => PlanModel(
        title: json["title"],
        introduce: json["introduce"],
        desc: json["desc"],
        type: json["type"],
        files: List<String>.from(json["files"].map((x) => x.toString())),
        footmodel: json["footmodel"] == null
            ? []
            : List<JcFootModel>.from(
                json["footmodel"]!.map((x) => JcFootModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "introduce": introduce,
        "desc": desc,
        "price": price,
        "is_bd": is_bd,
        "footmodel": footmodel == null
            ? []
            : List<dynamic>.from(footmodel!.map((x) => x.toJson())),
        "type": type,
        "files": files
      };

  Map<String, dynamic> toSimPleJson() => {
        "title": title,
        "price": price,
        "is_bd": is_bd,
        "introduce": introduce,
        "desc": desc,
        "files": files,
        "footmodel": footmodel == null
            ? []
            : List<dynamic>.from(footmodel!.map((x) => x.toSimPleJson())),
        "type": type,
      };
}
