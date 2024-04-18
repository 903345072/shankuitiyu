// To parse this JSON data, do
//
//     final winRateListModel = winRateListModelFromJson(jsonString);

import 'dart:convert';

WinRateListModel winRateListModelFromJson(String str) =>
    WinRateListModel.fromJson(json.decode(str));

String winRateListModelToJson(WinRateListModel data) =>
    json.encode(data.toJson());

class WinRateListModel {
  String? msg;
  int? code;
  List<winRateModel>? data;

  WinRateListModel({
    this.msg,
    this.code,
    this.data,
  });

  factory WinRateListModel.fromJson(Map<String, dynamic> json) =>
      WinRateListModel(
        msg: json["msg"],
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<winRateModel>.from(
                json["data"]!.map((x) => winRateModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "code": code,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class winRateModel {
  int? userId;
  int? mingzhongRate;
  int? historyHong;
  dynamic hong;
  int? count;
  String? userName;
  String? userImg;
  int? fensi;
  String? isSubscribe;
  int? onSaleCount;

  winRateModel({
    this.userId,
    this.mingzhongRate,
    this.historyHong,
    this.hong,
    this.count,
    this.userName,
    this.userImg,
    this.fensi,
    this.isSubscribe,
    this.onSaleCount,
  });

  factory winRateModel.fromJson(Map<String, dynamic> json) => winRateModel(
        userId: json["user_id"],
        mingzhongRate:
            json["mingzhong_rate"] != "" ? json["mingzhong_rate"] : 0,
        historyHong: json["history_hong"],
        hong: json["hong"],
        count: json["count"],
        userName: json["user_name"],
        userImg: json["user_img"],
        fensi: json["fensi"],
        isSubscribe: json["is_subscribe"],
        onSaleCount: json["on_sale_count"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "mingzhong_rate": mingzhongRate,
        "history_hong": historyHong,
        "hong": hong,
        "count": count,
        "user_name": userName,
        "user_img": userImg,
        "fensi": fensi,
        "is_subscribe": isSubscribe,
        "on_sale_count": onSaleCount,
      };
}
