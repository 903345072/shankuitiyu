class expert {
  String? name;
  int? id;
  String? intro;
  int? userId;
  String? avatar;
  int? count;
  int? is_subscribe;
  String? fans;
  String? desc;
  String? banner;

  expert(
      {this.name,
      this.id,
      this.intro,
      this.userId,
      this.avatar,
      this.count,
      this.is_subscribe,
      this.desc,
      this.banner,
      this.fans});

  factory expert.fromJson(Map<String, dynamic> json) {
    return expert(
        name: json['real_name'],
        id: json['uid'],
        intro: json['lable'],
        userId: json['uid'],
        avatar: json["avatar"],
        fans: json["fans"].toString(),
        desc: json["introduce"],
        banner: json["banner"],
        count: json["plan_num"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['real_name'] = name;
    data['uid'] = id;
    data['introduce'] = intro;

    data['avatar'] = avatar;
    data['plan_num'] = count;

    return data;
  }
}
