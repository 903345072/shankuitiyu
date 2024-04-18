class recommendModel {
  String nickname;
  int id;
  String intro;
  String avatar;
  String date;
  int count;
  String title;
  String content_desc;
  double price;
  int state;
  int? is_bd = 0;
  String? game_comment;

  recommendModel(
      {required this.nickname,
      required this.id,
      required this.is_bd,
      required this.title,
      required this.intro,
      required this.avatar,
      required this.state,
      required this.date,
      required this.content_desc,
      required this.price,
      required this.count,
      this.game_comment});

  factory recommendModel.fromJson(Map<String, dynamic> json) {
    return recommendModel(
        nickname: json['nickname'],
        id: json['id'],
        intro: json['intro'],
        avatar: json['avatar'],
        date: json["date"],
        state: json["state"],
        count: json["count"],
        price: json["price"],
        is_bd: json["is_bd"] ?? 0,
        content_desc: json["content_desc"],
        game_comment: json["game_after_comment"],
        title: json["title"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickname'] = nickname;
    data['id'] = id;
    data['intro'] = intro;
    data['avatar'] = avatar;
    data['date'] = date;
    data['count'] = count;
    data['title'] = title;
    data['price'] = price;
    data['state'] = state;
    data['content_desc'] = content_desc;
    data['is_bd'] = is_bd;
    return data;
  }
}
