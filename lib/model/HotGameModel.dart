class HotGameModel {
  String ls_name;
  int id;
  String h_name;
  String a_name;
  String date;
  int count;

  HotGameModel(
      {required this.ls_name,
      required this.id,
      required this.h_name,
      required this.a_name,
      required this.date,
      required this.count});

  factory HotGameModel.fromJson(Map<String, dynamic> json) {
    return HotGameModel(
        ls_name: json['ls_name'],
        id: json['id'],
        h_name: json['h_name'],
        a_name: json['a_name'],
        date: json["date"],
        count: json["count"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ls_name'] = ls_name;
    data['id'] = id;
    data['h_name'] = h_name;
    data['a_name'] = a_name;
    data['date'] = date;
    data['count'] = count;
    return data;
  }
}
