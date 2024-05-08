import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../widget/PreferredSizeWidget.dart';
import '../../widget/colors.dart';

class RedCoinRecordsPage extends StatefulWidget {
  const RedCoinRecordsPage({Key? key}) : super(key: key);

  @override
  State<RedCoinRecordsPage> createState() => _RedCoinRecordsPageState();
}

class _RedCoinRecordsPageState extends State<RedCoinRecordsPage> {
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
    return G.api.user.getBillList({"page": page}).then((value) {
      setState(() {
        data.addAll(value);
      });
      return value;
    });
  }

  Widget getLeft(int index) {
    Container c = Container();
    c = Container(
      alignment: Alignment.center,
      height: rpx(40),
      width: rpx(40),
      decoration: BoxDecoration(
          color: hexToColor(data[index]["color"]),
          borderRadius: BorderRadius.circular(rpx(40))),
      child: TextWidget(
        data[index]["type"],
        fontSize: rpx(18),
        color: Colors.white,
      ),
    );
    return c;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: appbar('金豆记录'),
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
                                  Row(
                                    children: [
                                      getLeft(index),
                                      Container(
                                        width: rpx(10),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(data[index]["title"]),
                                          Container(
                                            height: rpx(5),
                                          ),
                                          TextWidget(data[index]["add_time"])
                                        ],
                                      )
                                    ],
                                  ),
                                  TextWidget(
                                    data[index]["money"].toString(),
                                    fontSize: rpx(18),
                                    fontWeight: FontWeight.bold,
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
