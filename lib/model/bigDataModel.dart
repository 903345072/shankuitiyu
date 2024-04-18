// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

bigDataModel dataModelFromJson(String str) =>
    bigDataModel.fromJson(json.decode(str));

String dataModelToJson(bigDataModel data) => json.encode(data.toJson());

class bigDataModel {
  String? msg;
  int? code;
  Data? data;

  bigDataModel({
    this.msg,
    this.code,
    this.data,
  });

  factory bigDataModel.fromJson(Map<String, dynamic> json) => bigDataModel(
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
  List<bigDataListElement>? list;
  String? banner;
  int? freeDay;

  Data({
    this.list,
    this.banner,
    this.freeDay,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: json["list"] == null
            ? []
            : List<bigDataListElement>.from(
                json["list"]!.map((x) => bigDataListElement.fromJson(x))),
        banner: json["banner"],
        freeDay: json["free_day"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "banner": banner,
        "free_day": freeDay,
      };
}

class bigDataListElement {
  int? id;
  String? introduce;
  int? currentCount;
  String? title;
  int? bigDataPrice;
  String? imageUrl;
  int? freeExperience;
  int? bigDataOnePrice;
  int? isSubscrib;

  bigDataListElement({
    this.id,
    this.introduce,
    this.currentCount,
    this.title,
    this.bigDataPrice,
    this.imageUrl,
    this.freeExperience,
    this.bigDataOnePrice,
    this.isSubscrib,
  });

  factory bigDataListElement.fromJson(Map<String, dynamic> json) =>
      bigDataListElement(
        id: json["id"],
        introduce: json["introduce"],
        currentCount: json["current_count"],
        title: json["title"],
        bigDataPrice: json["big_data_price"],
        imageUrl: json["image_url"],
        freeExperience: json["free_experience"],
        bigDataOnePrice: json["big_data_one_price"],
        isSubscrib: json["is_subscrib"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "introduce": introduce,
        "current_count": currentCount,
        "title": title,
        "big_data_price": bigDataPrice,
        "image_url": imageUrl,
        "free_experience": freeExperience,
        "big_data_one_price": bigDataOnePrice,
        "is_subscrib": isSubscrib,
      };
}
