import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class cashList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return couponList_();
  }
}

class couponList_ extends State<cashList> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  String no_tx = "0";
  String total_tx = "0";

  Future getData() {
    return G.api.user.getWidrawInfo({}).then((value) {
      setState(() {
        no_tx = value["no_tx"];
        total_tx = value["total_tx"];
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container();
  }

  void _onRefresh() async {
    getData().then((value) {
      refreshController.refreshCompleted();
      refreshController.loadComplete();
    });
  }
}
