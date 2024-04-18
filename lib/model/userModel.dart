class userModel {
  int? uid;
  String? accountId;
  String? realName;
  String? phone;
  String? avatar;
  int? type;
  int? talentApplyState;
  double? money;
  String? introduce;
  String? password;
  int? addTime;
  String? refuseText;
  int? flow;
  int? notice;
  int? yhq;
  int fans = 0;

  userModel(
      {this.uid,
      this.accountId,
      this.realName,
      this.phone,
      this.avatar,
      this.type,
      this.talentApplyState,
      this.money,
      this.introduce,
      this.password,
      this.addTime,
      this.refuseText,
      this.flow,
      required this.fans,
      this.notice,
      this.yhq});

  factory userModel.fromJson(Map<String, dynamic> json) => userModel(
      uid: json["uid"],
      yhq: json["yhq"],
      accountId: json["account_id"],
      realName: json["real_name"],
      phone: json["phone"],
      avatar: json["avatar"],
      type: json["type"],
      talentApplyState: json["talent_apply_state"],
      money: double.parse(json["money"] ?? "0"),
      introduce: json["introduce"],
      password: json["password"],
      addTime: json["add_time"],
      refuseText: json["refuse_text"],
      flow: json["flow"],
      notice: json["notice"],
      fans: json["fans"] ?? 0);

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "account_id": accountId,
        "real_name": realName,
        "phone": phone,
        "avatar": avatar,
        "type": type,
        "talent_apply_state": talentApplyState,
        "money": money,
        "introduce": introduce,
        "password": password,
        "add_time": addTime,
        "refuse_text": refuseText,
        "flow": flow,
        "notice": notice,
        "fans": fans
      };
}
