import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class teamLineUp extends StatefulWidget {
  int id;
  teamLineUp({required this.id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return teamLineUp_();
  }
}

class teamLineUp_ extends State<teamLineUp> {
  Map? coach;
  Map? data;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    G.api.gameAdd.getTeamLineUp({"id": widget.id}).then((value) {
      setState(() {
        coach = value["coach"];
        data = value["homes"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: [
        coach != null
            ? Container(
                margin: EdgeInsets.all(rpx(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      "主教练",
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: rpx(15),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: rpx(10),
                      children: [
                        netImg(coach!["logo"], rpx(30), rpx(30)),
                        TextWidget(coach!["name_short"])
                      ],
                    )
                  ],
                ),
              )
            : Container(),
        Container(
          height: rpx(15),
        ),
        Container(
          height: rpx(4),
          color: Colors.grey.shade100,
        ),
        data != null
            ? Column(
                children: data!.entries
                    .map((e) => Container(
                          margin: EdgeInsets.all(rpx(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                getPoSition(e.key.toString()),
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: rpx(10),
                              ),
                              Column(
                                children: List.generate(
                                    e.value.length,
                                    (index) => Container(
                                          padding:
                                              EdgeInsets.only(bottom: rpx(10)),
                                          margin: EdgeInsets.symmetric(
                                              vertical: rpx(10)),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: rpx(1),
                                                      color: Colors
                                                          .grey.shade100))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                spacing: rpx(15),
                                                children: [
                                                  netImg(
                                                      e.value[index]["player"]
                                                          ["logo"],
                                                      rpx(30),
                                                      rpx(30)),
                                                  TextWidget(e.value[index]
                                                          ["shirt_number"]
                                                      .toString()),
                                                  TextWidget(e.value[index]
                                                          ["player"]
                                                          ["name_short"]
                                                      .toString())
                                                ],
                                              ),
                                              TextWidget(
                                                e.value[index]["player"]
                                                        ["market_value"]
                                                    .toString(),
                                                color: Colors.red,
                                              )
                                            ],
                                          ),
                                        )),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              )
            : Container()
      ],
    );
  }

  String getPoSition(String id) {
    String c = "";
    Map s = {
      "1": "前锋",
      "2": "中锋",
      "3": "中场",
      "4": "后卫",
      "5": "守门员",
      "10": "教练"
    };
    if (s.containsKey(id)) {
      c = s[id];
    }
    return c;
  }
}
