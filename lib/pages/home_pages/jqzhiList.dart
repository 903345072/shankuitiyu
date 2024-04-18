import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';

class jqzhiList extends StatefulWidget {
  int? id;
  jqzhiList({required this.id});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ouzhiList_();
  }
}

class ouzhiList_ extends State<jqzhiList> {
  List data = [];

  @override
  void initState() {
    super.initState();
    print(widget.id);
    getData();
  }

  getData() {
    G.api.game.getFootPl({"id": widget.id, "type": 3}).then((value) {
      setState(() {
        data = value;
      });
    });
  }

  Color getColor(List s, String field) {
    Color c = Colors.black;
    if (s.length > 1) {
      double to = double.parse(s[0][field]);
      double t1 = double.parse(s[1][field]);
      if (to > t1) {
        c = Colors.red;
      }
      if (to < t1) {
        c = Colors.green;
      }
    }
    return c;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Color(0xfff0f0f0),
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: rpx(10)),
            child: Row(
              children: [
                Container(
                  width: rpx(70),
                  child: TextWidget("公司"),
                ),
                Container(
                  width: rpx(70),
                ),
                Container(
                  width: rpx(60),
                  child: TextWidget("大球"),
                ),
                Container(
                  width: rpx(60),
                  child: TextWidget("指数"),
                ),
                Container(
                  width: rpx(60),
                  child: TextWidget("小球"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: rpx(15),
          ),
          Column(
            children: List.generate(
                data.length,
                (index) => Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: rpx(10)),
                          padding: EdgeInsets.symmetric(vertical: rpx(10)),
                          color: Colors.white,
                          child: Row(
                            children: [
                              Container(
                                width: rpx(70),
                                child: TextWidget(data[index]["company"] != null
                                    ? data[index]["company"]["name_short"]
                                        .toString()
                                    : "无"),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: rpx(70),
                                child: Wrap(
                                  spacing: rpx(10),
                                  direction: Axis.vertical,
                                  children: [
                                    TextWidget("初"),
                                    TextWidget("即"),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: rpx(60),
                                child: Wrap(
                                  spacing: rpx(10),
                                  direction: Axis.vertical,
                                  children: [
                                    TextWidget(data[index]["init_pl"] != null
                                        ? data[index]["init_pl"][0]["dq"]
                                            .toString()
                                        : "无"),
                                    TextWidget(
                                      data[index]["cur_pl"] != null
                                          ? data[index]["cur_pl"][0]["dq"]
                                              .toString()
                                          : "无",
                                      color: getColor(
                                          data[index]["cur_pl"] ?? [], "dq"),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: rpx(60),
                                child: Wrap(
                                  spacing: rpx(10),
                                  direction: Axis.vertical,
                                  children: [
                                    TextWidget(data[index]["init_pl"] != null
                                        ? data[index]["init_pl"][0]["handicap"]
                                            .toString()
                                        : "无"),
                                    TextWidget(
                                      data[index]["cur_pl"] != null
                                          ? data[index]["cur_pl"][0]["handicap"]
                                              .toString()
                                          : "无",
                                      color: getColor(
                                          data[index]["cur_pl"] ?? [],
                                          "handicap"),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: rpx(60),
                                child: Wrap(
                                  spacing: rpx(10),
                                  direction: Axis.vertical,
                                  children: [
                                    TextWidget(data[index]["init_pl"] != null
                                        ? data[index]["init_pl"][0]["xq"]
                                            .toString()
                                        : "无"),
                                    TextWidget(
                                      data[index]["cur_pl"] != null
                                          ? data[index]["cur_pl"][0]["xq"]
                                              .toString()
                                          : "无",
                                      color: getColor(
                                          data[index]["cur_pl"] ?? [], "xq"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: rpx(4),
                        )
                      ],
                    )),
          )
        ],
      ),
    );
  }
}
