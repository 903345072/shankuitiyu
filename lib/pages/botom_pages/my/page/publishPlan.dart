import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jingcai_app/components/daxiaoPublishPlanFactory.dart';
import 'package:jingcai_app/components/dxfPublishPlanFactory.dart';
import 'package:jingcai_app/components/jcFootPublishPlanFactory.dart';
import 'package:jingcai_app/components/publishPlanFactory.dart';
import 'package:jingcai_app/components/rfsfPublishPlanFactory.dart';
import 'package:jingcai_app/components/rqPublishPlanFactory.dart';
import 'package:jingcai_app/enum/planType.dart';
import 'package:jingcai_app/model/PlanModel.dart';
import 'package:jingcai_app/pages/botom_pages/my/page/ApplicationInfluencerPage.dart';
import 'package:jingcai_app/pages/botom_pages/my/page/publish.dart';
import 'package:jingcai_app/pages/botom_pages/widget/InputWidget.dart';

import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/loading.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widget/PreferredSizeWidget.dart';
import '../../widget/colors.dart';
import '../../widget/routes.dart';
import '../../widget/textWidget.dart';

class publishPlan extends StatefulWidget {
  publishPlan({
    Key? key,
  }) : super(key: key);

  @override
  State<publishPlan> createState() => _SubmitProposalInformationPageState();
}

class _SubmitProposalInformationPageState extends State<publishPlan> {
  PlanModel? plan1;
  PlanModel? plan2;
  int is_click = 1;
  String type1 = planType.jcFoot.value;
  String type2 = planType.jcFoot.value;
  SharedPreferences? sharedPreferences;
  Map<String, publishPlanFactory> map = {
    planType.jcFoot.value: jcFootPublishPlanFactory(),
    planType.rq.value: rqPublishPlanFactory(),
    planType.daxiaoqiu.value: daxiaoPublishPlanFactory(),
    planType.rfsf.value: rfsfPublishPlanFactory(),
    planType.dxf.value: dxfPublishPlanFactory(),
  };
  double price = 0;
  bool is_bd = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.white,
      appBar: appbar('发布方案'),
      body: Container(
        color: MyColors.white,
        padding: EdgeInsets.all(20.w),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget("不中是否补单"),
                onClick(
                    is_bd
                        ? Container(
                            width: rpx(20),
                            height: rpx(20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.w),
                              border: Border.all(
                                width: 1,
                                color: MyColors.red,
                              ),
                            ),
                            child: Container(
                              width: rpx(15),
                              height: rpx(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.w),
                                color: MyColors.red,
                              ),
                            ),
                          )
                        : Container(
                            width: rpx(20),
                            height: rpx(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                rpx(20),
                              ),
                              border: Border.all(
                                width: 1,
                                color: MyColors.grey_99,
                              ),
                            ),
                          ), () {
                  setState(() {
                    is_bd = !is_bd;
                  });
                }),
              ],
            ),
            SizedBox(
              height: rpx(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget("方案价格"),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      width: rpx(90),
                      height: rpx(38),
                      padding: EdgeInsets.only(left: rpx(5)),
                      alignment: Alignment.center,
                      child: InputWidget(
                        onChanged: (e) {
                          setState(() {
                            price = double.parse(e);
                          });
                        },
                        textInputType: TextInputType.number,
                        hintText: '输入方案价格',
                        hintStyle:
                            TextStyle(color: MyColors.tip, fontSize: rpx(13)),
                        textStyle: TextStyle(
                            color: MyColors.black_33,
                            fontSize: rpx(13),
                            textBaseline: TextBaseline.alphabetic),
                      ),
                    ),
                    SizedBox(
                      width: rpx(10),
                    ),
                    const TextWidget(
                      "金豆",
                      color: Colors.red,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: rpx(20),
            ),
            TextWidget(
              '原创达人方案',
              fontWeight: FontWeight.bold,
              fontSize: rpx(15),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: rpx(20),
            ),
            plan1 != null
                ? onClick(
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            plan1!.title.toString(),
                            fontSize: rpx(14),
                          ),
                          SizedBox(
                            height: rpx(10),
                          ),
                          plan1!.files != null
                              ? Column(
                                  children: [
                                    Wrap(
                                      spacing: rpx(10),
                                      runSpacing: rpx(10),
                                      children: List.generate(
                                          plan1!.files!.length,
                                          (index) => Container(
                                                child: Image.file(
                                                  File(plan1!.files![index]),
                                                  width: rpx(100),
                                                  height: rpx(100),
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                    ),
                                    SizedBox(
                                      height: rpx(10),
                                    ),
                                  ],
                                )
                              : Container(),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(
                                  plan1!.footmodel!.length,
                                  (index) => map[type1]!.PlanGameContent(
                                      plan1!.footmodel![index]))),
                          SizedBox(
                            height: rpx(20),
                          ),
                        ],
                      ),
                    ), () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return publish(
                          type: type1,
                          planModel: plan1,
                        );
                      },
                    )).then((value) {
                      if (value != null) {
                        setState(() {
                          plan1 = value;
                          savePlan(plan1!, "plan1");
                        });
                      }
                    });
                  })
                : Container(),
            plan1 == null
                ? onClick(
                    Container(
                      height: rpx(40),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(width: 1, color: MyColors.grey_e8)),
                      child: TextWidget(
                        '+添加原创达人方案',
                        color: MyColors.red,
                        fontSize: rpx(15),
                      ),
                    ), () {
                    show();
                  })
                : Container(),
            SizedBox(
              height: rpx(20),
            ),
            SizedBox(height: rpx(20)),
            TextWidget(
              '方案须知：',
              fontWeight: FontWeight.bold,
              fontSize: rpx(14),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: rpx(20)),
            TextWidget(
              '1.提交可选择的比赛的赛事分析和预测方案。',
              fontSize: rpx(13),
              color: MyColors.tip,
              textAlign: TextAlign.left,
            ),
            TextWidget(
              '2.方案无抄袭，保证一定的质量。',
              fontSize: rpx(13),
              color: MyColors.tip,
              textAlign: TextAlign.left,
            ),
            TextWidget(
              '3.文章发布不可包含行业敏感词（例如盘口、盘路、中水、高水、降水等）；更多敏感词详见发文提示。',
              fontSize: rpx(13),
              color: MyColors.tip,
              maxLines: 2,
              textAlign: TextAlign.left,
            ),
            TextWidget(
              '4.在9：00〜17：00之间进行申请。可加快通过审核的速度。',
              fontSize: rpx(13),
              color: MyColors.tip,
              textAlign: TextAlign.left,
            ),
            TextWidget(
              '5.审核的方案的比赛时间尽量选择截止时间长一点的。',
              fontSize: rpx(13),
              color: MyColors.tip,
              textAlign: TextAlign.left,
            ),
            TextWidget(
              '6.审核过程可能持续1-5个工作日。请注意登录平台查看相关信息',
              fontSize: rpx(13),
              color: MyColors.tip,
              maxLines: 2,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: rpx(10),
            ),
            plan1 != null && is_click == 1
                ? Container(
                    alignment: Alignment.center,
                    child: clickBtn(
                      '提交审核',
                      () {
                        setState(() {
                          is_click = 0;
                        });
                        plan1!.price = price;
                        plan1!.is_bd = is_bd;

                        Map<String, dynamic> m = {
                          "plan1": plan1!.toSimPleJson(),
                        };

                        G.api.plan.publishPlan(m).then((value) {
                          if (value != 200) {
                            setState(() {
                              is_click = 1;
                            });
                          } else {
                            tipSucess("发布成功");
                          }
                        });
                      },
                    ),
                  )
                : disableBtn('提交审核', () {}),
          ],
        ),
      ),
    );
  }

  savePlan(PlanModel p, String type) async {}

  show({int? index = 0}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.fromLTRB(60.w, rpx(20), 60.w, 0),
            child: ListView(
              children: [
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: TextWidget(
                        '选择方案类型',
                        fontWeight: FontWeight.w500,
                        fontSize: rpx(17),
                      ),
                    ),
                    onClick(
                        const Icon(
                          Icons.close,
                          color: MyColors.tip,
                        ), () {
                      Routes.popPage();
                    })
                  ],
                ),
                SizedBox(
                  height: rpx(10),
                ),
                onClick(
                    Container(
                      height: rpx(45),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: MyColors.red.withOpacity(0.1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/jc_foot.png",
                            width: rpx(30),
                          ),
                          TextWidget(
                            '竞足',
                            fontSize: rpx(15),
                          ),
                        ],
                      ),
                    ), () async {
                  G.router.pop(context);
                  setState(() {
                    if (index == 0) {
                      type1 = planType.jcFoot.value;
                    } else {
                      type2 = planType.jcFoot.value;
                    }
                  });
                  await G.router
                      .navigateTo(
                          context,
                          "/publish" +
                              G.parseQuery(
                                  params: {"type": planType.jcFoot.value}),
                          transition: TransitionType.inFromRight)
                      .then((value) {
                    setState(() {
                      if (value != null) {
                        if (index == 0) {
                          plan1 = value;
                          savePlan(plan1!, "plan1");
                        } else {
                          plan2 = value;
                          savePlan(plan2!, "plan2");
                        }
                      }
                    });
                  });
                }),
                SizedBox(
                  height: rpx(10),
                ),
                onClick(
                    Container(
                      height: rpx(45),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: MyColors.blue_3f.withOpacity(0.1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/rang.png",
                            width: rpx(30),
                          ),
                          TextWidget(
                            '让球',
                            fontSize: rpx(15),
                          ),
                        ],
                      ),
                    ), () async {
                  setState(() {
                    if (index == 0) {
                      type1 = planType.rq.value;
                    } else {
                      type2 = planType.rq.value;
                    }
                  });
                  G.router.pop(context);
                  await G.router
                      .navigateTo(
                          context,
                          "/publish" +
                              G.parseQuery(params: {"type": planType.rq.value}),
                          transition: TransitionType.inFromRight)
                      .then((value) {
                    setState(() {
                      if (value != null) {
                        if (index == 0) {
                          plan1 = value;
                          savePlan(plan1!, "plan1");
                        } else {
                          plan2 = value;
                          savePlan(plan2!, "plan2");
                        }
                      }
                    });
                  });
                }),
                SizedBox(
                  height: rpx(10),
                ),
                onClick(
                    Container(
                      height: rpx(45),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: MyColors.blue_3f.withOpacity(0.1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/jin.png",
                            width: rpx(30),
                          ),
                          TextWidget(
                            '进球数',
                            fontSize: rpx(15),
                          ),
                        ],
                      ),
                    ), () async {
                  setState(() {
                    if (index == 0) {
                      type1 = planType.daxiaoqiu.value;
                    } else {
                      type2 = planType.daxiaoqiu.value;
                    }
                  });
                  G.router.pop(context);
                  await G.router
                      .navigateTo(
                          context,
                          "/publish" +
                              G.parseQuery(
                                  params: {"type": planType.daxiaoqiu.value}),
                          transition: TransitionType.inFromRight)
                      .then((value) {
                    setState(() {
                      if (value != null) {
                        if (index == 0) {
                          plan1 = value;
                          savePlan(plan1!, "plan1");
                        } else {
                          plan2 = value;
                          savePlan(plan2!, "plan2");
                        }
                      }
                    });
                  });
                }),
                SizedBox(
                  height: rpx(10),
                ),
                onClick(
                    Container(
                      height: rpx(45),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: MyColors.blue_3f.withOpacity(0.1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/rang.png",
                            width: rpx(30),
                          ),
                          TextWidget(
                            '让分胜负(篮球)',
                            fontSize: rpx(15),
                          ),
                        ],
                      ),
                    ), () async {
                  setState(() {
                    if (index == 0) {
                      type1 = planType.rfsf.value;
                    } else {
                      type2 = planType.rfsf.value;
                    }
                  });
                  G.router.pop(context);
                  await G.router
                      .navigateTo(
                          context,
                          "/publish" +
                              G.parseQuery(
                                  params: {"type": planType.rfsf.value}),
                          transition: TransitionType.inFromRight)
                      .then((value) {
                    setState(() {
                      if (value != null) {
                        if (index == 0) {
                          plan1 = value;
                          savePlan(plan1!, "plan1");
                        } else {
                          plan2 = value;
                          savePlan(plan2!, "plan2");
                        }
                      }
                    });
                  });
                }),
                SizedBox(
                  height: rpx(10),
                ),
                onClick(
                    Container(
                      height: rpx(45),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: MyColors.blue_3f.withOpacity(0.1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/jinqiu.png",
                            width: rpx(30),
                          ),
                          TextWidget(
                            '总分(篮球)',
                            fontSize: rpx(15),
                          ),
                        ],
                      ),
                    ), () async {
                  setState(() {
                    if (index == 0) {
                      type1 = planType.dxf.value;
                    } else {
                      type2 = planType.dxf.value;
                    }
                  });
                  G.router.pop(context);
                  await G.router
                      .navigateTo(
                          context,
                          "/publish" +
                              G.parseQuery(
                                  params: {"type": planType.dxf.value}),
                          transition: TransitionType.inFromRight)
                      .then((value) {
                    setState(() {
                      if (value != null) {
                        if (index == 0) {
                          plan1 = value;
                          savePlan(plan1!, "plan1");
                        } else {
                          plan2 = value;
                          savePlan(plan2!, "plan2");
                        }
                      }
                    });
                  });
                }),
                SizedBox(
                  height: rpx(20),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: 10.w),
                  child: TextWidget(
                    '方案发布现则：',
                    fontSize: rpx(13),
                    color: MyColors.tip,
                  ),
                ),
                TextWidget(
                  '1 .方案发布提交时间访至少早于比赛开始时间2个小时.以免审核不及时导致过期.',
                  fontSize: rpx(13),
                  color: MyColors.tip,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
                TextWidget(
                  ' 2 .达人方案市核时间为09：00~23：00,诵在此期间提交方案进行审核.',
                  fontSize: rpx(13),
                  color: MyColors.tip,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          );
        });
  }
}
