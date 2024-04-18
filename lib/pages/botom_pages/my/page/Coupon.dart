import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/my/page/couponList.dart';

import '../../widget/PreferredSizeWidget.dart';

class Conpon extends StatefulWidget {
  const Conpon({Key? key}) : super(key: key);

  @override
  State<Conpon> createState() => _ConponState();
}

class _ConponState extends State<Conpon> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: appbar("红包卡券"),
        // appBar: appbar(
        //   '红包卡券',
        //   bottom: const TabBar(
        //     indicatorSize: TabBarIndicatorSize.label,
        //     indicatorColor: Colors.red,
        //     indicatorWeight: 1.5,
        //     indicatorPadding: EdgeInsets.symmetric(horizontal: 60),
        //     labelColor: Colors.red,
        //     unselectedLabelColor: Colors.black87,
        //     tabs: [
        //       Tab(
        //         child: Align(
        //           alignment: Alignment.center,
        //           child: Text(
        //             "卡券",
        //           ),
        //         ),
        //       ),
        //       // Tab(
        //       //   child: Align(
        //       //     alignment: Alignment.center,
        //       //     child: Text(
        //       //       "红包",
        //       //     ),
        //       //   ),
        //       // ),
        //     ],
        //   ),
        // ),
        // body: TabBarView(
        //   children: [
        //     couponList(),
        //     // Container(
        //     //   margin: const EdgeInsets.only(top: 1),
        //     //   padding: const EdgeInsets.all(50),
        //     //   color: Colors.white,
        //     //   child: Image.asset(
        //     //     'assets/images/nodata.png',
        //     //   ),
        //     // ),
        //   ],
        // ),
        body: couponList(),
      ),
    );
  }
}
