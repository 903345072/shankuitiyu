import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/model/userModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/pages/home_pages/planDetail.dart';
import 'package:jingcai_app/pages/home_pages/planPreview.dart';
import 'package:jingcai_app/pages/home_pages/talentBattleChart.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';

class talentDetail extends StatefulWidget {
  int? uid;
  talentDetail({required this.uid});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return talentDetail_();
  }
}

class talentDetail_ extends State<talentDetail> {
  userModel user = userModel.fromJson({"uid": 1, "fans": 0});
  Map userBattle = {};
  List plans = [];
  int fans = 0;
  void initState() {
    super.initState();
    getData();
    getPlans();
  }

  getPlans() {
    G.api.user.getPlans({"uid": widget.uid}).then((value) {
      setState(() {
        plans = value;
      });
    });
  }

  getData() {
    G.api.user.getUserBattleRecord({"uid": widget.uid}).then((value) {
      setState(() {
        userBattle = value;
        user = userModel.fromJson(value["user"]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(
          "达人详情",
          color: Colors.white,
        ),
        centerTitle: true,
        leading: onClick(
            const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ), () {
          G.router.pop(context);
        }),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: [
          userBattle.isNotEmpty
              ? Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(rpx(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: rpx(3)),
                                child: CircleAvatar(
                                  radius: rpx(25),
                                  backgroundImage: NetworkImage(
                                    user.avatar.toString(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: rpx(8),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    user.realName.toString(),
                                    color: Colors.white,
                                    fontSize: rpx(25),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Container(
                                    height: rpx(20),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: rpx(5)),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(rpx(20)),
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: TextWidget(
                                      "${userBattle["desc"]}",
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          getFlowButton(userBattle["is_subscribe"])
                        ],
                      ),
                      SizedBox(
                        height: rpx(10),
                      ),
                      Text(
                        user.introduce.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: rpx(12),
                            fontWeight: FontWeight.w600,
                            height: rpx(1.8)),
                        softWrap: true,
                      ),
                      SizedBox(
                        height: rpx(10),
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: rpx(5),
                        children: [
                          TextWidget(
                            "${userBattle["fans_count"]}粉丝",
                            color: Colors.white,
                          ),
                          TextWidget(
                            "|",
                            color: Colors.white,
                            fontSize: rpx(14),
                          ),
                          TextWidget(
                            "${userBattle["plan_count"]}方案",
                            color: Colors.white,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : Container(),
          SizedBox(
            height: rpx(15),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(rpx(10)),
            child: TextWidget(
              "近期战绩 (近10场)",
              fontSize: rpx(16),
              fontWeight: FontWeight.bold,
            ),
          ),
          userBattle.isNotEmpty
              ? Wrap(
                  direction: Axis.vertical,
                  spacing: rpx(10),
                  children: [
                    Container(
                      width: rpx(330),
                      margin: EdgeInsets.only(
                          top: rpx(25), right: rpx(10), left: rpx(10)),
                      height: rpx(80),
                      child: talentBattleChart(
                        homes: userBattle["trend"],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Wrap(
                        spacing: rpx(10),
                        children: [
                          TextWidget(
                            "近10场走势",
                            color: Colors.grey,
                          ),
                          TextWidget(
                            "${getResultNum(3)}红",
                            color: Colors.red,
                          ),
                          TextWidget(
                            "${getResultNum(2)}走",
                            color: Color(0xff002868),
                          ),
                          TextWidget(
                            "${getResultNum(1)}黑",
                            color: Colors.black,
                          )
                        ],
                      ),
                    )
                  ],
                )
              : Container(),
          SizedBox(
            height: rpx(15),
          ),
          userBattle.isNotEmpty
              ? Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // userBattle["back_rate"] >= 0
                      //     ? getCon(userBattle["back_rate"].toString() + "%", "盈利率")
                      //     : Container(
                      //         color: Color.fromRGBO(0, 0, 0, .04),
                      //         width: MediaQuery.of(context).size.width * 0.215,
                      //         height: rpx(70),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           crossAxisAlignment: CrossAxisAlignment.center,
                      //           children: [
                      //             TextWidget(
                      //               "亏损中",
                      //               fontSize: rpx(18),
                      //               color: Colors.green,
                      //             ),
                      //             SizedBox(
                      //               height: rpx(5),
                      //             ),
                      //             TextWidget(
                      //               "盈利率",
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      getCon(userBattle["back_rate"].toString(), "%", "盈利率"),
                      getCon(userBattle["hong_rate"].toString(), "%", "命中率"),
                      getCon(userBattle["late_hong"].toString(), "连红", "近期情况"),
                      getCon(
                          userBattle["history_hong"].toString(), "连红", "最高连红")
                    ],
                  ),
                )
              : Container(),
          SizedBox(
            height: rpx(15),
          ),
          Container(
            height: rpx(4),
            color: Colors.grey.shade100,
          ),
          Container(
            margin: EdgeInsets.all(rpx(10)),
            alignment: Alignment.centerLeft,
            child: TextWidget(
              "最近方案",
              fontSize: rpx(16),
              fontWeight: FontWeight.bold,
            ),
          ),
          plans.length > 0 && userBattle.isNotEmpty
              ? Column(
                  children: List.generate(
                      plans.length,
                      (index) => onClick(
                              planPreview(
                                data: plans[index],
                                show_head: false,
                              ), () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => planDetail(
                                  user: user,
                                  plan: plans[index],
                                  uid: widget.uid,
                                ),
                              ),
                            );
                          })),
                )
              : Container(
                  alignment: Alignment.center,
                  child: TextWidget("暂无方案"),
                )
        ],
      ),
    );
  }

  Widget getCon(String num, String tag, String title) {
    return Container(
      color: Color.fromRGBO(0, 0, 0, .04),
      width: MediaQuery.of(context).size.width * 0.215,
      height: rpx(70),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextWidget(
            double.parse(num) >= 0 ? num + tag : "亏损中",
            fontSize: rpx(18),
            color: getColor(num),
          ),
          SizedBox(
            height: rpx(5),
          ),
          TextWidget(
            title,
          ),
        ],
      ),
    );
  }

  Color getColor(String num) {
    Color c = Colors.red;

    if (double.parse(num) < 0) {
      c = Colors.green;
    }

    return c;
  }

  int getResultNum(int i) {
    List s = userBattle["trend"];
    return s.where((element) {
      return element == i;
    }).length;
  }

  Widget getFlowButton(int i) {
    return onClick(
        i == 1
            ? Container(
                alignment: Alignment.center,
                width: rpx(70),
                height: rpx(30),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15)),
                child: const Text(
                  "已关注",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                alignment: Alignment.center,
                width: rpx(70),
                height: rpx(30),
                child: const Text(
                  "+关注",
                  style: TextStyle(color: Colors.red),
                ),
              ), () {
      G.api.user.flowUser({"uid": widget.uid}).then((value) {
        setState(() {
          userBattle["is_subscribe"] = userBattle["is_subscribe"] == 1 ? 0 : 1;
          if (userBattle["is_subscribe"] == 0) {
            userBattle["fans_count"]--;
          } else {
            userBattle["fans_count"]++;
          }
        });
      });
    });
  }
}
