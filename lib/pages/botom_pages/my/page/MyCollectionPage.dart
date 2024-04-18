import 'package:flutter/material.dart';
import '../../widget/PreferredSizeWidget.dart';

class MyCollectionPage extends StatefulWidget {
  const MyCollectionPage({Key? key}) : super(key: key);

  @override
  State<MyCollectionPage> createState() => _MyCollectionPageState();
}

class _MyCollectionPageState extends State<MyCollectionPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appbar(
          '我的收藏',
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
                    "视频",
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "合集",
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
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 200),
              color: Colors.white,
              child: Image.asset('asset/images/collection_empty.png'),
            ),
            Container(
              margin: const EdgeInsets.only(top: 1),
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 200),
              color: Colors.white,
              child: Image.asset(
                'asset/images/collection_empty.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
