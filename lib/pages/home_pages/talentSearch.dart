import 'package:flutter/material.dart';
import 'package:jingcai_app/components/scores/basketGame.dart';
import 'package:jingcai_app/components/scores/footGame.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/model/userModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/InputWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/pages/home_pages/talentDetail.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/loading.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../botom_pages/widget/routes.dart';

class talentSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return gameSearch_();
  }
}

class gameSearch_ extends State<talentSearch> {
  TextEditingController controller = TextEditingController();
  String text = "";
  List talent = [];

  List search = [];

  int page = 1;
  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      text = controller.value.text;
      if (text.isEmpty) {
        setState(() {
          talent = [];
        });
      }
    });
    getGameSearch();
  }

  getGameSearch() {
    G.api.user.getTalentSearchRecord({}).then((value) {
      setState(() {
        search = value;
      });
    });
  }

  Future searchTalent() {
    return G.api.user.searchTalent({"page": page, "text": text}).then((value) {
      setState(() {
        talent.addAll(value);
      });
      if (value.isEmpty) {
        Loading.tip("searchgame", "无数据");
      }
      return value;
    });
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void _onLoading() async {
    if (talent.isNotEmpty) {
      setState(() {
        page++;
      });
      searchTalent().then((value) {
        if (value.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SmartRefresher(
      enablePullDown: false,
      enablePullUp: true,
      controller: refreshController,
      onLoading: _onLoading,
      footer: classFooter(),
      child: ListView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        children: [
          Container(
            padding: EdgeInsets.all(rpx(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                onClick(Icon(Icons.arrow_back_ios), () {
                  G.router.pop(context);
                }),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: rpx(10)),
                  width: rpx(250),
                  height: rpx(30),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(rpx(3))),
                  child: InputWidget(
                    textInputType: TextInputType.multiline,
                    controller: controller,
                    hintText: "搜索达人",
                    hintStyle: TextStyle(
                        fontSize: rpx(13), color: Colors.grey.shade400),
                    icon: Image.asset(
                      "assets/images/search_grey.png",
                      width: rpx(20),
                      height: rpx(20),
                      color: Colors.grey,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                onClick(
                    TextWidget(
                      "搜索",
                      color: Colors.red,
                      fontSize: rpx(15),
                    ), () {
                  setState(() {
                    talent = [];
                    page = 1;
                  });
                  if (text.isNotEmpty) {
                    searchTalent();
                  }
                })
              ],
            ),
          ),
          search.isNotEmpty && (talent.isEmpty)
              ? Container(
                  padding: EdgeInsets.all(rpx(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        "最近搜索",
                        fontWeight: FontWeight.bold,
                        fontSize: rpx(15),
                      ),
                      SizedBox(
                        height: rpx(10),
                      ),
                      Wrap(
                        runSpacing: rpx(10),
                        spacing: rpx(10),
                        direction: Axis.horizontal,
                        children: List.generate(
                            search.length,
                            (index) => onClick(
                                    Container(
                                      width: rpx(55),
                                      alignment: Alignment.center,
                                      height: rpx(25),
                                      padding: EdgeInsets.only(
                                        left: rpx(10),
                                        right: rpx(10),
                                      ),
                                      color: Colors.grey.shade200,
                                      child: TextWidget(
                                        search[index]["content"],
                                        color: Colors.grey.shade500,
                                        textAlign: TextAlign.center,
                                      ),
                                    ), () {
                                  setState(() {
                                    text = search[index]["content"];
                                    controller.text = text;
                                    talent = [];

                                    page = 1;
                                    searchTalent();
                                  });
                                })),
                      )
                    ],
                  ),
                )
              : Container(),
          talent.isNotEmpty
              ? Column(
                  children: List.generate(
                      talent.length,
                      (index) => onClick(
                              Container(
                                margin: EdgeInsets.all(rpx(10)),
                                padding: EdgeInsets.only(bottom: rpx(10)),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.only(top: rpx(3)),
                                              child: CircleAvatar(
                                                radius: rpx(20),
                                                backgroundImage: NetworkImage(
                                                  talent[index]["avatar"]
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                            talent[index]["plan_count"] > 0
                                                ? Positioned(
                                                    right: rpx(0),
                                                    child: Container(
                                                      height: 16,
                                                      alignment:
                                                          Alignment(0, 0),
                                                      padding: EdgeInsets.only(
                                                          left: rpx(4),
                                                          right: rpx(4)),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color:
                                                                  Colors.white),
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8))),
                                                      child: Text(
                                                        talent[index]
                                                                ["plan_count"]
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: rpx(10)),
                                                      ),
                                                    ))
                                                : Container(),
                                          ],
                                        ),
                                        SizedBox(
                                          width: rpx(10),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                              talent[index]["real_name"]
                                                  .toString(),
                                            ),
                                            SizedBox(
                                              height: rpx(5),
                                            ),
                                            TextWidget(
                                                "粉丝数${talent[index]["fans"]}人")
                                          ],
                                        )
                                      ],
                                    ),
                                    getFlowButton(talent[index]["is_subscribe"],
                                        talent[index]["uid"], index)
                                  ],
                                ),
                              ), () {
                            G.router.navigateTo(
                                context,
                                "/talentDetail" +
                                    G.parseQuery(
                                        params: {"uid": talent[index]["uid"]}));
                          })),
                )
              : Container(),
        ],
      ),
    ));
  }

  Widget getFlowButton(int i, int uid, int index) {
    return onClick(
        i == 1
            ? Container(
                alignment: Alignment.center,
                width: rpx(70),
                height: rpx(30),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  "已关注",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(15)),
                alignment: Alignment.center,
                width: rpx(70),
                height: rpx(30),
                child: Text(
                  "+关注",
                  style: TextStyle(color: Colors.white),
                ),
              ), () {
      G.api.user.flowUser({"uid": uid}).then((value) {
        setState(() {
          talent[index]["is_subscribe"] =
              talent[index]["is_subscribe"] == 1 ? 0 : 1;
          if (talent[index]["is_subscribe"] == 0) {
            talent[index]["fans"]--;
          } else {
            talent[index]["fans"]++;
          }
        });
      });
    });
  }
}
