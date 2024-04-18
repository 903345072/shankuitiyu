class drayModel {
  String nickname;
  int id;
  String title;
  String user_avatar;
  String avatar;
  int count;
  String date;

  drayModel(
      {required this.nickname,
      required this.id,
      required this.title,
      required this.user_avatar,
      required this.avatar,
      required this.date,
      required this.count});

  factory drayModel.fromJson(Map<String, dynamic> json) {
    return drayModel(
        nickname: json['nickname'],
        id: json['id'],
        title: json['title'],
        user_avatar: json['user_avatar'],
        avatar: json["avatar"],
        date: json["date"],
        count: json["count"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickname'] = nickname;
    data['id'] = id;
    data['title'] = title;
    data['user_avatar'] = user_avatar;
    data['avatar'] = avatar;
    data['count'] = count;
    return data;
  }
}
