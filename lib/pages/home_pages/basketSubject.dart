import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:jingcai_app/components/expertExplain.dart';

import 'package:jingcai_app/model/BasketModel.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/model/recommendModel.dart';
import 'package:jingcai_app/model/talentExpert.dart';
import 'package:jingcai_app/model/userModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'planDetail.dart';
import 'planPreview.dart';

class basketSubject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return basketSubject_();
  }
}

class basketSubject_ extends State<basketSubject> {
  List expert_data = [];
  List<JcFootModel> hot_game = [];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List recommend_list = [];
  int page = 1;
  @override
  void initState() {
    super.initState();
    getExpertData();
    getHotGame();
    getRecommend();
  }

  Future getRecommend() async {
    return G.api.game.getObjectPlanList({"page": page}).then((value) {
      setState(() {
        recommend_list.addAll(value);
      });
      return value;
    });
  }

  getHotGame() {
    G.api.game.getSubject({}).then((value) {
      setState(() {
        hot_game = value;
      });
    });
  }

  getExpertData() {
    G.api.game.getTalentList({}).then((value) {
      setState(() {
        expert_data = value;
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
          "篮球专题方案",
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
              margin: EdgeInsets.only(top: rpx(10), left: rpx(10)),
              child: Text(
                "达人解读",
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: rpx(15)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: rpx(15), top: rpx(5)),
              height: rpx(80),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                    expert_data.length,
                    (index) => onClick(
                            Container(
                              margin: EdgeInsets.only(left: rpx(5)),
                              child: expertExplain(data: expert_data[index]),
                            ), () {
                          G.router.navigateTo(
                              context,
                              "/talentDetail" +
                                  G.parseQuery(params: {
                                    "uid": expert_data[index]["uid"]
                                  }));
                        })),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: rpx(10)),
              height: rpx(140),
              child: Swiper(
                  index: 0,
                  loop: false,
                  autoplay: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(rpx(10)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("近期赛事"),
                              Text("${index + 1}/${hot_game.length}")
                            ],
                          ),
                          onClick(
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
                                                    Container(
                                                      width: rpx(40),
                                                      child: TextWidget(
                                                        hot_game[index]
                                                            .leagues!
                                                            .nameShort
                                                            .toString(),
                                                        fontSize: rpx(12),
                                                      ),
                                                    ),
                                                    Text(
                                                      hot_game[index]
                                                          .startAt
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: rpx(12),
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 4,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: getBasketGameStateText(
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
                                                  child:
                                                      getBasketGameScoreTextWithWhite(
                                                          hot_game[index]
                                                              .statusId,
                                                          hot_game[index]
                                                              .currentScore,
                                                          color: Colors.red),
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
                              ), () {
                            G.router.navigateTo(
                                context,
                                // ignore: prefer_interpolation_to_compose_strings
                                "/basketGameDetail" +
                                    G.parseQuery(params: {
                                      "id": hot_game[index].id,
                                      "is_detail": 1
                                    }),
                                transition: TransitionType.inFromRight);
                          })
                        ],
                      ),
                    );
                  },
                  itemCount: hot_game.length),
            ),
            Container(
              padding: EdgeInsets.only(left: rpx(10)),
              child: Text(
                "方案推荐",
                style:
                    TextStyle(fontSize: rpx(16), fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: List.generate(
                  recommend_list.length,
                  (index) => onClick(
                          planPreview(
                            data: recommend_list[index],
                            show_head: true,
                          ), () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => planDetail(
                              user: userModel
                                  .fromJson(recommend_list[index]["user"]),
                              plan: recommend_list[index],
                              uid: recommend_list[index]["uid"],
                            ),
                          ),
                        );
                      })),
            )
          ],
        ),
      ),
    );
  }

  void _onRefresh() async {
    refreshController.loadComplete();
    setState(() {
      page = 1;
      recommend_list = [];
    });
    getRecommend();
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    setState(() {
      page++;
    });
    getRecommend().then((value) {
      if (value.isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    });
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
