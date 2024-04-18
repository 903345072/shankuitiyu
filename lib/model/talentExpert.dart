// To parse this JSON data, do
//
//     final talentExpertModel = talentExpertModelFromJson(jsonString);

import 'dart:convert';

TalentExpertModel talentExpertModelFromJson(String str) =>
    TalentExpertModel.fromJson(json.decode(str));

String talentExpertModelToJson(TalentExpertModel data) =>
    json.encode(data.toJson());

class TalentExpertModel {
  String? msg;
  int? code;
  List<expertTalentDatum>? data;

  TalentExpertModel({
    this.msg,
    this.code,
    this.data,
  });

  factory TalentExpertModel.fromJson(Map<String, dynamic> json) =>
      TalentExpertModel(
        msg: json["msg"],
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<expertTalentDatum>.from(
                json["data"]!.map((x) => expertTalentDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "code": code,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class expertTalentDatum {
  String? isSubscribe;
  int? id;
  String? userName;
  String? userImg;
  String? desc;
  dynamic fensi;
  String? zhong;
  int? hong;
  int? mingzhongRate;
  int? userId;
  VolcLiveInfo? volcLiveInfo;
  int? onSaleCount;
  int? userType;

  expertTalentDatum(
      {this.isSubscribe,
      this.id,
      this.userName,
      this.userImg,
      this.desc,
      this.fensi,
      this.zhong,
      this.userId,
      this.volcLiveInfo,
      this.onSaleCount,
      this.mingzhongRate,
      this.userType,
      this.hong});

  factory expertTalentDatum.fromJson(Map<String, dynamic> json) =>
      expertTalentDatum(
        isSubscribe: json["is_subscribe"],
        id: json["id"],
        userName: json["user_name"],
        userImg: json["user_img"],
        desc: json["desc"],
        fensi: json["fensi"],
        zhong: json["zhong"],
        hong: json["hong"],
        userId: json["user_id"],
        userType: json["user_type"],
        mingzhongRate: json["mingzhong_rate"],
        volcLiveInfo: json["volc_live_info"] == null
            ? null
            : VolcLiveInfo.fromJson(json["volc_live_info"]),
        onSaleCount: json["on_sale_count"],
      );

  Map<String, dynamic> toJson() => {
        "is_subscribe": isSubscribe,
        "id": id,
        "hong": hong,
        "user_name": userName,
        "user_img": userImg,
        "desc": desc,
        "fensi": fensi,
        "zhong": zhong,
        "user_id": userId,
        "volc_live_info": volcLiveInfo?.toJson(),
        "on_sale_count": onSaleCount,
        "user_type": userType,
      };
}

class VolcLiveInfo {
  int? isLive;
  int? liveVolcRoomId;

  VolcLiveInfo({
    this.isLive,
    this.liveVolcRoomId,
  });

  factory VolcLiveInfo.fromJson(Map<String, dynamic> json) => VolcLiveInfo(
        isLive: json["is_live"],
        liveVolcRoomId: json["live_volc_room_id"],
      );

  Map<String, dynamic> toJson() => {
        "is_live": isLive,
        "live_volc_room_id": liveVolcRoomId,
      };
}
