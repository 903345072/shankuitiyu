class sysNewsModel {
  int id;
  String title;

  String avatar;
  int count;
  String date;

  sysNewsModel(
      {required this.id,
      required this.title,
      required this.avatar,
      required this.date,
      required this.count});

  factory sysNewsModel.fromJson(Map<String, dynamic> json) {
    return sysNewsModel(
        id: json['id'],
        title: json['title'],
        avatar: json["avatar"],
        date: json["date"],
        count: json["count"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = id;
    data['title'] = title;

    data['avatar'] = avatar;
    data['count'] = count;
    return data;
  }
}
