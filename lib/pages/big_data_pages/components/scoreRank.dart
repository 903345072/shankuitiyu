import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class scoreRank extends StatefulWidget {
  int id;
  int season_id;
  scoreRank({super.key, required this.id, required this.season_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return scoreRank_();
  }
}

class scoreRank_ extends State<scoreRank> {
  @override
  void initState() {
    super.initState();
    // print(widget.id);
    getData(seson_id: widget.season_id);
  }

  getData({int? seson_id}) {
    G.api.gameAdd
        .getRank({"id": widget.id, "season_id": seson_id}).then((value) {
      setState(() {
        data = value;
      });
    });
  }

  Map data = {};

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return data.isNotEmpty
        ? ListView(
            children: data.entries
                .map((entry) => Container(
                      margin: EdgeInsets.symmetric(vertical: rpx(10)),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            color: Color(0xff002868),
                            padding: EdgeInsets.symmetric(
                                vertical: rpx(5), horizontal: rpx(10)),
                            child: TextWidget(
                              entry.key,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            color: Color(0xfff0f0f0),
                            padding: EdgeInsets.symmetric(
                                vertical: rpx(5), horizontal: rpx(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: rpx(30),
                                  alignment: Alignment.center,
                                  child: TextWidget("排名"),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: rpx(100),
                                  child: TextWidget("球队"),
                                ),
                                Container(
                                  width: rpx(35),
                                  alignment: Alignment.center,
                                  child: TextWidget("场次"),
                                ),
                                Container(
                                  width: rpx(55),
                                  alignment: Alignment.center,
                                  child: TextWidget("胜/平/负"),
                                ),
                                Container(
                                  width: rpx(45),
                                  alignment: Alignment.center,
                                  child: TextWidget("进/失"),
                                ),
                                Container(
                                  width: rpx(35),
                                  alignment: Alignment.center,
                                  child: TextWidget("积分"),
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Colors.black26.withOpacity(0.1), // 阴影的颜色
                                  offset: Offset(1, 2), // 阴影与容器的距离
                                  blurRadius: 5.0, // 高斯的标准偏差与盒子的形状卷积。
                                  spreadRadius: 0.0, // 在应用模糊之前，框应该膨胀的量。
                                ),
                              ],
                            ),
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: EdgeInsets.symmetric(
                                vertical: rpx(5), horizontal: rpx(10)),
                            child: Column(
                              children: List.generate(
                                  entry.value.length,
                                  (index) => Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: rpx(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: rpx(30),
                                              alignment: Alignment.center,
                                              child: TextWidget(entry
                                                  .value[index]["position"]
                                                  .toString()),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: rpx(100),
                                              child: Wrap(
                                                spacing: rpx(5),
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                children: [
                                                  entry.value[index]["team"]
                                                              ["logo"] !=
                                                          null
                                                      ? netImg(
                                                          entry.value[index]
                                                              ["team"]["logo"],
                                                          rpx(20),
                                                          rpx(20))
                                                      : Container(
                                                          width: rpx(20),
                                                        ),
                                                  Container(
                                                    width: rpx(50),
                                                    child: TextWidget(
                                                      entry.value[index]["team"]
                                                          ["name_short"],
                                                      fontSize: rpx(12),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: rpx(35),
                                              alignment: Alignment.center,
                                              child: TextWidget(entry
                                                  .value[index]["matches"]
                                                  .toString()),
                                            ),
                                            Container(
                                              width: rpx(55),
                                              alignment: Alignment.center,
                                              child: TextWidget(
                                                  "${entry.value[index]["wins"].toString()}/${entry.value[index]["draws"].toString()}/${entry.value[index]["losses"].toString()}"),
                                            ),
                                            Container(
                                              width: rpx(45),
                                              alignment: Alignment.center,
                                              child: TextWidget(
                                                  "${entry.value[index]["goals_for"].toString()}/${entry.value[index]["goals_against"].toString()}"),
                                            ),
                                            Container(
                                              width: rpx(35),
                                              alignment: Alignment.center,
                                              child: TextWidget(
                                                  "${entry.value[index]["points"].toString()}"),
                                            )
                                          ],
                                        ),
                                      )),
                            ),
                          )
                        ],
                      ),
                    ))
                .toList(),
          )
        : Container(
            alignment: Alignment.center,
            child: TextWidget("暂无数据"),
          );
  }
}
