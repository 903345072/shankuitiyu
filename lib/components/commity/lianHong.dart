import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/model/talentExpert.dart';
import 'package:jingcai_app/model/winRateListModel.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class lianHong extends StatefulWidget {
  List<winRateModel> mzList;
  lianHong({required this.mzList});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return lianHong_();
  }
}

class lianHong_ extends State<lianHong> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
  }

  getSingleRank(int index, winRateModel data) {
    var url = "assets/images/second.png";
    if (index == 1) {
      url = "assets/images/top.png";
    }
    if (index == 0) {
      url = "assets/images/second.png";
    }
    if (index == 2) {
      url = "assets/images/third.png";
    }
    return Container(
      child: Stack(
        children: [
          Image.asset(
            url,
            fit: BoxFit.cover,
            width: rpx(110),
          ),
          Positioned(
              left: rpx(2),
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
                              data.userImg.toString(),
                            ),
                          ),
                        ),
                        Positioned(
                            right: rpx(0),
                            child: Container(
                              height: 16,
                              alignment: Alignment(0, 0),
                              padding:
                                  EdgeInsets.only(left: rpx(4), right: rpx(4)),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Text(
                                data.onSaleCount.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: rpx(10)),
                              ),
                            )),
                      ],
                    ),
                    Text(data.userName.toString()),
                    Container(
                      child: Text(
                        "历史最高:  " + data.historyHong.toString() + "连红",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      child: Text(
                        data.hong.toString() + "连红",
                        style: TextStyle(color: Colors.red, fontSize: rpx(14)),
                      ),
                    ),
                    data.isSubscribe == "已关注"
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
                ),
              ))
        ],
      ),
    );
  }

  getTop3() {
    List<winRateModel> list =
        widget.mzList.length > 3 ? widget.mzList.sublist(0, 3) : widget.mzList;
    if (list.length >= 1) {
      winRateModel w0 = list[0];
      winRateModel w1 = list[1];
      list[1] = w0;
      list[0] = w1;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
          list.length, (index) => getSingleRank(index, list[index])),
    );
  }

  getTail() {
    List<winRateModel> list = widget.mzList;
    if (widget.mzList.length <= 3) {
      return Container();
    } else {
      list = widget.mzList.sublist(3, widget.mzList.length);
    }

    return Column(
      children: List.generate(
          list.length,
          (index) => Container(
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
                            (index + 3).toString(),
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
                                  list[index].userImg.toString(),
                                ),
                              ),
                            ),
                            list[index].onSaleCount! > 0
                                ? Positioned(
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Text(
                                        list[index].onSaleCount.toString(),
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
                            Text(list[index].userName.toString()),
                            Container(
                              child: Text(
                                "历史最高:  " +
                                    list[index].historyHong.toString() +
                                    "连红",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        list[index].hong.toString() + "连红",
                        style: TextStyle(color: Colors.red, fontSize: rpx(14)),
                      ),
                    ),
                    list[index].isSubscribe == "已关注"
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
                ),
              )),
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
