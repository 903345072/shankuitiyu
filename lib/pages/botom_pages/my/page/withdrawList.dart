import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../widget/PreferredSizeWidget.dart';
import '../../widget/colors.dart';

class withdrawList extends StatefulWidget {
  const withdrawList({Key? key}) : super(key: key);

  @override
  State<withdrawList> createState() => _RedCoinRecordsPageState();
}

class _RedCoinRecordsPageState extends State<withdrawList> {
  int page = 1;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGameList();
  }

  Future getGameList() {
    return G.api.user.getWithdrawList({"page": page}).then((value) {
      setState(() {
        data.addAll(value);
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: appbar('提现记录'),
      body: data.isNotEmpty
          ? SmartRefresher(
              controller: refreshController,
              enablePullDown: true,
              enablePullUp: true,
              header: classHeader(),
              footer: classFooter(),
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView(
                children: List.generate(
                    data.length,
                    (index) => Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(rpx(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(data[index]["add_time"]),
                                      Container(
                                        height: rpx(7),
                                      ),
                                      TextWidget(data[index]["type"]),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(data[index]["money"]),
                                      Container(
                                        height: rpx(7),
                                      ),
                                      data[index]["refuse_txt"] != null
                                          ? Container(
                                              width: rpx(120),
                                              child: Text(
                                                "拒绝理由：${data[index]["refuse_txt"]}",
                                                softWrap: true,
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: rpx(13)),
                                              ),
                                            )
                                          : Container(
                                              child: TextWidget(
                                                data[index]["state"],
                                                color: Colors.grey,
                                              ),
                                            ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: rpx(10)),
                              child: Divider(
                                color: Colors.grey.shade200,
                              ),
                            )
                          ],
                        )),
              ))
          : Container(
              color: MyColors.white,
              padding: const EdgeInsets.fromLTRB(30, 90, 30, 200),
              child: Image.asset('assets/images/message_empty.png'),
            ),
    );
  }

  void _onLoading() async {
    // monitor network fetch
    setState(() {
      page++;
    });
    getGameList().then((value) {
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
      page = 1;
      data = [];
    });
    getGameList().then((value) {
      refreshController.refreshCompleted();
      refreshController.loadComplete();
    });
  }
}
