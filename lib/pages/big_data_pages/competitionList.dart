import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jingcai_app/model/gameDataModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class competitionList extends StatefulWidget {
  int id;
  String name;
  competitionList({required this.id, required this.name});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return competitionList_();
  }
}

class competitionList_ extends State<competitionList> {
  List<String> competionNames = [];
  List<gameData> childs = [];
  int cur_index = 0;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    getExpertData();
  }

  Future getExpertData() async {
    //通过rootBundle.loadString();解析并返回

    G.api.gameAdd.getStateCountry({"id": widget.id}).then((value) {
      setState(() {
        final List jsonresult = value;
        childs = jsonresult
            .map((e) => gameData.fromJson((e as Map<String, dynamic>)))
            .toList();
        for (var i = 0; i < childs.length; i++) {
          competionNames.add(childs[i].cate_name.toString());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(widget.name),
      ),
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    width: 1,
                    color: const Color.fromARGB(255, 240, 239, 239)))),
        padding: EdgeInsets.only(top: rpx(3)),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              color: Color.fromARGB(255, 247, 247, 247),
              width: rpx(95),
              child: ListView(
                padding: EdgeInsets.all(0),
                children: List.generate(
                    competionNames.length,
                    (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              cur_index = index;
                            });
                            var item_count = 0.0;
                            var h = 0.0;
                            var index_ = 0;
                            for (var i = 0; i < childs.length; i++) {
                              if (childs[i].cate_name ==
                                  competionNames[cur_index]) {
                                break;
                              }
                              index_++;
                              item_count +=
                                  (childs[i].childs!.length / 3).ceilToDouble();
                            }
                            h = item_count * 80 + index_ * 75;

                            _scrollController.jumpTo(h);
                          },
                          child: Container(
                            color: cur_index == index
                                ? Colors.white
                                : Color.fromARGB(255, 247, 247, 247),
                            height: rpx(50),
                            alignment: Alignment.center,
                            child: Text(
                              competionNames[index],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: cur_index == index
                                      ? Colors.red
                                      : Colors.black),
                            ),
                          ),
                        )),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: rpx(5), top: 10),
              width: MediaQuery.of(context).size.width - rpx(95),
              child: ListView(
                controller: _scrollController,
                children: List.generate(
                    childs.length,
                    (index) => Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 25,
                                margin: EdgeInsets.only(left: rpx(25)),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: rpx(5)),
                                      child: Text(
                                          childs[index].cate_name.toString()),
                                    ),
                                    childs[index].childs!.isNotEmpty
                                        ? Text(
                                            "${childs[index].childs!.length.toString()}个赛事")
                                        : Container()
                                  ],
                                ),
                              ),
                              Container(
                                height: 20,
                              ),
                              Wrap(
                                children: List.generate(
                                    childs[index].childs!.length,
                                    (index2) => onClick(
                                            Container(
                                              alignment: Alignment(0, 0),
                                              width: rpx(90),
                                              height: 80,
                                              color: Colors.white,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  netImg(
                                                      childs[index]
                                                          .childs![index2]
                                                          .competitionLogo
                                                          .toString(),
                                                      rpx(40),
                                                      rpx(40)),
                                                  SizedBox(
                                                    height: rpx(10),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: rpx(60),
                                                    child: Text(
                                                      childs[index]
                                                          .childs![index2]
                                                          .competitionName
                                                          .toString(),
                                                      softWrap: false,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: rpx(13),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ), () {
                                          G.router.navigateTo(
                                              context,
                                              "/leagueDetail" +
                                                  G.parseQuery(params: {
                                                    "id": childs[index]
                                                        .childs![index2]
                                                        .id,
                                                    "name": childs[index]
                                                        .childs![index2]
                                                        .fullName,
                                                    "logo": childs[index]
                                                        .childs![index2]
                                                        .competitionLogo
                                                  }));
                                        })),
                              ),
                              Container(
                                height: 30,
                              )
                            ],
                          ),
                        )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
