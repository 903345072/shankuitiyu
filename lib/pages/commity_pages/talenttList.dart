import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/model/talentExpert.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class talentList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return talentList_();
  }
}

class talentList_ extends State<talentList> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List<expertTalentDatum> data = [];
  @override
  void initState() {
    super.initState();
    String url =
        "https://pay.jcyqr.com/talent_expert?cid=15&sv=4.51&dev=3&token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOlsiMTAuMTAuNTkuMTM3Ojk4MDkiXSwiYXVkIjpbIjEwLjEwLjU5LjEzNzo5ODA5Il0sImlhdCI6MTY5OTkzNTQ3MiwibmJmIjoxNjk5OTM1NDcyLCJleHAiOjE3MDI1Mjc0NzIsImp0aSI6eyJpZCI6NDg5NzQ3LCJ0eXBlIjoiSldUIn19._2ZutdiMA-E2h3xQHKbeFr23rnp0lbGJqRb0GEy3fcQ&client_sign=634582905056454119424_f800d30980b7dd5bd6f32ded548d5e27&sign=A0061FB1CE89FEE07B03E07D5F727189&timestamp=1701510483940&tea_utm_cache=undefined&type=2&page_size=10&page=1";
    final dio = Dio();
    dio.get(url).then((value) {
      var d = TalentExpertModel.fromJson(value.data);

      setState(() {
        data = d.data!;
      });
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
        children: List.generate(
            data.length,
            (index) => Container(
                  padding: EdgeInsets.all(rpx(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: rpx(3)),
                            child: CircleAvatar(
                              radius: rpx(20),
                              backgroundImage: NetworkImage(
                                data[index].userImg.toString(),
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
                                child: Text(
                                  data[index].onSaleCount.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: rpx(10)),
                                ),
                              )),
                        ],
                      ),
                      Wrap(
                        spacing: rpx(4),
                        direction: Axis.vertical,
                        children: [
                          Text(data[index].userName.toString()),
                          Container(
                            padding:
                                EdgeInsets.only(left: rpx(5), right: rpx(5)),
                            alignment: Alignment.center,
                            color: Color(0xffffece8),
                            child: Text(
                              data[index].zhong.toString(),
                              style: TextStyle(color: Color(0xffef2f2f)),
                            ),
                          ),
                          Container(
                            width: rpx(230),
                            child: Text(
                              data[index].desc.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                      Wrap(
                        direction: Axis.vertical,
                        spacing: 5,
                        children: [
                          Wrap(
                            spacing: 3,
                            children: [
                              Text("粉丝数"),
                              Text(data[index].fensi.toString())
                            ],
                          ),
                          data[index].isSubscribe == "已关注"
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
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(15)),
                                  alignment: Alignment.center,
                                  width: rpx(70),
                                  height: rpx(30),
                                  child: Text(
                                    "+关注",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                        ],
                      )
                    ],
                  ),
                )),
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
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 3000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    refreshController.loadNoData();
  }
}
