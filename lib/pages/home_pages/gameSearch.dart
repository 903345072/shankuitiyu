import 'package:flutter/material.dart';
import 'package:jingcai_app/components/scores/basketGame.dart';
import 'package:jingcai_app/components/scores/footGame.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/InputWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/loading.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class gameSearch extends StatefulWidget {
  int type;
  gameSearch({required this.type});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return gameSearch_();
  }
}

class gameSearch_ extends State<gameSearch> {
  TextEditingController controller = TextEditingController();
  String text = "";
  List<JcFootModel> foot = [];
  List<JcFootModel> basket = [];
  List search = [];
  List hot_league = [];
  int page = 1;
  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      text = controller.value.text;
      if (text.isEmpty) {
        setState(() {
          foot = [];
          basket = [];
        });
      }
    });
    getGameSearch();
    getHotLeague();
  }

  getHotLeague() {
    G.api.gameAdd.getHotLeagues({}).then((value) {
      setState(() {
        hot_league = value;
      });
    });
  }

  getGameSearch() {
    G.api.gameAdd.getGameSearchRecord({}).then((value) {
      setState(() {
        search = value;
      });
    });
  }

  Future searchFootGame() {
    return G.api.gameAdd.searchFootGame(
        {"type": "foot", "page": page, "text": text}).then((value) {
      setState(() {
        foot.addAll(value);
      });
      if (value.isEmpty) {
        Loading.tip("searchgame", "无数据");
      }
      return value;
    });
  }

  Future searchBasketGame() {
    return G.api.gameAdd.searchBasketGame(
        {"type": "foot", "page": page, "text": text}).then((value) {
      setState(() {
        basket.addAll(value);
      });
      if (value.isEmpty) {
        Loading.tip("searchgame", "无数据");
      }
      return value;
    });
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void _onLoading() async {
    if (foot.isNotEmpty || basket.isNotEmpty) {
      setState(() {
        page++;
      });
      widget.type == 0
          ? searchFootGame().then((value) {
              if (value.isEmpty) {
                refreshController.loadNoData();
              } else {
                refreshController.loadComplete();
              }
            })
          : searchBasketGame().then((value) {
              if (value.isEmpty) {
                refreshController.loadNoData();
              } else {
                refreshController.loadComplete();
              }
            });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SmartRefresher(
      enablePullDown: false,
      enablePullUp: true,
      controller: refreshController,
      onLoading: _onLoading,
      footer: classFooter(),
      child: ListView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        children: [
          Container(
            padding: EdgeInsets.all(rpx(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                onClick(Icon(Icons.arrow_back_ios), () {
                  G.router.pop(context);
                }),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: rpx(10)),
                  width: rpx(250),
                  height: rpx(30),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(rpx(3))),
                  child: InputWidget(
                    textInputType: TextInputType.multiline,
                    controller: controller,
                    hintText: "搜索球队、赛事",
                    hintStyle: TextStyle(
                        fontSize: rpx(13), color: Colors.grey.shade400),
                    icon: Image.asset(
                      "assets/images/search_grey.png",
                      width: rpx(20),
                      height: rpx(20),
                      color: Colors.grey,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                onClick(
                    TextWidget(
                      "搜索",
                      color: Colors.red,
                      fontSize: rpx(15),
                    ), () {
                  setState(() {
                    basket = [];
                    foot = [];
                    page = 1;
                  });
                  if (text.isNotEmpty) {
                    widget.type == 0 ? searchFootGame() : searchBasketGame();
                  }
                })
              ],
            ),
          ),
          search.isNotEmpty && (foot.isEmpty && basket.isEmpty)
              ? Container(
                  padding: EdgeInsets.all(rpx(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        "最近搜索",
                        fontWeight: FontWeight.bold,
                        fontSize: rpx(15),
                      ),
                      SizedBox(
                        height: rpx(10),
                      ),
                      Wrap(
                        runSpacing: rpx(10),
                        spacing: rpx(10),
                        direction: Axis.horizontal,
                        children: List.generate(
                            search.length,
                            (index) => onClick(
                                    Container(
                                      height: rpx(25),
                                      padding: EdgeInsets.only(
                                          left: rpx(10),
                                          right: rpx(10),
                                          top: rpx(3)),
                                      color: Colors.grey.shade200,
                                      child: TextWidget(
                                        search[index]["content"],
                                        color: Colors.grey.shade500,
                                        textAlign: TextAlign.center,
                                      ),
                                    ), () {
                                  setState(() {
                                    text = search[index]["content"];
                                    controller.text = text;
                                    basket = [];
                                    foot = [];
                                    page = 1;
                                    widget.type == 0
                                        ? searchFootGame()
                                        : searchBasketGame();
                                  });
                                })),
                      )
                    ],
                  ),
                )
              : Container(),
          hot_league.isNotEmpty && (foot.isEmpty && basket.isEmpty)
              ? Container(
                  padding: EdgeInsets.all(rpx(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        "重要赛事",
                        fontWeight: FontWeight.bold,
                        fontSize: rpx(15),
                      ),
                      SizedBox(
                        height: rpx(10),
                      ),
                      Wrap(
                        runSpacing: rpx(10),
                        spacing: rpx(10),
                        direction: Axis.horizontal,
                        children: List.generate(
                            hot_league.length >= 13 ? 13 : hot_league.length,
                            (index) => onClick(
                                    Stack(
                                      children: [
                                        Container(
                                          height: rpx(65),
                                          width: rpx(100),
                                          alignment: Alignment.center,
                                          color: Colors.grey.shade200,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: rpx(10),
                                              ),
                                              TextWidget(
                                                hot_league[index]["league"]
                                                    ["name_short"],
                                                textAlign: TextAlign.center,
                                              ),
                                              Container(
                                                height: rpx(5),
                                              ),
                                              TextWidget(
                                                  "近期${hot_league[index]["child_count"]}场赛事")
                                            ],
                                          ),
                                        ),
                                        hot_league[index]["plan_num"] > 0
                                            ? Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: rpx(3),
                                                      vertical: rpx(2)),
                                                  color: Colors.red.shade100,
                                                  child: TextWidget(
                                                    hot_league[index]
                                                                ["plan_num"]
                                                            .toString() +
                                                        "方案",
                                                    color: Colors.red,
                                                    fontSize: rpx(11),
                                                  ),
                                                ))
                                            : Container(
                                                child: TextWidget(""),
                                              )
                                      ],
                                    ), () {
                                  G.router.navigateTo(
                                      context,
                                      "/hotMatch" +
                                          G.parseQuery(params: {
                                            "id": hot_league[index]["league"]
                                                ["id"],
                                            "type": widget.type,
                                            "name": hot_league[index]["league"]
                                                ["name_short"],
                                          }));
                                })),
                      )
                    ],
                  ),
                )
              : Container(),
          foot.isNotEmpty
              ? Column(
                  children: List.generate(
                      foot.length,
                      (index) => footGame(
                            footListElement: foot[index],
                          )),
                )
              : Container(),
          basket.isNotEmpty
              ? Column(
                  children: List.generate(
                      basket.length,
                      (index) => basketGame(
                            basketListElement: basket[index],
                          )),
                )
              : Container(),
        ],
      ),
    ));
  }
}
