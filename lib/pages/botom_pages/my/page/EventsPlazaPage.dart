import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widget/PreferredSizeWidget.dart';
import '../../widget/colors.dart';
import '../../widget/routes.dart';
import '../../widget/textWidget.dart';
import 'HistoricalActivitiesPage.dart';

class EventsPlazaPage extends StatefulWidget {
  const EventsPlazaPage({Key? key}) : super(key: key);

  @override
  State<EventsPlazaPage> createState() => _EventsPlazaPageState();
}

class _EventsPlazaPageState extends State<EventsPlazaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: appbar('活动广场', actions: [
        onClick(
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              alignment: Alignment.center,
              child: const TextWidget('历史活动'),
            ), () {
          Routes.pushPage(const HistoricalActivitiesPage());
        }),
      ]),
      body: Container(
        color: MyColors.white,
        padding: const EdgeInsets.fromLTRB(30, 90, 30, 200),
        child: Image.asset('assets/images/EventsPlaza_empty.png'),
      ),
    );
  }
}
