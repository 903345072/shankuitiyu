import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jingcai_app/util/rpx.dart';

import '../../widget/PreferredSizeWidget.dart';
import '../../widget/colors.dart';
import '../../widget/textWidget.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appbar(
          '帮助中心',
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
                    "常见问题",
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "使用手册",
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            problemPage(),
            userManualPage(),
          ],
        ),
      ),
    );
  }

  Widget problemPage() {
    return Container(
      margin: const EdgeInsets.only(top: 1),
      padding: EdgeInsets.all(30.w),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: rpx(80),
              height: rpx(30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(46.w),
                border: Border.all(
                  width: 1,
                  color: MyColors.red,
                ),
              ),
              child: const TextWidget(
                '名词解释',
                color: MyColors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'Q:什么是【不中补单】？',
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'A:方案标记为【不中补单】，在比赛分析结果预测不正确的情况下将会有新的方案免费补单给购买的用户。可以在购买记录中进行查看。',
              maxLines: 10,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 40.w,
            ),
            const TextWidget(
              'Q:什么是【预售】？',
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'A：标记【预售】的方案购买的时候还未有具体的比赛分析内容，但是会在预定时间更新，到时请注意查看方案内容以及提示。',
              maxLines: 10,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 40.w,
            ),
            Container(
              width: rpx(80),
              height: rpx(30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(46.w),
                border: Border.all(
                  width: 1,
                  color: MyColors.red,
                ),
              ),
              child: const TextWidget(
                '方案购买',
                color: MyColors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'Q:为什么我的红包券用不了？',
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'A：您可以到您的红包卡券中，查看红包券是否有适用范围，有些红包券是仅适用于红榜达人，公众号专家方案是无法使用的，红包券上都是有注明的。',
              maxLines: 10,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'Q:怎么时间到了还没更新方案？',
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'A：一般预订单都会注明大概的更新时间，专家会在比赛之前，结合所有比赛因素进行分析的，有时候会比预计时间晚个几分钟。',
              maxLines: 10,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'Q：推荐的方案是不是稳的，不中可以退款吗？',
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'A：所有方案都是专家根据所有的条件因素去进行分析的，无法保证百分百命中率，您在购买方案之前可以看看专家的近期命中率，当成一个参考，如果方案有注明不中返还的，就一定会返还。',
              maxLines: 10,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'Q：补单又黑了怎么办，还会有补单吗？',
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'A：绝大部分情况下，补单都只有一次。',
              maxLines: 10,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 40.w,
            ),
            Container(
              width: rpx(80),
              height: rpx(30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(46.w),
                border: Border.all(
                  width: 1,
                  color: MyColors.red,
                ),
              ),
              child: const TextWidget(
                '账户充值',
                color: MyColors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'Q：为什么我的充值无法到账？',
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'A：有可能是网络存在延迟，请您稍等。如果超过10分钟没到账，请截图充值记录，在我的-联系客服中添加客服处理问题。',
              maxLines: 10,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'Q：为什么充值金额到账不对？',
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'A：此类问题可能是网络或者充值入口的问题，请您截图充值记录，可在联系客服页面添加客服微信号解决。',
              maxLines: 10,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'Q：如何查看我的红币使用记录',
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'A:点击红币余额，即可进入查看红币使用记录。',
              maxLines: 10,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 40.w,
            ),
            Container(
              width: rpx(80),
              height: rpx(30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(46.w),
                border: Border.all(
                  width: 1,
                  color: MyColors.red,
                ),
              ),
              child: const TextWidget(
                '红榜达人',
                color: MyColors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'Q：如何申请成为红榜达人？',
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'A：可在社区中的红榜达人页面，搜索输入框右侧的发布进行申请；也可以在我的页面中，点击“申请签约”进行红榜达人申请。-联系客服中添加客服处理问题。',
              maxLines: 10,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'Q：成为红榜达人后为什么不能发付费的方案？',
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'A:成为达人后，需要达到如下条件才可发布付费方案：签约超过10天，发布并通过审核的方案30篇，命中率55%以上。',
              maxLines: 10,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 40.w,
            ),
            Container(
              width: rpx(80),
              height: rpx(30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(46.w),
                border: Border.all(
                  width: 1,
                  color: MyColors.red,
                ),
              ),
              child: const TextWidget(
                '其它相关',
                color: MyColors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'Q：山葵大数据预测购买后如何查看？',
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'A：可在购买记录-数据订阅中查看；如果是包月的，则进入有预测的比赛-数据中即可查看。-联系客服中添加客服处理问题。',
              maxLines: 10,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'Q：是否有免费的方案？',
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 20.w,
            ),
            const TextWidget(
              'A:A：有的，您点开社区-找到喜欢的专家-点击免费，就可以查看该方案子。',
              maxLines: 10,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget userManualPage() {
    return Container(
      margin: const EdgeInsets.only(top: 1),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(30.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/UserManual.png',
              ),
            ),
          ),
          const Divider(
            height: 1,
            color: MyColors.grey_e8,
          ),
          Expanded(
            child: UserManualItem(),
          )
        ],
      ),
    );
  }
}

class UserManualItem extends StatefulWidget {
  @override
  _UserManualItemState createState() => _UserManualItemState();
}

class _UserManualItemState extends State<UserManualItem> {
  // ignore: non_constant_identifier_names
  int APPBAR_SCROLL_OFFSET = 100;
  final Map _cityNames = {
    '北京': ['东城区', '西城区'],
    '郑州': ['高新区', '金水区'],
    '上海': ['黄浦区', '徐汇区'],
    '杭州': ['西湖区', '滨江区'],
  };
  double appBarAlpha = 0;
  int? counter;
  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _buildList() {
    List<Widget> widgets = [];
    _cityNames.keys.forEach((key) {
      widgets.add(_item(key, _cityNames[key]));
    });
    return widgets;
  }

  Widget _item(String city, List<String> subCities) {
    return ExpansionTile(
        children: subCities.map((subCity) => _buildSub(subCity)).toList(),
        title: Text(
          city,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 20,
          ),
        ));
  }

  Widget _buildSub(String subCity) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(bottom: 5, left: 12),
        child: Text(
          subCity,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          ExpansionTile(
            children: [
              FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                    margin: const EdgeInsets.only(bottom: 5, left: 12),
                    child: Image.asset('assets/images/use1.png')),
              )
            ],
            leading: Container(
              width: rpx(70),
              height: rpx(70),
              decoration: BoxDecoration(
                color: MyColors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(rpx(70)),
              ),
              child: const Icon(
                Icons.home,
                color: Colors.black,
              ),
            ),
            title: const TextWidget(
              '查看方案',
              textAlign: TextAlign.left,
            ),
            subtitle: const TextWidget(
              '足球与篮球的专业分析都在这里',
              textAlign: TextAlign.left,
              color: MyColors.tip,
            ),
            iconColor: Colors.black,
          ),
          ExpansionTile(
            children: [
              FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                    margin: const EdgeInsets.only(bottom: 5, left: 12),
                    child: Image.asset('assets/images/jsbf.png')),
              )
            ],
            leading: Container(
              width: rpx(70),
              height: rpx(70),
              decoration: BoxDecoration(
                color: MyColors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(rpx(70)),
              ),
              child: const Icon(
                Icons.home,
                color: Colors.black,
              ),
            ),
            title: const TextWidget(
              '即使比分',
              textAlign: TextAlign.left,
            ),
            subtitle: const TextWidget(
              '为了不错过比赛的精彩，点击这里就能看到',
              textAlign: TextAlign.left,
              color: MyColors.tip,
            ),
            iconColor: Colors.black,
          ),
          ExpansionTile(
            children: [
              FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                    margin: const EdgeInsets.only(bottom: 5, left: 12),
                    child: Image.asset('assets/images/sqqy.png')),
              )
            ],
            leading: Container(
              width: rpx(70),
              height: rpx(70),
              decoration: BoxDecoration(
                color: MyColors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(rpx(70)),
              ),
              child: const Icon(
                Icons.home,
                color: Colors.black,
              ),
            ),
            title: const TextWidget(
              '申请签约',
              textAlign: TextAlign.left,
            ),
            subtitle: const TextWidget(
              '签约红榜达人，分享经验获得收益',
              textAlign: TextAlign.left,
              color: MyColors.tip,
            ),
            iconColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
