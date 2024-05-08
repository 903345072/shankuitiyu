import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widget/PreferredSizeWidget.dart';
import '../../widget/colors.dart';
import '../../widget/textWidget.dart';

class Interest extends StatefulWidget {
  const Interest({Key? key}) : super(key: key);

  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appbar(
          '我的关注',
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.red,
            indicatorWeight: 1.5,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 60),
            labelColor: Colors.red,
            unselectedLabelColor: Colors.black87,
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "福神专家",
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "红榜达人",
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 1),
              padding: EdgeInsets.all(30.w),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const TextWidget('您还未关注任何专家'),
                    const SizedBox(
                      height: 10,
                    ),
                    const TextWidget(
                      '关注专家获取更多赛事分析',
                      fontSize: 26,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    clickBtn('一键关注以下专家', () {}),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const TextWidget(
                        '推荐关注',
                        fontSize: 34,
                      ),
                    ),
                    interestItem(),
                    interestItem(),
                    interestItem(),
                    interestItem(),
                    interestItem(),
                    interestItem(),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 1),
              padding: EdgeInsets.all(30.w),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const TextWidget('您还未关注任何专家'),
                    const SizedBox(
                      height: 10,
                    ),
                    const TextWidget(
                      '关注专家获取更多赛事分析',
                      fontSize: 26,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    clickBtn('一键关注以下专家', () {}),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const TextWidget(
                        '推荐关注',
                        fontSize: 34,
                      ),
                    ),
                    interestItem(),
                    interestItem(),
                    interestItem(),
                    interestItem(),
                    interestItem(),
                    interestItem(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget interestItem() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.w),
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xFFF6F6F6)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                alignment: Alignment.centerRight,
                width: 90.w,
                height: 90.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(90.w),
                  child: Image.network(
                    'https://ms.bdimg.com/pacific/0/pic/-159517095_-2067355848.png',
                    width: 90.w,
                    height: 90.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: -5,
                child: Container(
                  width: 30.w,
                  height: 30.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: MyColors.red,
                      borderRadius: BorderRadius.circular(20.w),
                      border: Border.all(width: 1, color: MyColors.white)),
                  child: const TextWidget(
                    '1',
                    fontSize: 20,
                    whiteColor: true,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    TextWidget(
                      '友成权哥',
                      fontSize: 28,
                    ),
                    TextWidget(
                      '粉丝：835',
                      fontSize: 26,
                      color: MyColors.grey_33,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
                      color: MyColors.red.withOpacity(0.1),
                      child: const TextWidget(
                        '擅长早场赛事',
                        fontSize: 24,
                        color: MyColors.red,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                        color: MyColors.red,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const TextWidget(
                        '+关注',
                        fontSize: 24,
                        color: MyColors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16.w,
                ),
                const TextWidget(
                  '主要以上比赛为主，如：模饲料、美职业、巴西卡里的几',
                  fontSize: 26,
                  color: MyColors.grey_33,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
