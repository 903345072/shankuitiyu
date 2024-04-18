import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';

class ouzhiList extends StatefulWidget {
  int? id;
  ouzhiList({required this.id});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ouzhiList_();
  }
}

class ouzhiList_ extends State<ouzhiList> {
  List data = [];

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() {
    G.api.game.getFootPl({"id": widget.id, "type": 1}).then((value) {
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
                  child: TextWidget("主胜"),
                ),
                Container(
                  width: rpx(60),
                  child: TextWidget("平局"),
                ),
                Container(
                  width: rpx(60),
                  child: TextWidget("客胜"),
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
                                        ? data[index]["init_pl"][0]["win"]
                                            .toString()
                                        : "无"),
                                    TextWidget(
                                      data[index]["cur_pl"] != null
                                          ? data[index]["cur_pl"][0]["win"]
                                              .toString()
                                          : "无",
                                      color: getColor(
                                          data[index]["cur_pl"] ?? [], "win"),
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
                                        ? data[index]["init_pl"][0]["draw"]
                                            .toString()
                                        : "无"),
                                    TextWidget(
                                      data[index]["cur_pl"] != null
                                          ? data[index]["cur_pl"][0]["draw"]
                                              .toString()
                                          : "无",
                                      color: getColor(
                                          data[index]["cur_pl"] ?? [], "draw"),
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
                                        ? data[index]["init_pl"][0]["loss"]
                                            .toString()
                                        : "无"),
                                    TextWidget(
                                      data[index]["cur_pl"] != null
                                          ? data[index]["cur_pl"][0]["loss"]
                                              .toString()
                                          : "无",
                                      color: getColor(
                                          data[index]["cur_pl"] ?? [], "loss"),
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
