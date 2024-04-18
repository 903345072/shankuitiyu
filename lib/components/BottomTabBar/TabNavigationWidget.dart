import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jingcai_app/util/rpx.dart';

class TabNavigationWidget extends StatefulWidget {
  final onChanged;
  const TabNavigationWidget(this.onChanged, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabNavigationWidget();
  }
}

class _TabNavigationWidget extends State<TabNavigationWidget> {
  int currentIndex = 0;
  List barItemList = [
    {
      "title": "首页",
      "normalIcon": 'assets/images/home_grey.png',
      "selectIcon": 'assets/images/home.png'
    },
    {
      "title": "比分",
      "normalIcon": 'assets/images/score_grey.png',
      "selectIcon": 'assets/images/score.png'
    },
    {
      "title": "社区",
      "normalIcon": 'assets/images/commity_grey.png',
      "selectIcon": 'assets/images/commity.png'
    },
    {
      "title": "大数据",
      "normalIcon": 'assets/images/data_grey.png',
      "selectIcon": 'assets/images/data.png'
    },
    {
      "title": "我的",
      "normalIcon": 'assets/images/mine_grey.png',
      "selectIcon": 'assets/images/mine.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade100))),
      alignment: Alignment.center,
      height: 60,

      // child:  Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children: List<Widget>.generate(barItemList.length,
      //       (index) => _barItem(barItemList[index],index)),
      // ),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(), // 设置禁止滚动
        crossAxisCount: 5,
        children: List<Widget>.generate(
            barItemList.length, (index) => _barItem(barItemList[index], index)),
      ),
    );
  }

  Widget _barItem(item, int index) {
    return InkWell(
      onTap: () {
        if (currentIndex != index) {
          setState(() {
            currentIndex = index;
          });
          widget.onChanged(index);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            currentIndex == index ? item['selectIcon'] : item['normalIcon'],
            width: 24,
            height: 24,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            item['title'],
            style: TextStyle(
              fontSize: 12,
              color: currentIndex == index ? Colors.black : Colors.black,
            ),
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
