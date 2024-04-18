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

class sellhistoryPlan extends StatefulWidget {
  int? type;
  int? state;
  sellhistoryPlan({super.key, required this.type, required this.state});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return sellhistoryPlan_();
  }
}

class sellhistoryPlan_ extends State<sellhistoryPlan> {
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

    return G.api.game.getAiPlanList(
        {"page": page, "type": type, "state": widget.state}).then((value) {
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
                  (index) => onClick(
                          planPreview(
                            data: expert_list[index],
                            show_head: false,
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
                      })),
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
