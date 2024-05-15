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
import 'package:jingcai_app/pages/home_pages/planDetail.dart';
import 'package:jingcai_app/pages/home_pages/planPreview.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class gameDetailPlan extends StatefulWidget {
  int? id;
  gameDetailPlan({required this.id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return basketSubject_();
  }
}

class basketSubject_ extends State<gameDetailPlan> {
  List expert_data = [];

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List recommend_list = [];
  int page = 1;
  @override
  void initState() {
    super.initState();

    getRecommend();
  }

  Future getRecommend() async {
    return G.api.game
        .getGamePlan({"page": page, "id": widget.id}).then((value) {
      setState(() {
        if (expert_data.isEmpty) {
          setState(() {
            expert_data = value["user"];
          });
        }
        recommend_list.addAll(value["plan"]);
      });
      return value["plan"];
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: classHeader(),
        controller: refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        footer: classFooter(),
        child: expert_data.length > 0
            ? ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: rpx(10), left: rpx(10)),
                    child: Text(
                      "达人解读",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: rpx(15)),
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
                                    child:
                                        expertExplain(data: expert_data[index]),
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
                    height: rpx(4),
                    color: Colors.grey.shade200,
                  ),
                  Container(
                    height: rpx(10),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: rpx(10)),
                    child: Text(
                      "方案推荐",
                      style: TextStyle(
                          fontSize: rpx(16), fontWeight: FontWeight.bold),
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
                                    user: userModel.fromJson(
                                        recommend_list[index]["user"]),
                                    plan: recommend_list[index],
                                    uid: recommend_list[index]["uid"],
                                  ),
                                ),
                              );
                            })),
                  )
                ],
              )
            : Container(
                child: Column(
                  children: [
                    Image.asset("assets/images/noPlan.png"),
                    TextWidget(
                      "暂无达人方案",
                      color: Colors.grey,
                    )
                  ],
                ),
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
