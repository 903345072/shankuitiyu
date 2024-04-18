import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:jingcai_app/model/draymodel.dart';
import 'package:jingcai_app/model/sysNewsModel.dart';
import 'package:jingcai_app/util/commonComponents.dart';

import 'package:jingcai_app/util/rpx.dart';

class sysNews extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _sysNews();
  }
}

class _sysNews extends State<sysNews> {
  List<sysNewsModel> data = [];
  @override
  void initState() {
    super.initState();

    getDrayData();
  }

  Future getDrayData() async {
    //通过rootBundle.loadString();解析并返回
    String jsonData =
        await rootBundle.loadString("assets/mock/systemNews.json");
    final List jsonresult = json.decode(jsonData)["data"];
    setState(() {
      data = jsonresult
          .map((e) => sysNewsModel.fromJson((e as Map<String, dynamic>)))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      padding: EdgeInsets.all(0),
      children: List.generate(
          data.length,
          (index) => Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 231, 231, 231)))),
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: rpx(10)),
                              child: Text(
                                data[index].title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Color(0xff1b1b1b),
                                    fontSize: rpx(14)),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data[index].count.toString() + "查看",
                                  style: TextStyle(fontSize: rpx(11)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: rpx(10)),
                                  child: Text(
                                    data[index].date,
                                    style: TextStyle(
                                        fontSize: rpx(12), color: Colors.grey),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: netImg(data[index].avatar, rpx(120), rpx(60)),
                        ))
                  ],
                ),
              )),
    );
  }
}
