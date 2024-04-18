import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/model/footScreenModel.dart';
import 'package:jingcai_app/pages/score_pages/socreFoot/allFoot.dart';
import 'package:jingcai_app/pages/score_pages/socreFoot/hotFoot.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/loading.dart';
import 'package:jingcai_app/util/rpx.dart';

import 'package:provider/provider.dart';

class footScreen extends StatefulWidget {
  String date_;
  footScreen({required this.date_});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _footScreen();
  }
}

class _footScreen extends State<footScreen> with TickerProviderStateMixin {
  late TabController _tabC;
  List<GetBd> hot_list = [];
  List<AllMatch> all_list = [];
  List<GetBd> guess_list = [];
  List<GetBd> bd_list = [];
  int count = 0;
  int all_check = 0;

  var tabs = ["热门", "全部", "竞足", "北单"];
  @override
  void initState() {
    super.initState();

    _tabC = TabController(
      length: tabs.length,
      initialIndex: 0,
      vsync: this,
    );

    _loadArticle();
    _tabC.addListener(() {
      setCount();
    });
  }

  Future _loadArticle() async {
    G.api.gameAdd.getFootLeagues({}).then((value) {
      var d = FootScreenModel.fromJson(value);
      final data = d.data;
      if (data != null) {
        setState(() {
          hot_list = data.hotMatch!;
          all_list = data.allMatch!;
          guess_list = data.getGuess!;
          bd_list = data.getBd!;
        });

        setCount();
      }
    });
  }

  setAllcheck() {
    if (_tabC.index == 0) {
      hot_list.forEach((element) {
        element.checked = all_check == 1 ? 0 : 1;
      });
    }

    if (_tabC.index == 1) {
      all_list.forEach((element) {
        List<GetBd>? s = element.list;
        s?.forEach((element1) {
          element1.checked = all_check == 1 ? 0 : 1;
        });
      });
    }
    if (_tabC.index == 2) {
      guess_list.forEach((element) {
        element.checked = all_check == 1 ? 0 : 1;
      });
    }
    if (_tabC.index == 3) {
      bd_list.forEach((element) {
        element.checked = all_check == 1 ? 0 : 1;
      });
    }
    setState(() {
      all_check = all_check == 1 ? 0 : 1;
    });
    setCount();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Checkbox(
                value: all_check == 1,
                onChanged: (e) {
                  setAllcheck();
                },
              ),
            ],
          )
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "筛选",
          style: TextStyle(fontSize: rpx(18)),
        ),
        leadingWidth: rpx(30),
        leading: GestureDetector(
          onTap: () {
            G.router.pop(context);
          },
          child: Center(
            child: Image.asset(
              "assets/images/back.png",
              width: rpx(10),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              _tabars(),
              _tarbarview(),
            ],
          ),
          Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.all(rpx(10)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 184, 183, 183),
                      offset: Offset(
                        1,
                        1,
                      ),
                      blurRadius: 1,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment(0, 0),
                height: rpx(80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 3,
                      children: [
                        Text("已选择"),
                        Text(
                          count.toString(),
                          style:
                              TextStyle(color: Colors.red, fontSize: rpx(20)),
                        ),
                        Text("个联赛")
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        List arr = [];
                        if (_tabC.index == 0) {
                          hot_list.forEach((element) {
                            if (element.checked == 1) {
                              arr.add(element.competitionId);
                            }
                          });
                        }
                        if (_tabC.index == 1) {
                          all_list.forEach((element) {
                            var s = element.list;
                            s?.forEach((element1) {
                              if (element1.checked == 1) {
                                arr.add(element1.competitionId);
                              }
                            });
                          });
                        }
                        if (_tabC.index == 2) {
                          guess_list.forEach((element) {
                            if (element.checked == 1) {
                              arr.add(element.competitionId);
                            }
                          });
                        }
                        if (_tabC.index == 3) {
                          bd_list.forEach((element) {
                            if (element.checked == 1) {
                              arr.add(element.competitionId);
                            }
                          });
                        }
                        if (count == 0) {
                          Loading.tip("uri", "请选择一个联赛");
                          return;
                        }
                        G.router
                            .pop(context, {"id": arr, "index": _tabC.index});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: rpx(40), right: rpx(40)),
                        height: rpx(40),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(rpx(20)))),
                        child: const Text(
                          "确定",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  setCount() {
    if (_tabC.index == 0) {
      var int_ = 0;
      for (var i = 0; i <= hot_list.length - 1; i++) {
        if (hot_list[i].checked == 1) {
          int_++;
        }
      }
      setState(() {
        count = int_;
        all_check = count == hot_list.length ? 1 : 0;
      });
    }

    if (_tabC.index == 2) {
      var int_ = 0;
      for (var i = 0; i <= guess_list.length - 1; i++) {
        if (guess_list[i].checked == 1) {
          int_++;
        }
      }
      setState(() {
        count = int_;
        all_check = count == guess_list.length ? 1 : 0;
      });
    }

    if (_tabC.index == 3) {
      var int_ = 0;
      for (var i = 0; i <= bd_list.length - 1; i++) {
        if (bd_list[i].checked == 1) {
          int_++;
        }
      }
      setState(() {
        count = int_;
        all_check = count == bd_list.length ? 1 : 0;
      });
    }

    if (_tabC.index == 1) {
      var int_ = 0;
      var part_count = 0;
      for (var i = 0; i <= all_list.length - 1; i++) {
        var lis = all_list[i].list;
        part_count += all_list[i].list!.length;
        for (var j = 0; j <= lis!.length - 1; j++) {
          if (lis[j].checked == 1) {
            int_++;
          }
        }
      }
      setState(() {
        count = int_;
        all_check = count == part_count ? 1 : 0;
      });
    }
  }

  _tarbarview() {
    return Expanded(
      child: TabBarView(controller: _tabC, children: [
        //因为有两个tabar所以写死了两个Container
        //在实际开发中我们通过接口获取tabar和children的数量 用list存储
        hot_list.length > 0
            ? hotFoot(
                hot_list: hot_list,
                setCount: (e) {
                  setState(() {
                    hot_list = e;
                  });
                  setCount();
                },
              )
            : Container(),
        all_list.length > 0
            ? allFoot(
                all_list: all_list,
                setCount: (e) {
                  setState(() {
                    all_list = e;
                  });
                  setCount();
                },
              )
            : Container(),
        guess_list.length > 0
            ? hotFoot(
                hot_list: guess_list,
                setCount: (e) {
                  setState(() {
                    guess_list = e;
                  });
                  setCount();
                },
              )
            : Container(),
        bd_list.length > 0
            ? hotFoot(
                hot_list: bd_list,
                setCount: (e) {
                  setState(() {
                    bd_list = e;
                  });
                  setCount();
                },
              )
            : Container(),
      ]),
    );
  }

  _tabars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TabBar(
          physics: NeverScrollableScrollPhysics(),
          tabAlignment: TabAlignment.center,
          padding: EdgeInsets.all(0),

          labelPadding: EdgeInsets.all(0),

          labelColor: Colors.red,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.red,
          indicatorPadding: EdgeInsets.only(left: rpx(20), right: rpx(20)),

          // 选择的样式
          labelStyle: TextStyle(
            fontSize: rpx(13),
            fontWeight: FontWeight.bold,
          ),
          // 未选中的样式
          unselectedLabelStyle: TextStyle(
            fontSize: rpx(13),
          ),
          indicatorWeight: 1.0,

          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,

          controller: _tabC,
          tabs: tabs
              .map(
                (label) => Container(
                  padding: EdgeInsets.only(bottom: 10),
                  alignment: Alignment.center,
                  width: rpx(93.75),
                  child: Text(label),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
