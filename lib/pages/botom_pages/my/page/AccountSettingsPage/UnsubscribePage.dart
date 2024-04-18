import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widget/PreferredSizeWidget.dart';
import '../../../widget/colors.dart';

class UnsubscribePage extends StatefulWidget {
  const UnsubscribePage({Key? key}) : super(key: key);

  @override
  State<UnsubscribePage> createState() => _UnsubscribePageState();
}

class _UnsubscribePageState extends State<UnsubscribePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('申请注销账户'),
      body: Container(
          color: MyColors.white,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 150),
                      child: Image.asset(
                        'asset/images/unsubscribe.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 80.w,
                child: clickBtn('已清楚风险，确认注销', () {}),
              )
            ],
          )),
    );
  }
}
