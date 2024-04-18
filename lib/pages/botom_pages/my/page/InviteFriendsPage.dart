import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:jingcai_app/pages/login/userEvent.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import '../../widget/PreferredSizeWidget.dart';
import '../../widget/colors.dart';
import '../../widget/routes.dart';
import '../../widget/textWidget.dart';
import 'SharePage.dart';

class InviteFriendsPage extends StatefulWidget {
  const InviteFriendsPage({Key? key}) : super(key: key);

  @override
  State<InviteFriendsPage> createState() => _InviteFriendsPageState();
}

class _InviteFriendsPageState extends State<InviteFriendsPage> {
  List swiperList = [];
  int count = 0;
  String money = "";
  int bag_count = 0;
  StreamSubscription? loginSubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    loginSubscription = eventBus.on<userEvent>().listen((event) {
      if (event.is_login == true) {
        getData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    loginSubscription!.cancel();
  }

  getData() {
    G.api.user.getInviteRecord({}).then((value) {
      setState(() {
        swiperList = value["list"];
        count = value["invite_count"];
        money = value["award"];
        bag_count = value["bag_count"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFf75050),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/invite_top.png',
                    fit: BoxFit.cover,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset('assets/images/invite_1.png'),
                      Positioned(
                          bottom: rpx(40),
                          height: rpx(60),
                          left: 0,
                          right: 0,
                          child: Swiper(
                              index: 0,
                              controller: SwiperController(),
                              scrollDirection: Axis.vertical,
                              autoplay: true,
                              loop: false,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  alignment: Alignment.center,
                                  child: Wrap(
                                    spacing: rpx(15),
                                    direction: Axis.vertical,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Container(
                                        child: TextWidget(swiperList[index]
                                                ["user"] +
                                            " " +
                                            "邀请好友成功"),
                                      ),
                                      Container(
                                        child: TextWidget(
                                          "获得" +
                                              swiperList[index]["title"]
                                                  .toString(),
                                          color: Colors.red,
                                          fontSize: rpx(17),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: swiperList.length))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    decoration: BoxDecoration(
                        color: const Color(0xfffff4e5),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 3, color: const Color(0xffffe3a9))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            TextWidget(
                              count.toString(),
                              color: MyColors.red,
                              fontSize: rpx(20),
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const TextWidget(
                              '成功邀请',
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextWidget(
                              money,
                              color: MyColors.red,
                              fontSize: rpx(20),
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const TextWidget(
                              '固定奖励',
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextWidget(
                              bag_count.toString(),
                              color: MyColors.red,
                              fontSize: rpx(20),
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const TextWidget(
                              '未拆红包',
                            ),
                          ],
                        ),
                        onClick(
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: rpx(80),
                              child: Image.asset('assets/images/invite_2.png'),
                            ), () {
                          G.api.user.openBag({}).then((value) {
                            if (value["msg"] == "ok") {
                              setState(() {
                                bag_count--;
                              });
                              showConfirmationDialog(context, () {
                                G.router.pop(context);
                              },
                                  title: "恭喜您获得" + value["data"].toString(),
                                  rightTxt: "确定");
                            }
                          });
                        })
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    padding: EdgeInsets.all(30.w),
                    decoration: BoxDecoration(
                        color: const Color(0xfffff4e5),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 3, color: const Color(0xffffe3a9))),
                    child: Column(
                      children: const [
                        TextWidget(
                          '邀请规则',
                          color: Color(0xff713a08),
                          fontSize: 32,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextWidget(
                          '1、用户每邀请一个好友安装注册，即可获得88元固定奖励红包优惠券+一次拆红包机会。',
                          maxLines: 4,
                          color: Color(0xff2f2f2f),
                          textAlign: TextAlign.left,
                        ),
                        TextWidget(
                          '2、拆红包类型包括：现金红包、免单券、红包优惠券。',
                          maxLines: 4,
                          color: Color(0xff2f2f2f),
                          textAlign: TextAlign.left,
                        ),
                        TextWidget(
                          '3、红包优惠券不开提现、不可转赠、过期作废。',
                          maxLines: 4,
                          color: Color(0xff2f2f2f),
                          textAlign: TextAlign.left,
                        ),
                        TextWidget(
                          '4、活动最终解释权，归山葵足球所有，若有发现利用非法漏洞参与活动，非法牟利或破坏计算机系统等行为，本平台保有法律途径手段与权力 ',
                          maxLines: 4,
                          color: Color(0xff2f2f2f),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200.w,
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  bottom: rpx(30), top: 30.w, left: 30.w, right: 30.w),
              color: MyColors.white,
              child: clickBtn('立即邀请', () {
                Routes.pushPage(const SharePage());
              }),
            ),
            Positioned(
              top: 50.w,
              left: 20.w,
              child: onClick(
                  Icon(
                    Icons.navigate_before,
                    color: MyColors.white,
                    size: 60.w,
                  ), () {
                Routes.popPage();
              }),
            ),
          ],
        ));
  }
}
