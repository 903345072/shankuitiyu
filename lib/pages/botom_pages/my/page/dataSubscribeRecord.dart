import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/components/bigData/aiPlanPreview.dart';
import 'package:jingcai_app/model/historyPlanModel.dart';
import 'package:jingcai_app/model/talentModel.dart';
import 'package:jingcai_app/pages/botom_pages/my/page/subscribeDataDetail.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/pages/home_pages/planDetail.dart';
import 'package:jingcai_app/pages/home_pages/planPreview.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:jingcai_app/model/userModel.dart';

class dataSubscribeRecord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return talentPlanRecord_();
  }
}

class talentPlanRecord_ extends State<dataSubscribeRecord> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List expert_list = [];
  int page = 1;
  @override
  void initState() {
    super.initState();
    getExpertInfo();
  }

  Future getExpertInfo() async {
    return G.api.game.getUserBuyData({}).then((value) {
      setState(() {
        expert_list.addAll(value);
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SmartRefresher(
      enablePullDown: false,
      enablePullUp: false,
      header: classHeader(),
      controller: refreshController,
      onRefresh: _onRefresh,
      footer: classFooter(),
      child: expert_list.length > 0
          ? ListView(
              children: List.generate(
                  expert_list.length,
                  (index) => Column(
                        children: [
                          onClick(
                              Container(
                                padding: EdgeInsets.all(rpx(15)),
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          expert_list[index]["title"],
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(
                                          height: rpx(15),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            netImg(expert_list[index]["logo"],
                                                rpx(100), rpx(100)),
                                            SizedBox(
                                              width: rpx(15),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  width: rpx(220),
                                                  child: Text(
                                                    expert_list[index]["desc"]
                                                        .toString(),
                                                    softWrap: true,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontSize: rpx(12)),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    TextWidget("原价"),
                                                    TextWidget(
                                                      expert_list[index]
                                                              ["price"]
                                                          .toString(),
                                                      color: Colors.red,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: rpx(10),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: rpx(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextWidget(
                                            "实付金额: ${expert_list[index]["pay_money"]}",
                                            color: Colors.grey,
                                          ),
                                          TextWidget(
                                            "正常",
                                            color: Colors.grey,
                                          ),
                                          onClick(
                                              Row(
                                                children: [
                                                  Container(
                                                    child: TextWidget(
                                                      "订单详情",
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Icon(Icons.arrow_right)
                                                ],
                                              ),
                                              () => null)
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: rpx(10),
                                    ),
                                    Container(
                                      height: rpx(2),
                                      color: Colors.grey.shade100,
                                    )
                                  ],
                                ),
                              ), () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => subscribeDataDetail(
                                    data: expert_list[index]),
                              ),
                            );
                          }),
                        ],
                      )),
            )
          : Container(
              height: rpx(200),
              alignment: Alignment.center,
              child: TextWidget("暂无数据"),
            ),
    );
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }
}
