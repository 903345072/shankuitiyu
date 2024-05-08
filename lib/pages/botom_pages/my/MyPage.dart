import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jingcai_app/model/PlanModel.dart';
import 'package:jingcai_app/model/userModel.dart';
import 'package:jingcai_app/pages/botom_pages/my/page/myPlan.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/loading.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../login/userEvent.dart';
import 'page/AboutUsPage.dart';
import 'page/AccountSettingsPage/AccountSettingsPage.dart';
import 'page/ApplicationInfluencerPage.dart';
import 'page/Coupon.dart';
import 'page/EventsPlazaPage.dart';
import 'page/FeedbackPage.dart';
import 'page/HelpPage.dart';
import 'page/Interest.dart';
import 'page/InviteFriendsPage.dart';
import 'page/ManualCustomerServicePage.dart';
import 'page/Message.dart';
import 'page/MyCollectionPage.dart';
import 'page/PurchaseRecordPage.dart';
import 'page/RechargePage.dart';
import 'page/RedCoinRecordsPage.dart';
import 'page/SystemSettings.dart';
import '../widget/PreferredSizeWidget.dart'; //PreferredSizeWidget
import '../widget/routes.dart';
import '../widget/textWidget.dart';
import 'package:event_bus/event_bus.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<Map> myMenus = [];
  userModel user = userModel
      .fromJson({"uid": 0, "flow": 0, "type": 0, "notice": 0, "yhq": 0});
  bool is_login = false;
  StreamSubscription? loginSubscription;
  @override
  void initState() {
    super.initState();

    getUser();

    loginSubscription = eventBus.on<userEvent>().listen((event) {
      setState(() {
        is_login = event.is_login;
      });
      if (is_login == true) {
        getUser();
      } else {
        setLogOut();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    loginSubscription!.cancel();
  }

  setLogOut() async {
    setState(() {
      user.money = 0.0;
      user.flow = 0;
      user.notice = 0;
      myMenus = [
        // {
        //   'name': '我的收藏',
        //   'icon': Icons.star_border,
        //   'widget': const MyCollectionPage(),
        //   'img': ''
        // },
        // {
        //   'name': '系统设置',
        //   'icon': Icons.settings,
        //   'widget': const SystemSettings(),
        //   'img': 'assets/images/system_setting.png'
        // },
        {
          'name': '人工客服',
          'icon': Icons.local_phone,
          'widget': const ManualCustomerServicePage(),
          'img': 'assets/images/real_serve.png'
        },
        {
          'name': '帮助中心',
          'icon': Icons.settings,
          'widget': const HelpPage(),
          'img': 'assets/images/help_center.png'
        },
        {
          'name': '关于我们',
          'icon': Icons.error_outline,
          'widget': const AboutUsPage(),
          'img': 'assets/images/about_us.png'
        },
        {
          'name': '意见反馈',
          'icon': Icons.face_outlined,
          'img': 'assets/images/feed_back.png',
          'widget': const FeedbackPage()
        },
      ];
    });
  }

  getUser() async {
    G.api.user.getUserIfno({}).then((value) async {
      setState(() {
        user = value;
      });

      if (value.uid! > 0) {
        setState(() {
          is_login = true;
          myMenus = [
            {
              'name': '邀请好友',
              'icon': Icons.accessibility,
              'widget': const InviteFriendsPage(),
              'img': "assets/images/invite_user.png"
            },
            {
              'name': '账户设置',
              'icon': Icons.account_balance,
              'widget': AccountSettingsPage(
                user: user,
                d: (userModel i) {
                  setState(() {
                    user = i;
                  });
                },
              ),
              'img': 'assets/images/account_setting.png'
            },
            {
              'name': '购买记录',
              'icon': Icons.star_border,
              'widget': const PurchaseRecordPage(),
              'img': "assets/images/buy_recorde.png"
            },
            {
              'name': '我的方案',
              'icon': Icons.settings,
              'widget': const myPlan(),
              'img': 'assets/images/help_center.png'
            },
            // {
            //   'name': '我的收藏',
            //   'icon': Icons.star_border,
            //   'widget': const MyCollectionPage(),
            //   'img': ''
            // },
            {
              'name': '系统设置',
              'icon': Icons.settings,
              'widget': const SystemSettings(),
              'img': 'assets/images/system_setting.png'
            },
            {
              'name': '人工客服',
              'icon': Icons.local_phone,
              'widget': const ManualCustomerServicePage(),
              'img': 'assets/images/real_serve.png'
            },
            {
              'name': '帮助中心',
              'icon': Icons.settings,
              'widget': const HelpPage(),
              'img': 'assets/images/help_center.png'
            },
            {
              'name': '关于我们',
              'icon': Icons.error_outline,
              'widget': const AboutUsPage(),
              'img': 'assets/images/about_us.png'
            },
            {
              'name': '意见反馈',
              'icon': Icons.face_outlined,
              'img': 'assets/images/feed_back.png',
              'widget': const FeedbackPage()
            },
          ];
        });
      } else {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setBool("is_login", false);
        setState(() {
          is_login = false;
          myMenus = [
            // {
            //   'name': '我的收藏',
            //   'icon': Icons.star_border,
            //   'widget': const MyCollectionPage(),
            //   'img': ''
            // },
            // {
            //   'name': '系统设置',
            //   'icon': Icons.settings,
            //   'widget': const SystemSettings(),
            //   'img': 'assets/images/system_setting.png'
            // },
            {
              'name': '人工客服',
              'icon': Icons.local_phone,
              'widget': const ManualCustomerServicePage(),
              'img': 'assets/images/real_serve.png'
            },
            {
              'name': '帮助中心',
              'icon': Icons.settings,
              'widget': const HelpPage(),
              'img': 'assets/images/help_center.png'
            },
            {
              'name': '关于我们',
              'icon': Icons.error_outline,
              'widget': const AboutUsPage(),
              'img': 'assets/images/about_us.png'
            },
            {
              'name': '意见反馈',
              'icon': Icons.face_outlined,
              'img': 'assets/images/feed_back.png',
              'widget': const FeedbackPage()
            },
          ];
        });
      }
    });
  }

  getUserTop() {
    return is_login
        ? onClick(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(rpx(50)),
                  child: netImg(user?.avatar, rpx(50), rpx(50)),
                ),
                SizedBox(
                  height: rpx(6),
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: rpx(6),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            user.realName.toString(),
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: rpx(14),
                          ),
                          onClick(
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 16),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              child: TextWidget(
                                user.type == 0 ? '申请达人' : "+发布方案",
                                color: Colors.blue,
                                fontSize: rpx(15),
                              ),
                            ),
                            () {
                              if (user.type == 0) {
                                G.router
                                    .navigateTo(context, "/applyTalent",
                                        routeSettings:
                                            RouteSettings(arguments: Map()))
                                    .then((value) {
                                  getUser();
                                });
                              } else {
                                G.router.navigateTo(
                                  context,
                                  "/publishPlan",
                                );
                              }
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ), () {
            Routes.pushPage(AccountSettingsPage(
              user: user,
              d: (userModel i) {
                setState(() {
                  user = i;
                });
              },
            ));
          })
        : Container(
            margin: EdgeInsets.only(bottom: rpx(10)),
            child: Row(
              children: [
                SizedBox(
                  width: rpx(50),
                  height: rpx(50),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(rpx(50)),
                    child: Image.asset(
                      "assets/images/default_head.png",
                      width: rpx(50),
                    ),
                  ),
                ),
                SizedBox(
                  width: rpx(20),
                ),
                onClick(
                    Container(
                      alignment: Alignment.center,
                      height: rpx(30),
                      padding: EdgeInsets.symmetric(horizontal: rpx(20)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(rpx(30)),
                          border: Border.all(color: Colors.black26)),
                      child: TextWidget(
                        "登录",
                      ),
                    ), () {
                  G.router.navigateTo(context, "/login");
                })
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          body: Container(
            color: const Color(0xFFF6F6F6),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: is_login ? rpx(270) : rpx(250),
                  child: Stack(
                    children: [
                      Container(
                        height: rpx(200),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft, // 渐变开始的位置

                            end: Alignment.bottomRight, // 渐变结束的位置

                            colors: [
                              Color.fromARGB(255, 247, 235, 104),
                              Color(0xfff5e84d)
                            ], // 渐变的颜色列表

                            tileMode: TileMode.clamp, // 渐变模式，这里使用clamp表示不重复
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: rpx(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).padding.top,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: rpx(1),
                                ),
                                is_login
                                    ? onClick(
                                        Container(
                                          child: Icon(
                                            Icons.settings,
                                            color: Colors.white,
                                          ),
                                        ), () {
                                        Routes.pushPage(SystemSettings());
                                      })
                                    : Container(),
                              ],
                            ),
                            getUserTop(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                onClick(
                                  Row(
                                    children: [
                                      TextWidget(
                                        user != null
                                            ? user!.fans.toString()
                                            : "0",
                                        fontSize: rpx(18),
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      TextWidget(
                                        '粉丝',
                                        color: Colors.white,
                                        fontSize: rpx(13),
                                      ),
                                    ],
                                  ),
                                  () {
                                    //Routes.pushPage(const Conpon());
                                  },
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                onClick(
                                  Row(
                                    children: [
                                      TextWidget(
                                        user != null
                                            ? user!.flow.toString()
                                            : "0",
                                        fontSize: rpx(18),
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      TextWidget(
                                        '关注',
                                        fontSize: rpx(13),
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  () {
                                    var p = {"index": 0, "is_flow": 1};
                                    G.router.navigateTo(
                                        context,
                                        "/expertTalent" +
                                            G.parseQuery(params: p),
                                        transition: TransitionType.inFromRight);
                                  },
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                onClick(
                                  Row(
                                    children: [
                                      TextWidget(
                                        user != null
                                            ? user!.notice.toString()
                                            : "0",
                                        fontSize: rpx(18),
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      TextWidget(
                                        '消息',
                                        fontSize: rpx(13),
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  () {
                                    Routes.pushPage(const Message());
                                  },
                                ),
                              ],
                            ),
                            Container(
                              height: rpx(15),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          width: MediaQuery.of(context).size.width,
                          bottom: rpx(-5),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            height: rpx(90),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                onClick(
                                    Container(
                                      margin: EdgeInsets.only(left: rpx(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            '全部金豆',
                                            fontSize: rpx(15),
                                          ),
                                          TextWidget(
                                            user != null
                                                ? user!.money.toString()
                                                : "0",
                                            color: Colors.red,
                                            fontSize: rpx(40),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ), () {
                                  Routes.pushPage(const RedCoinRecordsPage());
                                }),
                                onClick(
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 32),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                      ),
                                      child: TextWidget(
                                        '钱包',
                                        color: Colors.white,
                                        fontSize: rpx(15),
                                      ),
                                    ), () {
                                  Routes.pushPage(const RechargePage());
                                })
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: rpx(15),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: rpx(10)),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget(
                                    '活动广场',
                                    fontSize: rpx(16),
                                  ),
                                  onClick(
                                      TextWidget(
                                        '查看更多>',
                                        fontSize: rpx(15),
                                        color: Colors.black54,
                                      ), () {
                                    Routes.pushPage(const EventsPlazaPage());
                                  })
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              onClick(
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child:
                                        Image.asset('assets/images/mybno.png'),
                                  ), () {
                                Routes.pushPage(const InviteFriendsPage());
                              })
                            ],
                          ),
                        ),
                        SizedBox(
                          height: rpx(10),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1.0,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
                              ),
                              itemCount: myMenus.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return onClick(
                                  Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        myMenus[index]["img"] == ''
                                            ? Icon(
                                                myMenus[index]["icon"],
                                                size: rpx(30),
                                                color: Color.fromARGB(
                                                    255, 252, 229, 27),
                                              )
                                            : Image.asset(
                                                myMenus[index]["img"],
                                                fit: BoxFit.cover,
                                                width: rpx(30),
                                              ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        TextWidget(
                                          myMenus[index]["name"],
                                          fontSize: rpx(14),
                                        )
                                      ],
                                    ),
                                  ),
                                  () {
                                    Routes.pushPage(myMenus[index]["widget"]);
                                  },
                                );
                              }),
                        ),
                        SizedBox(
                          height: 20.w,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
