import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/components/bigData/aiPlanPreview.dart';
import 'package:jingcai_app/model/historyPlanModel.dart';
import 'package:jingcai_app/model/talentModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/pages/home_pages/planDetail.dart';
import 'package:jingcai_app/pages/home_pages/planPreview.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:jingcai_app/model/userModel.dart';

class talentPlanRecord extends StatefulWidget {
  int? type;

  talentPlanRecord({super.key, required this.type});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return talentPlanRecord_();
  }
}

class talentPlanRecord_ extends State<talentPlanRecord> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List expert_list = [];
  int page = 1;
  @override
  void initState() {
    super.initState();
    getExpertInfo(widget.type, false);
  }

  Future getExpertInfo(int? type, bool clear) async {
    if (clear) {
      setState(() {
        expert_list = [];
      });
    }

    return G.api.game
        .getUserBuyPlan({"page": page, "type": type}).then((value) {
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
      enablePullUp: true,
      header: classHeader(),
      controller: refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      footer: classFooter(),
      child: expert_list.length > 0
          ? ListView(
              children: List.generate(
                  expert_list.length,
                  (index) => Column(
                        children: [
                          onClick(
                              planPreview(
                                data: expert_list[index],
                                show_head: true,
                              ), () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => planDetail(
                                  user: userModel
                                      .fromJson(expert_list[index]["user"]),
                                  plan: expert_list[index],
                                  uid: expert_list[index]["uid"],
                                ),
                              ),
                            );
                          }),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: rpx(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget(
                                  "实付金额: ${expert_list[index]["pay_money"]}",
                                  color: Colors.grey,
                                ),
                                TextWidget(
                                  "正常",
                                  color: Colors.grey,
                                ),
                                Container()
                              ],
                            ),
                          ),
                          SizedBox(
                            height: rpx(10),
                          ),
                          Container(
                            height: rpx(4),
                            color: Colors.grey.shade100,
                          )
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

  void _onLoading() async {
    setState(() {
      page++;
    });
    getExpertInfo(widget.type, false).then((value) {
      if (value.isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    });
  }
}
