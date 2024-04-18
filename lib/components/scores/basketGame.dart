import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jingcai_app/model/BasketModel.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class basketGame extends StatefulWidget {
  JcFootModel basketListElement;
  basketGame({super.key, required this.basketListElement});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _basketGame();
  }
}

class _basketGame extends State<basketGame> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return onClick(
        Container(
            padding: EdgeInsets.all(rpx(10)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 6,
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: rpx(60),
                                child: TextWidget(
                                  widget.basketListElement.leagues!.nameShort
                                      .toString(),
                                  color: hexToColor(
                                      widget.basketListElement.leagues!.color),
                                ),
                              ),
                              Text(widget.basketListElement.startAt.toString(),
                                  style: TextStyle(fontSize: rpx(13))),
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 4,
                        child: Container(
                          alignment: Alignment.center,
                          child:
                              getBasketGameStateText(widget.basketListElement),
                        )),
                    Expanded(flex: 6, child: Container())
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: rpx(5), bottom: rpx(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                width: rpx(80),
                                child: Text(
                                  widget.basketListElement.awayTeam!.nameShort
                                      .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: rpx(15)),
                                ),
                              ),
                              double.parse(widget
                                          .basketListElement.basket_handicap!) <
                                      0
                                  ? Container(
                                      padding: EdgeInsets.only(right: rpx(10)),
                                      child: Text(
                                        widget
                                            .basketListElement.basket_handicap!
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: rpx(13),
                                            color: Color(0xffff9856)),
                                      ),
                                    )
                                  : Container(),
                            ],
                          )),
                      Expanded(
                          flex: 5,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child:
                                getScoreList(widget.basketListElement, "away"),
                          )),
                      onClick(
                          Icon(
                            widget.basketListElement.flow == 0
                                ? Icons.favorite_border
                                : Icons.favorite,
                            color: Colors.red,
                            size: rpx(20),
                          ), () {
                        G.api.gameAdd.collectMatch({
                          "id": widget.basketListElement.id,
                          "type": "2"
                        }).then((value) {
                          setState(() {
                            widget.basketListElement.flow =
                                widget.basketListElement.flow == 0 ? 1 : 0;
                          });
                        });
                      })
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: rpx(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                width: rpx(80),
                                child: Text(
                                  widget.basketListElement.homeTeam!.nameShort!
                                      .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: rpx(15)),
                                ),
                              ),
                              double.parse(widget
                                          .basketListElement.basket_handicap!) >
                                      0
                                  ? Container(
                                      padding: EdgeInsets.only(right: rpx(10)),
                                      child: Text(
                                        widget
                                            .basketListElement.basket_handicap!
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: rpx(13),
                                            color: Color(0xffff9856)),
                                      ),
                                    )
                                  : Container(),
                            ],
                          )),
                      Expanded(
                          flex: 5,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child:
                                getScoreList(widget.basketListElement, "home"),
                          )),
                      Container(
                        width: rpx(20),
                      )
                    ],
                  ),
                )
              ],
            )), () {
      G.router.navigateTo(
          context,
          // ignore: prefer_interpolation_to_compose_strings
          "/basketGameDetail" +
              G.parseQuery(
                  params: {"id": widget.basketListElement.id, "is_detail": 1}),
          transition: TransitionType.inFromRight);
    });
  }

  getStatus(BasketListElement e) {
    if (e.statusId == 1) {
      return Text(
        e.statusCn.toString(),
        style: TextStyle(color: Colors.grey, fontSize: rpx(13)),
      );
    }
    if (e.statusId == 10) {
      return Text(
        e.statusCn.toString(),
        style: TextStyle(color: Colors.red, fontSize: rpx(13)),
      );
    }

    if (e.statusId == 2 ||
        e.statusId == 4 ||
        e.statusId == 6 ||
        e.statusId == 8) {
      return Text(
        e.statusCn.toString() + " " "9'",
        style: TextStyle(color: Colors.green, fontSize: rpx(13)),
      );
    }

    if (e.statusId == 3 || e.statusId == 5 || e.statusId == 7) {
      return Text(
        e.statusCn.toString(),
        style: TextStyle(color: Colors.green, fontSize: rpx(13)),
      );
    }
  }

  getScoreList(JcFootModel e, String type) {
    int index = 0;
    if (type == "away") {
      index = 1;
    }
    List<String> q1_s = e.q1_score != null ? e.q1_score!.split(":") : [];
    List<String> q2_s = e.q2_score != null ? e.q2_score!.split(":") : [];
    List<String> q3_s = e.q3_score != null ? e.q3_score!.split(":") : [];
    List<String> q4_s = e.q4_score != null ? e.q4_score!.split(":") : [];
    List<String> ex_s = e.extraScore != null ? e.extraScore!.split(":") : [];
    List<String> full_s = e.fullScore != null ? e.fullScore!.split(":") : [];
    List<String> cur_s =
        e.currentScore != null ? e.currentScore!.split(":") : [];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        q1_s.isNotEmpty
            ? Container(
                width: rpx(30),
                child: Text(
                  q1_s[index].toString(),
                  style: TextStyle(fontSize: rpx(13)),
                ),
              )
            : Container(
                width: rpx(30),
              ),
        q2_s.isNotEmpty
            ? Container(
                width: rpx(30),
                child: Text(
                  q2_s[index].toString(),
                  style: TextStyle(fontSize: rpx(13)),
                ),
              )
            : Container(
                width: rpx(30),
              ),
        q3_s.isNotEmpty
            ? Container(
                width: rpx(30),
                child: Text(
                  q3_s[index].toString(),
                  style: TextStyle(fontSize: rpx(13)),
                ),
              )
            : Container(
                width: rpx(30),
              ),
        q4_s.isNotEmpty
            ? Container(
                width: rpx(30),
                child: Text(
                  q4_s[index].toString(),
                  style: TextStyle(fontSize: rpx(13)),
                ),
              )
            : Container(
                width: rpx(30),
              ),
        ex_s.isNotEmpty
            ? Container(
                width: rpx(30),
                child: Text(
                  ex_s[index].toString(),
                  style: TextStyle(fontSize: rpx(13)),
                ),
              )
            : Container(
                width: rpx(30),
              ),
        cur_s.isNotEmpty
            ? Container(
                width: rpx(30),
                child: Text(
                  cur_s[index].toString(),
                  style: TextStyle(fontSize: rpx(13), color: Colors.red),
                ),
              )
            : Container(
                width: rpx(30),
              )
      ],
    );
  }
}
