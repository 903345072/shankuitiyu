import 'dart:convert';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:jingcai_app/components/commity/jcExpert.dart';
import 'package:jingcai_app/components/commity/talent.dart';
import 'package:jingcai_app/components/homes/dry_news.dart';
import 'package:jingcai_app/components/homes/hot_expert.dart';
import 'package:jingcai_app/components/homes/hot_game.dart';
import 'package:jingcai_app/components/homes/recommend.dart';
import 'package:jingcai_app/components/homes/sys_news.dart';
import 'package:jingcai_app/model/HotGameModel.dart';
import 'package:jingcai_app/model/expert.dart';
import 'package:jingcai_app/model/recommendModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/routes.dart';
import 'package:jingcai_app/pages/login/login.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';

class community extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _community();
  }
}

class _community extends State<community>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabC;
  var tabs = ["福神专家", "红榜达人", "视频推荐"];
  late ScrollController _scrollController;
  late AnimationController controller;
  var headLogo = "assets/images/headLogo.png";
  double op = 1;
  double scrolly = 0;
  Color default_c = Colors.transparent;
  bool show_state = true;
  // Animation<double> animation;
  List<expert> expert_data = [];
  List<List<HotGameModel>> hot_data = [];
  List<recommendModel> recmmend_data = [];

  @override
  void initState() {
    super.initState();

    var headLogo_ = "assets/images/headLogo.png";
    controller = AnimationController(vsync: this);
    Color c = Colors.transparent;

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double alpha = 1 - (offset / rpx(120));
      bool show_state_ = true;

      if (alpha < 0.5) {
        alpha = 0;
        headLogo_ = "assets/images/headLogo_red.png";
        c = Colors.white;
        show_state_ = false;
      } else if (alpha >= 1) {
        alpha = 1;
      }
      if (alpha > 0.9) {
        headLogo_ = "assets/images/headLogo.png";
        c = Colors.transparent;
        show_state_ = true;
      }
      setState(() {
        op = alpha;
        headLogo = headLogo_;
        default_c = c;
        show_state = show_state_;
      });
      //animation = Tween(begin: 0.0, end: 1) as Animation<double>;
    });

    //animation = Tween(begin: 0.0, end: 1) as Animation<double>;
  }

  void _tabController() {
    _tabC = TabController(
      length: tabs.length,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _contentView(context, "123"),
    );
  }

  getTextInputWidget() {
    if (show_state) {
      return Image.asset(
        "assets/images/search.png",
        width: rpx(30),
        fit: BoxFit.cover,
      );
    } else {
      return SizedBox(
        height: 30,
        width: rpx(200),
        child: const TextField(
          enabled: false,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              fillColor: Color(0x30cccccc),
              filled: true,
              prefixIcon: Icon(
                Icons.search,
                size: 19,
              ),
              prefixIconColor: Colors.grey,
              hintStyle: TextStyle(fontSize: 12),
              hintText: "搜索方案、专家、达人",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)))),
        ),
      );
    }
  }

  _contentView(context, title) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    double pinnedHeaderHeight = rpx(55) + rpx(statusBarHeight);
    return ExtendedNestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          //标题

          SliverAppBar(
            title: SizedBox(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Image.asset(
                //   headLogo,
                //   width: rpx(100),
                //   fit: BoxFit.cover,
                // ),
                Container(
                  width: 1,
                ),
                onClick(getTextInputWidget(), () {
                  G.router.navigateTo(context, "/talentSearch");
                }),
              ],
            )),
            expandedHeight: rpx(175),
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Swiper(
                  autoplay: true,
                  duration: 5,
                  pagination: const SwiperPagination(
                    margin: EdgeInsets.only(bottom: 5),
                    builder: DotSwiperPaginationBuilder(
                      ///          设置指示器颜色
                      color: Colors.grey,
                      activeColor: Colors.red,
                    ),
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    var index_ = index + 1;
                    return onClick(
                        Image.asset(
                          "assets/images/sq_banner_$index_.jpg",
                          fit: BoxFit.cover,
                        ), () {
                      if (index == 1) {
                        G.api.user.getUserIfno({}).then((value) {
                          if (value.uid! > 0) {
                            G.router.navigateTo(context, "/applyTalent",
                                routeSettings: RouteSettings(arguments: Map()));
                          } else {
                            Routes.pushPage(login());
                          }
                        });
                      }
                      if (index == 2) {
                        G.router.navigateTo(context,
                            "/talentRank" + G.parseQuery(params: {"index": 0}));
                      }
                    });
                  },
                  itemCount: 3),
            ),
            pinned: true,
            floating: true,
          ),
        ];
      },
      pinnedHeaderSliverHeightBuilder: () {
        return pinnedHeaderHeight;
      },
      onlyOneScrollInBody: true,
      body: talent(),
    );
  }

  _tabars() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        TabBar(
          physics: NeverScrollableScrollPhysics(),
          tabAlignment: TabAlignment.start,
          padding: EdgeInsets.all(0),

          labelPadding: EdgeInsets.all(0),
          indicatorPadding: EdgeInsets.only(left: rpx(30), right: rpx(30)),
          labelColor: Colors.red,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.red,

          // 选择的样式
          labelStyle: TextStyle(
            fontSize: rpx(13),
            fontWeight: FontWeight.bold,
          ),
          // 未选中的样式
          unselectedLabelStyle: TextStyle(
            fontSize: rpx(13),
          ),
          indicatorWeight: 3.0,
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,

          controller: _tabC,
          tabs: tabs
              .map(
                (label) => Container(
                  width: MediaQuery.of(context).size.width * 0.33,
                  child: Tab(text: "$label"),
                ),
              )
              .toList(),
        )
      ],
    );
  }

  _tarbarview() {
    return talent();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
