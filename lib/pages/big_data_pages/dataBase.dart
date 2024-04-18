import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/model/dataBaseModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class dataBase extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dataBase_();
  }
}

class dataBase_ extends State<dataBase> {
  List<BlockName> blockName = [];
  List<HotMatch> hotMatch = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    G.api.gameAdd.getHotGame({}).then((value) {
      var d = DataBaseModel.fromJson(value);
      setState(() {
        blockName = d.data!.blockName!;
        hotMatch = d.data!.hotMatch!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        Container(
          margin: EdgeInsets.only(bottom: rpx(15), left: rpx(15)),
          child: Text(
            "全部赛事",
            style: TextStyle(fontSize: rpx(18), fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
              blockName.length,
              (index) => GestureDetector(
                    onTap: () {
                      G.router.navigateTo(
                          context,
                          "/competitionList" +
                              G.parseQuery(params: {
                                "id": blockName[index].categoryId,
                                "name": blockName[index].nameZh.toString()
                              }),
                          transition: TransitionType.inFromRight);
                    },
                    child: Wrap(
                      direction: Axis.vertical,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        netImg(blockName[index].categoryImg.toString(), rpx(45),
                            rpx(45)),
                        Text(blockName[index].nameZh.toString())
                      ],
                    ),
                  )),
        ),
        Container(
          margin: EdgeInsets.only(top: rpx(15)),
          height: rpx(8),
          color: Color.fromARGB(255, 247, 246, 246),
        ),
        Container(
          margin: EdgeInsets.only(bottom: rpx(15), left: rpx(15), top: rpx(10)),
          child: Text(
            "热门赛事",
            style: TextStyle(fontSize: rpx(18), fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Wrap(
            children: List.generate(
                hotMatch.length,
                (index) => onClick(
                        Container(
                          padding:
                              EdgeInsets.only(top: rpx(15), bottom: rpx(15)),
                          margin: EdgeInsets.all(rpx(5)),
                          color: Color(0xfffafafb),
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Wrap(
                            spacing: rpx(5),
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              netImg(hotMatch[index].logo.toString(), rpx(40),
                                  rpx(40)),
                              Text(
                                hotMatch[index].shortNameZh.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: rpx(14)),
                              )
                            ],
                          ),
                        ), () {
                      G.router.navigateTo(
                          context,
                          // ignore: prefer_interpolation_to_compose_strings
                          "/leagueDetail" +
                              G.parseQuery(params: {
                                "id": hotMatch[index].competitionId,
                                "logo": hotMatch[index].logo,
                                "name": hotMatch[index].shortNameZh
                              }));
                    })),
          ),
        )
      ],
    );
  }
}
