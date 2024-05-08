import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jingcai_app/enum/planCheckState.dart';
import 'package:jingcai_app/model/PlanModel.dart';
import 'package:jingcai_app/pages/botom_pages/my/page/planCheck.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widget/PreferredSizeWidget.dart';
import '../../widget/colors.dart';
import '../../widget/routes.dart';
import '../../widget/textWidget.dart';
import 'SubmitExpertInformationPage.dart';

class ApplicationInfluencerPage extends StatefulWidget {
  const ApplicationInfluencerPage({Key? key}) : super(key: key);

  @override
  State<ApplicationInfluencerPage> createState() =>
      _ApplicationInfluencerPageState();
}

class _ApplicationInfluencerPageState extends State<ApplicationInfluencerPage> {
  bool select = false;
  int check_state = 0;
  String? refuse_text;

  @override
  void initState() {
    super.initState();

    getCheckState();
  }

  getCheckState() {
    G.api.plan.getCheckState({}).then((value) {
      if (value != null) {
        setState(() {
          check_state = value["state"];
          refuse_text = value["refuse_text"];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar('申请成为达人'),
        body: Stack(
          children: [
            Container(
              color: MyColors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: rpx(10),
                  ),
                  stepbar(),
                  Container(
                    height: 10.w,
                    margin: const EdgeInsets.only(top: 15, bottom: 5),
                    color: MyColors.grey_6f6,
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: planCheck(
                state: check_state,
                refuse_text: refuse_text,
                setCheckState: () {
                  getCheckState();
                },
              ),
            )
          ],
        ));
  }

  Widget stepbar() {
    var arr1 = [0, 1, 2];
    var arr2 = [3, 4, 5];
    var arr3 = [6];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              width: rpx(23),
              height: rpx(23),
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 10.w),
              decoration: BoxDecoration(
                  color:
                      arr1.contains(check_state) ? MyColors.red : Colors.white,
                  border: arr1.contains(check_state)
                      ? null
                      : Border.all(
                          width: 1.5,
                          color: MyColors.grey_33,
                        ),
                  borderRadius: BorderRadius.circular(46.w)),
              child: TextWidget(
                '1',
                color: arr1.contains(check_state)
                    ? MyColors.white
                    : MyColors.grey_33,
                fontSize: rpx(14),
              ),
            ),
            TextWidget(
              '专家信息审核',
              color:
                  arr1.contains(check_state) ? MyColors.red : MyColors.grey_33,
              fontSize: rpx(13),
            ),
          ],
        ),
        Container(
          height: 1.w,
          width: rpx(65),
          color: MyColors.grey_33,
        ),
        Column(
          children: [
            Container(
              width: rpx(23),
              height: rpx(23),
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 10.w),
              decoration: BoxDecoration(
                  color:
                      arr2.contains(check_state) ? MyColors.red : Colors.white,
                  border: arr2.contains(check_state)
                      ? null
                      : Border.all(
                          width: 1.5,
                          color: MyColors.grey_33,
                        ),
                  borderRadius: BorderRadius.circular(46.w)),
              child: TextWidget(
                '2',
                color: arr2.contains(check_state)
                    ? MyColors.white
                    : MyColors.grey_33,
                fontSize: rpx(14),
              ),
            ),
            TextWidget(
              '个人资料审核',
              color:
                  arr2.contains(check_state) ? MyColors.red : MyColors.grey_33,
              fontSize: rpx(13),
            ),
          ],
        ),
        Container(
          height: 1.w,
          width: rpx(65),
          color: MyColors.grey_33,
        ),
        Column(
          children: [
            Container(
              width: rpx(23),
              height: rpx(23),
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 10.w),
              decoration: BoxDecoration(
                  color:
                      arr3.contains(check_state) ? MyColors.red : Colors.white,
                  border: arr3.contains(check_state)
                      ? null
                      : Border.all(
                          width: 1.5,
                          color: MyColors.grey_33,
                        ),
                  borderRadius: BorderRadius.circular(46.w)),
              child: TextWidget(
                '3',
                color: arr3.contains(check_state)
                    ? MyColors.white
                    : MyColors.grey_33,
                fontSize: rpx(14),
              ),
            ),
            TextWidget(
              '审核通过',
              color:
                  arr3.contains(check_state) ? MyColors.red : MyColors.grey_33,
              fontSize: rpx(13),
            ),
          ],
        ),
      ],
    );
  }
}
