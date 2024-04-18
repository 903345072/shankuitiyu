import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:jingcai_app/components/expertExplain.dart';
import 'package:jingcai_app/components/homes/planPreviewTest.dart';

import 'package:jingcai_app/model/BasketModel.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/model/recommendModel.dart';
import 'package:jingcai_app/model/talentExpert.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class hotMatchPage extends StatefulWidget {
  int id;
  int type;
  String name;
  hotMatchPage({required this.id, required this.type, required this.name});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return basketSubject_();
  }
}

class basketSubject_ extends State<hotMatchPage> {
  List<expertTalentDatum> expert_data = [];
  List<JcFootModel> hot_game = [];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List<recommendModel> recommend_list = [];
  @override
  void initState() {
    super.initState();
    getExpertData();
    getHotGame();
    getRecommend();
  }

  getRecommend() async {
    String recommendData =
        await rootBundle.loadString("assets/mock/recommend.json");
    final List recommenjsonresult = json.decode(recommendData)["data"];
    setState(() {
      recommend_list = recommenjsonresult
          .map((e) => recommendModel.fromJson((e as Map<String, dynamic>)))
          .toList();
    });
  }

  getHotGame() {
    G.api.gameAdd
        .getGamesByLeague({"id": widget.id, "type": widget.type}).then((value) {
      setState(() {
        hot_game = value;
      });
    });
  }

  getExpertData() {
    String url =
        "https://pay.jcyqr.com/banner_expert_read?cid=15&sv=4.51&dev=3&token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOlsiMTAuMTAuNTkuMTM3Ojk4MDkiXSwiYXVkIjpbIjEwLjEwLjU5LjEzNzo5ODA5Il0sImlhdCI6MTY5OTkzNTQ3MiwibmJmIjoxNjk5OTM1NDcyLCJleHAiOjE3MDI1Mjc0NzIsImp0aSI6eyJpZCI6NDg5NzQ3LCJ0eXBlIjoiSldUIn19._2ZutdiMA-E2h3xQHKbeFr23rnp0lbGJqRb0GEy3fcQ&client_sign=634582905056454119424_f800d30980b7dd5bd6f32ded548d5e27&sign=7F32A58BD552A47057A3CA07AFBDA555&timestamp=1701952302474&tea_utm_cache=undefined";
    final dio = Dio();
    dio.get(url).then((value) {
      var d = TalentExpertModel.fromJson(value.data);
      setState(() {
        expert_data = d.data!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: rpx(16)),
        ),
        centerTitle: true,
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: classHeader(),
        controller: refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        footer: classFooter(),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: rpx(10)),
              height: rpx(160),
              child: Swiper(
                  index: 0,
                  loop: false,
                  autoplay: true,
                  itemBuilder: (BuildContext context, int index) {
                    return onClick(
                        Container(
                          padding: EdgeInsets.all(rpx(10)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("近期赛事"),
                                  Text("${index + 1}/${hot_game.length}")
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.all(rpx(8)),
                                color: Color(0xffeaeffd),
                                margin: EdgeInsets.only(top: rpx(10)),
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                flex: 8,
                                                child: Wrap(
                                                  spacing: rpx(15),
                                                  children: [
                                                    Text(
                                                      hot_game[index]
                                                          .leagues!
                                                          .nameShort!
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: rpx(14)),
                                                    ),
                                                    Text(
                                                      hot_game[index]
                                                          .startAt
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: rpx(14),
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 4,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: widget.type == 0
                                                      ? getFootGameStateText(
                                                          hot_game[index]
                                                              .statusId,
                                                          hot_game[index]
                                                              .elapsed)
                                                      : getBasketGameStateText(
                                                          hot_game[index]),
                                                )),
                                            Expanded(
                                                flex: 8, child: Container())
                                          ],
                                        ),
                                        Container(
                                          height: rpx(10),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                flex: 8,
                                                child: Wrap(
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.center,
                                                  spacing: rpx(15),
                                                  alignment: WrapAlignment.end,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      width: rpx(70),
                                                      child: Text(
                                                          hot_game[index]
                                                              .homeTeam!
                                                              .nameShort
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontSize:
                                                                  rpx(14))),
                                                    ),
                                                    netImg(
                                                        hot_game[index]
                                                            .homeTeam!
                                                            .logo
                                                            .toString(),
                                                        rpx(35),
                                                        rpx(35))
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 4,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: widget.type == 0
                                                      ? getFootGameScoreText(
                                                          hot_game[index]
                                                              .statusId,
                                                          hot_game[index]
                                                              .currentScore)
                                                      : getBasketGameScoreTextWithWhite(
                                                          hot_game[index]
                                                              .statusId,
                                                          hot_game[index]
                                                              .currentScore),
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: rpx(5)),
                                                  child: Wrap(
                                                    alignment:
                                                        WrapAlignment.start,
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center,
                                                    spacing: rpx(15),
                                                    children: [
                                                      netImg(
                                                          hot_game[index]
                                                              .awayTeam!
                                                              .logo
                                                              .toString(),
                                                          rpx(35),
                                                          rpx(35)),
                                                      Container(
                                                        width: rpx(70),
                                                        child: Text(
                                                            hot_game[index]
                                                                .awayTeam!
                                                                .nameShort
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    rpx(13))),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ), () {
                      if (widget.type == 0) {
                        G.router.navigateTo(
                            context, // ignore: prefer_interpolation_to_compose_strings
                            "/gameDetail" +
                                G.parseQuery(params: {
                                  "id": hot_game[index].id,
                                  "is_detail": 1
                                }));
                      } else {
                        G.router.navigateTo(
                            context, // ignore: prefer_interpolation_to_compose_strings
                            "/basketGameDetail" +
                                G.parseQuery(params: {
                                  "id": hot_game[index].id,
                                  "is_detail": 1
                                }));
                      }
                    });
                  },
                  itemCount: hot_game.length),
            ),
            Container(
              padding: EdgeInsets.only(left: rpx(10)),
              child: Text(
                "赛事方案",
                style:
                    TextStyle(fontSize: rpx(16), fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: List.generate(recommend_list.length,
                  (index) => planPreviewTest(recmodel: recommend_list[index])),
            )
          ],
        ),
      ),
    );
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 3000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    refreshController.loadNoData();
  }

  getColor(BasketListElement e) {
    if (e.statusId == 1) {
      return Colors.grey;
    }
    if (e.statusId == 10) {
      return Colors.red;
    }

    if (e.statusId == 2 ||
        e.statusId == 4 ||
        e.statusId == 6 ||
        e.statusId == 8) {
      return Colors.green;
    }

    if (e.statusId == 3 || e.statusId == 5 || e.statusId == 7) {
      return Colors.green;
    }
  }

  Widget getExpert(expertTalentDatum data) {
    // TODO: implement build
    return Stack(
      children: [
        Positioned(
            top: rpx(5),
            left: rpx(15),
            child: CircleAvatar(
              radius: rpx(20),
              backgroundImage: NetworkImage(
                data.userImg.toString(),
              ),
            )),
        Container(
          margin: EdgeInsets.only(top: rpx(30)),
          width: rpx(75),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(1.5),
                margin: EdgeInsets.only(top: 2, bottom: 2),
                color: const Color(0xfffdeaea),
                child: Text(
                  data.zhong.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: rpx(10), color: const Color(0xffef2f2f)),
                ),
              ),
              Container(
                child: Text(
                  data.userName.toString(),
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: rpx(11), fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        data.onSaleCount! > 0
            ? Positioned(
                right: rpx(16),
                top: rpx(3),
                child: Container(
                  height: 16,
                  alignment: Alignment(0, 0),
                  padding: EdgeInsets.only(left: rpx(4), right: rpx(4)),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Text(
                    data.onSaleCount.toString(),
                    style: TextStyle(color: Colors.white, fontSize: rpx(10)),
                  ),
                ))
            : Container()
      ],
    );
  }
}
