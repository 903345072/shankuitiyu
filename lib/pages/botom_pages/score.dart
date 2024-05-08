import 'package:date_format/date_format.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/model/basketScreenModel.dart';
import 'package:jingcai_app/model/footScreenModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/pages/score_pages/basket.dart';
import 'package:jingcai_app/pages/score_pages/foot.dart';
import 'package:jingcai_app/pages/score_pages/socreFoot/course.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';

class score extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _score();
  }
}

class _score extends State<score> with TickerProviderStateMixin {
  List tabs = ["足球", "篮球"];
  late TabController _tabC;
  int _cur_index = 0;
  String date_ = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
  PageController _pageController = PageController(initialPage: 0);
  List foot_type = ["全部", "热门", "竞足", "北单"];
  List basket_type = ["全部", "热门", "竞篮"];
  List game_type = [];
  int game_index = 0;
  bool show_tab = true;
  @override
  void initState() {
    super.initState();
    _tabC = TabController(
      length: tabs.length,
      initialIndex: 0,
      vsync: this,
    );
    game_type = foot_type;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,

      end: Offset(-1.3, 0.0), // 向左偏移一个屏幕宽度
    ).animate(_controller!);
  }

  GlobalKey<footing> footkey = GlobalKey<footing>();
  GlobalKey<basketing> basketkey = GlobalKey<basketing>();
  AnimationController? _controller;

  Animation<Offset>? _offsetAnimation;
  void _togglePopup() {
    if (_controller!.isDismissed) {
      _controller!.forward();
    } else {
      _controller!.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          appBar: AppBar(
            actions: [
              show_tab
                  ? Container(
                      margin: EdgeInsets.only(right: rpx(20)),
                      child: GestureDetector(
                        onTap: () {
                          Map<String, dynamic> p = {"date": date_};
                          if (_cur_index == 0) {
                            G.router
                                .navigateTo(context,
                                    '/footScreen' + G.parseQuery(params: p),
                                    transition: TransitionType.inFromRight)
                                .then((value) {
                              if (value != null) {
                                setState(() {
                                  if (value["index"] == 0) {
                                    value["index"] = 1;
                                  }
                                  if (value["index"] == 1) {
                                    value["index"] = 0;
                                  }
                                  game_index = value["index"];
                                });
                              }

                              footkey.currentState?.refreshData(value: value);
                            });
                          } else {
                            G.router
                                .navigateTo(context,
                                    '/basketScreen' + G.parseQuery(params: p),
                                    transition: TransitionType.inFromRight)
                                .then((value) {
                              if (value != null) {
                                setState(() {
                                  if (value["index"] == 0) {
                                    value["index"] = 1;
                                  }
                                  if (value["index"] == 1) {
                                    value["index"] = 0;
                                  }
                                  game_index = value["index"];
                                });
                              }
                              basketkey.currentState?.refreshData(value: value);
                            });
                          }
                        },
                        child: Center(
                          child: Image.asset(
                            "assets/images/choose.png",
                            width: rpx(20),
                            height: rpx(20),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
            centerTitle: true,
            leading: GestureDetector(
              child: onClick(
                  Center(
                    child: Image.asset(
                      "assets/images/red_search.png",
                      width: rpx(20),
                      height: rpx(20),
                      fit: BoxFit.fill,
                    ),
                  ), () {
                G.router.navigateTo(context,
                    "/gameSearch" + G.parseQuery(params: {"type": _cur_index}));
              }),
            ),
            title: Container(
              alignment: Alignment.center,
              width: 300,
              height: 100,
              color: Colors.white,
              child: _tabars(),
            ),
          ),
          body: Stack(
            children: [
              Column(
                children: [_tarbarview()],
              ),
              Positioned(
                right: -game_type.length * rpx(60),
                bottom: 20,
                width: game_type.length * rpx(60),
                child: SlideTransition(
                  position: _offsetAnimation!,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2), // 阴影颜色

                            spreadRadius: 2, // 阴影的大小

                            blurRadius: 2, // 阴影的模糊度

                            offset: Offset(1, 1), // 阴影的偏移量 (水平，垂直)
                          ),
                        ],
                        borderRadius: BorderRadius.circular(rpx(40))),
                    height: rpx(40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          game_type.length,
                          (index) => onClick(getCont(index), () {
                                setState(() {
                                  game_index = index;
                                });
                                if (_cur_index == 0) {
                                  footkey.currentState?.refreshData(
                                      value: {"index": game_index});
                                } else {
                                  basketkey.currentState?.refreshData(
                                      value: {"index": game_index});
                                }
                                _togglePopup();
                              })),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        show_tab
            ? Positioned(
                bottom: 15,
                right: 0,
                child: onClick(
                    Container(
                      height: rpx(35),
                      width: rpx(50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(rpx(35)),
                              bottomLeft: Radius.circular(rpx(35))),
                          color: Colors.red),
                      alignment: Alignment.center,
                      child: TextWidget(
                        game_type[game_index],
                        color: Colors.white,
                      ),
                    ),
                    () => _togglePopup()))
            : Container()
      ],
    );
  }

  Widget getCont(int index) {
    Container c = Container();
    if (index == game_index) {
      c = Container(
        height: rpx(40),
        width: rpx(60),
        padding: EdgeInsets.symmetric(horizontal: rpx(15)),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(rpx(40))),
        child: TextWidget(
          game_type[index],
          color: Colors.white,
        ),
      );
    } else {
      c = Container(
        width: rpx(60),
        height: rpx(40),
        alignment: Alignment.center,
        child: TextWidget(game_type[index]),
      );
    }
    return c;
  }

  _tabars() {
    Map select_style = {"color": Colors.white, "backGroundColor": Colors.red};
    Map unselect_style = {
      "color": Color(0xff9f9f9f),
      "backGroundColor": Color(0xfff0f0f0)
    };
    return Container(
      child: Wrap(
        children: List.generate(
            tabs.length,
            (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _cur_index = index;
                      game_index = 0;
                      if (_cur_index == 0) {
                        game_type = foot_type;
                      } else {
                        game_type = basket_type;
                      }
                      _pageController.jumpToPage(index);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: _cur_index == index
                            ? select_style["backGroundColor"]
                            : unselect_style["backGroundColor"],
                        borderRadius: index == 0
                            ? BorderRadius.only(
                                topLeft: Radius.circular(3),
                                bottomLeft: Radius.circular(3))
                            : BorderRadius.only(
                                topRight: Radius.circular(3),
                                bottomRight: Radius.circular(3))),
                    padding:
                        EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 3),
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                          color: _cur_index == index
                              ? select_style["color"]
                              : unselect_style["color"],
                          fontSize: rpx(15)),
                    ),
                  ),
                )),
      ),
    );
  }

  _tarbarview() {
    return Expanded(
      child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            //因为有两个tabar所以写死了两个Container
            //在实际开发中我们通过接口获取tabar和children的数量 用list存储
            foot(
              setDate: (e) {
                setState(() {
                  this.date_ = e;
                });
              },
              key: footkey,
              close_tab: (value) {
                setState(() {
                  show_tab = value;
                  // game_index = 0;
                });
              },
            ),
            basket(
              setDate: (e) {
                setState(() {
                  this.date_ = e;
                });
              },
              key: basketkey,
              close_tab: (value) {
                setState(() {
                  show_tab = value;
                  // game_index = 0;
                });
              },
            ),
          ]),
    );
  }
}
