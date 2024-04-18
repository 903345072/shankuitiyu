import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/big_data_pages/components/gameHistoryTable.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';

class historyBattle extends StatefulWidget {
  int? id;
  historyBattle({required this.id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return historyBattle_();
  }
}

class historyBattle_ extends State<historyBattle> {
  List datas = [];
  String home_get_balls = "";
  String home_loss_balls = "";
  String home_win_count = "";
  String home_loss_count = "";
  String home_draw_count = "";
  @override
  void initState() {
    super.initState();
    print(widget.id);
    G.api.game.getHistoryBattleRecord({"id": widget.id}).then((value) {
      setState(() {
        datas = value["history_data"] ?? [];
        home_get_balls = value["home_get_balls"].toString();
        home_loss_balls = value["home_loss_balls"].toString();
        home_win_count = value["home_win_count"].toString();
        home_loss_count = value["home_loss_count"].toString();
        home_draw_count = value["home_draw_count"].toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return datas.length > 0
        ? Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: rpx(15)),
                padding:
                    EdgeInsets.symmetric(horizontal: rpx(15), vertical: rpx(6)),
                color: Color.fromRGBO(0, 40, 104, .06),
                child: TextWidget("历史交锋(10场)"),
              ),
              SizedBox(
                height: rpx(10),
              ),
              Container(
                padding: EdgeInsets.only(left: rpx(15)),
                alignment: Alignment.bottomLeft,
                child: Wrap(
                  spacing: rpx(5),
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    TextWidget(
                      "特里波利斯：$home_win_count胜$home_draw_count平$home_loss_count负 进$home_get_balls球 失$home_loss_balls球",
                      fontSize: rpx(15),
                      textAlign: TextAlign.left,
                    ),
                    TextWidget(
                      "阿里斯：$home_loss_count胜$home_draw_count平$home_win_count负 进$home_loss_balls球 失$home_get_balls球",
                      fontSize: rpx(15),
                    ),
                  ],
                ),
              ),
              gameHistoryTable(datas: datas),
            ],
          )
        : Container();
  }
}
