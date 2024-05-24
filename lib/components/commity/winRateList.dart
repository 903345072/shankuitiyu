import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/model/talentExpert.dart';
import 'package:jingcai_app/model/winRateListModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class winRateList extends StatefulWidget {
  int? type;
  winRateList({required this.type});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return winRateList_();
  }
}

class winRateList_ extends State<winRateList> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List mzList = [];

  @override
  void initState() {
    super.initState();
    G.api.game.getTalentRank({"limit": 15, "type": widget.type}).then((value) {
      setState(() {
        mzList = value;
      });
    });
  }

  getSingleRank(int index, Map data) {
    var url = "assets/images/second.png";

    if (index == 0) {
      url = "assets/images/second.png";
    }
    if (index == 1) {
      url = "assets/images/top.png";
    }
    if (index == 2) {
      url = "assets/images/third.png";
    }
    return onClick(
        Container(
          child: Stack(
            children: [
              Image.asset(
                url,
                fit: BoxFit.cover,
                width: rpx(110),
              ),
              Positioned(
                  left: rpx(15),
                  top: rpx(45),
                  child: Container(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: rpx(5),
                      direction: Axis.vertical,
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: rpx(3)),
                              child: CircleAvatar(
                                radius: rpx(20),
                                backgroundImage: NetworkImage(
                                  data["avatar"].toString(),
                                ),
                              ),
                            ),
                            Positioned(
                                right: rpx(0),
                                child: Container(
                                  height: 16,
                                  alignment: Alignment(0, 0),
                                  padding: EdgeInsets.only(
                                      left: rpx(4), right: rpx(4)),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.white),
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: TextWidget(
                                    data["plan_num"].toString(),
                                    color: Colors.white,
                                    fontSize: rpx(10),
                                  ),
                                )),
                          ],
                        ),
                        Container(
                          width: rpx(78),
                          child: TextWidget(data["real_name"].toString()),
                        ),
                        Container(
                          width: rpx(80),
                          padding: EdgeInsets.only(
                              left: rpx(3),
                              right: rpx(3),
                              top: rpx(2),
                              bottom: rpx(2)),
                          color: Color(0xfffdeaea),
                          child: TextWidget(
                            data["desc"].toString(),
                            color: Color(0xffd92b2b),
                            textAlign: TextAlign.center,
                            fontSize: rpx(10),
                          ),
                        ),
                        Container(
                          child: Text(
                            data["data"].toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: rpx(18),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        getFlowButton(index)
                      ],
                    ),
                  ))
            ],
          ),
        ), () {
      G.router.navigateTo(context,
          "/talentDetail" + G.parseQuery(params: {"uid": data["uid"]}));
    });
  }

  Widget getFlowButton(int index) {
    if (index < mzList.length) {
      return onClick(
          mzList[index]["is_subscribe"] == 1
              ? Container(
                  alignment: Alignment.center,
                  width: rpx(70),
                  height: rpx(30),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Text(
                    "已关注",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15)),
                  alignment: Alignment.center,
                  width: rpx(70),
                  height: rpx(30),
                  child: const Text(
                    "+关注",
                    style: TextStyle(color: Colors.white),
                  ),
                ), () {
        G.api.user.flowUser({"uid": mzList[index]["uid"]}).then((value) {
          setState(() {
            mzList[index]["is_subscribe"] =
                mzList[index]["is_subscribe"] == 1 ? 0 : 1;
          });
        });
      });
    } else {
      return Container();
    }
  }

  getTop3() {
    List list = mzList.length > 3 ? mzList.sublist(0, 3) : mzList;

    List<Widget> dd = [];
    if (list.length == 1) {
      dd = [
        getSingleRank(1, list[0]),
      ];
    }

    if (list.length == 2) {
      dd = [
        getSingleRank(1, list[0]),
        getSingleRank(0, list[1]),
      ];
    }

    if (list.length == 3) {
      dd = [
        getSingleRank(0, list[1]),
        getSingleRank(1, list[0]),
        getSingleRank(2, list[2]),
      ];
    }

    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: dd);
  }

  getTail() {
    List list = mzList;
    if (mzList.length <= 3) {
      return Container();
    } else {
      list = mzList.sublist(3, mzList.length);
    }

    return Column(
      children: List.generate(
          list.length,
          (index) => onClick(
                  Container(
                    padding: EdgeInsets.all(rpx(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: rpx(10),
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: rpx(5)),
                              child: Text(
                                (index + 4).toString(),
                                style: TextStyle(
                                    color: Colors.grey, fontSize: rpx(20)),
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: rpx(3)),
                                  child: CircleAvatar(
                                    radius: rpx(20),
                                    backgroundImage: NetworkImage(
                                      list[index]["avatar"].toString(),
                                    ),
                                  ),
                                ),
                                list[index]["plan_num"] > 0
                                    ? Positioned(
                                        right: rpx(0),
                                        child: Container(
                                          height: 16,
                                          alignment: Alignment(0, 0),
                                          padding: EdgeInsets.only(
                                              left: rpx(4), right: rpx(4)),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.white),
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: Text(
                                            list[index]["plan_num"].toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: rpx(10)),
                                          ),
                                        ))
                                    : Container(),
                              ],
                            ),
                            Wrap(
                              spacing: rpx(4),
                              direction: Axis.vertical,
                              children: [
                                Text(list[index]["real_name"].toString()),
                                Wrap(
                                  spacing: rpx(3),
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: rpx(5), right: rpx(5)),
                                      alignment: Alignment.center,
                                      color: Color(0xffffece8),
                                      child: TextWidget(
                                        list[index]["desc"].toString(),
                                        color: Color(0xffef2f2f),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          child: Text(
                            list[index]["data"].toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: rpx(18),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        getFlowButton(index + 3)
                      ],
                    ),
                  ), () {
                G.router.navigateTo(
                    context,
                    "/talentDetail" +
                        G.parseQuery(params: {"uid": list[index]["uid"]}));
              })),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: [getTop3(), getTail()],
    );
  }
}
