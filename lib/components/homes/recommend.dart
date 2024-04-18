import 'dart:async';
import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jingcai_app/components/homes/expertPreview.dart';

import 'package:jingcai_app/components/homes/planPreviewTest.dart';
import 'package:jingcai_app/model/expert.dart';
import 'package:jingcai_app/model/recommendModel.dart';
import 'package:jingcai_app/model/userModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/pages/commity_pages/talentEvent.dart';
import 'package:jingcai_app/pages/home_pages/planDetail.dart';
import 'package:jingcai_app/pages/home_pages/planPreview.dart';
import 'package:jingcai_app/pages/login/userEvent.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hot_expert.dart';

class recommend extends StatefulWidget {
  int type = 1;
  recommend({required this.type});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _recommend();
  }
}

class _recommend extends State<recommend> {
  List data = [];
  List<expert> expert_data = [];
  bool is_login = false;
  StreamSubscription? loginSubscription;
  StreamSubscription? talentSubscription;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int page = 1;
  @override
  void initState() {
    super.initState();
    getReCommendData();
    getIsLogin();
    loginSubscription = eventBus.on<userEvent>().listen((event) {
      if (mounted) {
        setState(() {
          is_login = event.is_login;
        });
        if (is_login == true) {
          setState(() {
            data = [];
            page = 1;
          });
          getReCommendData();
        }
      }
    });
    talentSubscription = talentBus.on<talentEvent>().listen((event) {
      if (mounted) {
        setState(() {
          data = [];
          page = 1;
        });
        getReCommendData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    loginSubscription!.cancel();
    talentSubscription!.cancel();
  }

  getIsLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      if (sharedPreferences.getBool("is_login") != null) {
        is_login = sharedPreferences.getBool("is_login")!;
      } else {
        is_login = false;
      }
    });
  }

  Future getReCommendData() async {
    return G.api.game
        .getFlowPlanList({"page": page, "type": widget.type}).then((value) {
      setState(() {
        data.addAll(value["plans"]);
        List d = value["flows"];
        expert_data =
            d.map((e) => expert.fromJson((e as Map<String, dynamic>))).toList();
      });
      return value["plans"];
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: classHeader(),
        controller: refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        footer: classFooter(),
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            widget.type == 1
                ? Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: getFlows(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: rpx(6)),
                        height: rpx(4),
                        color: Colors.grey.shade100,
                      ),
                    ],
                  )
                : Container(),
            data.length > 0
                ? Column(
                    children: List.generate(
                        data.length,
                        (index) => onClick(
                                planPreview(
                                  data: data[index],
                                  show_head: true,
                                ), () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => planDetail(
                                    user:
                                        userModel.fromJson(data[index]["user"]),
                                    plan: data[index],
                                    uid: data[index]["uid"],
                                  ),
                                ),
                              );
                            })),
                  )
                : Container(
                    height: rpx(300),
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/nosubscribe.png",
                      width: rpx(150),
                    ),
                  ),
          ],
        ));
  }

  List<Widget> getFlows() {
    List<Widget> s = [];

    if (is_login == false) {
      s = [
        Container(
          margin: EdgeInsets.symmetric(vertical: rpx(10)),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
            children: [
              TextWidget("登录获取更多达人内容"),
              Container(
                height: rpx(10),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: rpx(70)),
                child: clickBtn("前往登录", () {
                  G.router.navigateTo(context, "/login");
                }),
              )
            ],
          ),
        )
      ];
    } else {
      if (expert_data.isEmpty) {
        s = [
          Container(
            margin: EdgeInsets.symmetric(vertical: rpx(10)),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Column(
              children: [
                TextWidget("暂未关注任何人"),
                Container(
                  height: rpx(10),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: rpx(70)),
                  child: clickBtn("前往关注", () {
                    var p = {"index": 0, "is_flow": 0};
                    G.router.navigateTo(
                        context, "/expertTalent" + G.parseQuery(params: p),
                        transition: TransitionType.inFromRight);
                  }),
                )
              ],
            ),
          )
        ];
      } else {
        s = List.generate(
            expert_data.length >= 3 ? 3 : expert_data.length,
            (index) => onClick(
                expertPreview(expertModel: expert_data[index]),
                () => G.router.navigateTo(
                    context,
                    "/talentDetail" +
                        G.parseQuery(
                            params: {"uid": expert_data[index].userId}))));
        s.add(onClick(
            Container(
              alignment: Alignment.center,
              height: rpx(50),
              width: rpx(50),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(rpx(50))),
              child: TextWidget(
                "全部",
                color: Colors.red,
              ),
            ), () {
          var p = {"index": 0, "is_flow": 1};
          G.router.navigateTo(
              context, "/expertTalent" + G.parseQuery(params: p),
              transition: TransitionType.inFromRight);
        }));
      }
    }

    return s;
  }

  void _onRefresh() async {
    refreshController.loadComplete();
    setState(() {
      page = 1;
      data = [];
    });
    getReCommendData();
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    setState(() {
      page++;
    });
    getReCommendData().then((value) {
      if (value.isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    });
  }
}
