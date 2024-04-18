import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widget/PreferredSizeWidget.dart';
import '../../widget/colors.dart';
import '../../widget/textWidget.dart';

class HistoricalActivitiesPage extends StatefulWidget {
  const HistoricalActivitiesPage({Key? key}) : super(key: key);

  @override
  State<HistoricalActivitiesPage> createState() =>
      _HistoricalActivitiesPageState();
}

class _HistoricalActivitiesPageState extends State<HistoricalActivitiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('历史活动'),
      body: Container(
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
            child: Container(
          alignment: Alignment.center,
          child: TextWidget("暂无活动"),
        )),
      ),
    );
  }
}
