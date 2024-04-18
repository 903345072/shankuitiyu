import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class couponList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return couponList_();
  }
}

class couponList_ extends State<couponList> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  List data = [];

  Future getData() {
    return G.api.user.getUserYhq({"page": page}).then((value) {
      setState(() {
        data.addAll(value);
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return data.isNotEmpty
        ? Scaffold(
            body: SmartRefresher(
            controller: refreshController,
            enablePullDown: true,
            enablePullUp: false,
            footer: classFooter(),
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView(
              children: List.generate(
                  data.length,
                  (index) => Column(
                        children: List.generate(
                            1,
                            (index1) => Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(rpx(15)),
                                      child: Stack(
                                        children: [
                                          Container(
                                            color: Color(0xfffdf0da),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/bag.png",
                                                      width: rpx(60),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Container(
                                                      width: rpx(15),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        TextWidget(data[index]
                                                                [index1]["yhq"]
                                                            ["title"]),
                                                        Container(
                                                          height: rpx(5),
                                                        ),
                                                        TextWidget(
                                                          "满${data[index][index1]["yhq"]["least_price"].toString()}可用",
                                                          color: Colors.grey,
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                data[index][index1]["status"] ==
                                                        1
                                                    ? TextWidget(
                                                        "可用",
                                                        color: Colors.green,
                                                        fontSize: rpx(11),
                                                      )
                                                    : TextWidget(
                                                        "已过期/已使用",
                                                        color: Colors.grey,
                                                        fontSize: rpx(11),
                                                      ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: rpx(15)),
                                                  child: Row(
                                                    children: [
                                                      TextWidget(
                                                        data[index][index1]
                                                                ["yhq"]["price"]
                                                            .toString(),
                                                        color: Colors.red,
                                                        fontSize: rpx(18),
                                                      ),
                                                      TextWidget(
                                                        "元",
                                                        color: Colors.red,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Container(
                                                padding: EdgeInsets.all(rpx(3)),
                                                decoration: BoxDecoration(
                                                    color: Colors.red),
                                                child: TextWidget(
                                                  "x${data[index].length}",
                                                  color: Colors.white,
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: rpx(10)),
                                      child: Divider(
                                        color: Colors.grey.shade200,
                                      ),
                                    )
                                  ],
                                )),
                      )),
            ),
          ))
        : Container(
            margin: const EdgeInsets.only(top: 1),
            padding: const EdgeInsets.all(50),
            color: Colors.white,
            child: Image.asset('assets/images/nodata.png'),
          );
  }

  void _onLoading() async {
    // monitor network fetch
    setState(() {
      page++;
    });
    getData().then((value) {
      if (value.isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    });

    // if failed,use loadFailed(),if no data return,use LoadNodata()
  }

  void _onRefresh() async {
    setState(() {
      data = [];
    });
    getData().then((value) {
      refreshController.refreshCompleted();
      refreshController.loadComplete();
    });
  }
}
