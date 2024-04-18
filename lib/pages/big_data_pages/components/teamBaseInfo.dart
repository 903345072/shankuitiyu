import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class teamBaseInfo extends StatefulWidget {
  int id;
  teamBaseInfo({required this.id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return teamBaseInfo_();
  }
}

class teamBaseInfo_ extends State<teamBaseInfo> {
  @override
  void initState() {
    super.initState();
    print(widget.id);
    getData();
  }

  List? trans_in = [];
  List? trans_to = [];
  String? coach = "";
  JcFootModel? foot = JcFootModel.fromJson({
    "leagues": Map<String, dynamic>.from({}),
    "home_team": Map<String, dynamic>.from({}),
    "away_team": Map<String, dynamic>.from({})
  });
  getData() {
    G.api.gameAdd.getTeamBaseInfo({"id": widget.id}).then((value) {
      setState(() {
        foot = value["match"] != null
            ? JcFootModel.fromJson(value["match"])
            : null;
        trans_in = value["trans_in"];
        trans_to = value["trans_to"];
        coach = value["coach"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: [
        foot != null
            ? Container(
                margin: EdgeInsets.all(rpx(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: rpx(10),
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        TextWidget(foot!.leagues!.nameShort.toString()),
                        Container(
                          color: Colors.black,
                          height: rpx(12),
                          width: rpx(1),
                        ),
                        TextWidget(foot!.startAt.toString())
                      ],
                    ),
                    Container(
                      height: rpx(15),
                    ),
                    Container(
                      padding: EdgeInsets.all(rpx(10)),
                      decoration: BoxDecoration(
                          color: Color(0xff002868),
                          borderRadius: BorderRadius.circular(rpx(5))),
                      width: MediaQuery.of(context).size.width,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: rpx(15),
                        children: [
                          foot!.homeTeam!.logo != null
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(rpx(30))),
                                  child: netImg(
                                      foot!.homeTeam!.logo!, rpx(30), rpx(30)),
                                )
                              : Container(
                                  width: rpx(30),
                                ),
                          Container(
                            child: TextWidget(
                              foot!.homeTeam!.nameShort.toString(),
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            child: getFootGameScoreText(
                                foot!.statusId, foot!.currentScore),
                          ),
                          Container(
                            child: TextWidget(
                                foot!.awayTeam!.nameShort.toString(),
                                color: Colors.white),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(rpx(30))),
                            child: foot!.awayTeam!.logo != null
                                ? netImg(
                                    foot!.awayTeam!.logo!, rpx(30), rpx(30))
                                : Container(
                                    width: rpx(30),
                                  ),
                          )
                        ],
                      ),
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
        Container(
          margin: EdgeInsets.all(rpx(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                "统计",
                fontWeight: FontWeight.bold,
              ),
              Container(
                height: rpx(15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget("教练"),
                  TextWidget(
                    coach.toString(),
                    fontWeight: FontWeight.bold,
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          height: rpx(5),
        ),
        Container(
          height: rpx(4),
          color: Colors.grey.shade100,
        ),
        Container(
          margin: EdgeInsets.all(rpx(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                "转会",
                fontWeight: FontWeight.bold,
              ),
              Container(
                height: rpx(15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  trans_in!.isNotEmpty
                      ? Container(
                          width: rpx(170),
                          padding: EdgeInsets.all(rpx(15)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26.withOpacity(0.1), // 阴影的颜色
                                offset: Offset(1, 2), // 阴影与容器的距离
                                blurRadius: 5.0, // 高斯的标准偏差与盒子的形状卷积。
                                spreadRadius: 0.0, // 在应用模糊之前，框应该膨胀的量。
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              TextWidget(
                                "转入(${trans_in!.length})",
                                color: Colors.green,
                                fontSize: rpx(15),
                              ),
                              Container(
                                height: rpx(10),
                              ),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: List.generate(
                                    trans_in!.length >= 3
                                        ? 3
                                        : trans_in!.length,
                                    (index) => trans_in![index]["player"]
                                                ["logo"] !=
                                            null
                                        ? netImg(
                                            trans_in![index]["player"]["logo"],
                                            rpx(40),
                                            rpx(40))
                                        : Container(
                                            width: rpx(40),
                                          )),
                              ),
                            ],
                          ))
                      : Container(),
                  SizedBox(
                    width: rpx(5),
                  ),
                  trans_to!.isNotEmpty
                      ? Container(
                          width: rpx(170),
                          padding: EdgeInsets.all(rpx(15)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26.withOpacity(0.1), // 阴影的颜色
                                offset: Offset(1, 2), // 阴影与容器的距离
                                blurRadius: 5.0, // 高斯的标准偏差与盒子的形状卷积。
                                spreadRadius: 0.0, // 在应用模糊之前，框应该膨胀的量。
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              TextWidget(
                                "转出(${trans_to!.length})",
                                color: Colors.red,
                                fontSize: rpx(15),
                              ),
                              Container(
                                height: rpx(10),
                              ),
                              Wrap(
                                spacing: rpx(5),
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: List.generate(
                                    trans_to!.length >= 3
                                        ? 3
                                        : trans_to!.length,
                                    (index) => trans_to![index]["player"]
                                                ["logo"] !=
                                            null
                                        ? netImg(
                                            trans_to![index]["player"]["logo"],
                                            rpx(40),
                                            rpx(40))
                                        : Container(
                                            width: rpx(40),
                                          )),
                              ),
                            ],
                          ))
                      : Container()
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
