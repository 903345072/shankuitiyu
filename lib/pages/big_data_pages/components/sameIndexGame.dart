import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class sameIndexGame extends StatelessWidget {
  int win_count = 0;
  int draw_count = 0;
  int loss_count = 0;
  sameIndexGame(
      {required this.draw_count,
      required this.loss_count,
      required this.win_count});
  double getWinBfb() {
    var t = win_count + draw_count + loss_count;
    if (t == 0) {
      return 0;
    }
    return (win_count / t) * 100;
  }

  double getDrawBfb() {
    var t = win_count + draw_count + loss_count;
    if (t == 0) {
      return 0;
    }
    return (draw_count / t) * 100;
  }

  double getLossBfb() {
    var t = win_count + draw_count + loss_count;
    if (t == 0) {
      return 0;
    }
    return 100 - getWinBfb() - getDrawBfb();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: rpx(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: rpx(4),
                    height: rpx(20),
                    color: Colors.red,
                  ),
                  Container(
                    width: rpx(5),
                  ),
                  TextWidget(
                    "初指相同的比赛",
                    fontSize: rpx(18),
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: rpx(10), vertical: rpx(10)),
          child: Table(
            border: const TableBorder(
                left: BorderSide(
                    width: 0.5, color: Color.fromARGB(255, 219, 219, 219)),
                right: BorderSide(
                    width: 0.5, color: Color.fromARGB(255, 219, 219, 219)),
                bottom: BorderSide(
                    width: 0.5, color: Color.fromARGB(255, 219, 219, 219))),
            children: [
              TableRow(
                  decoration: const BoxDecoration(
                    color: Color(0xfffde6e6),
                  ),
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: const TextWidget("赛果"),
                      height: rpx(40),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: rpx(40),
                      child: TextWidget("胜"),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: rpx(40),
                      child: TextWidget("平"),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: rpx(40),
                      child: TextWidget("负"),
                    ),
                  ]),
              TableRow(children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 0.5,
                              color: Color.fromARGB(255, 219, 219, 219)),
                          bottom: BorderSide(
                              width: 0.5,
                              color: Color.fromARGB(255, 219, 219, 219)))),
                  alignment: Alignment.center,
                  child: TextWidget("场次"),
                  height: rpx(40),
                ),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: Color.fromARGB(255, 219, 219, 219)),
                          right: BorderSide(
                              width: 0.5,
                              color: Color.fromARGB(255, 219, 219, 219)))),
                  alignment: Alignment.center,
                  height: rpx(40),
                  child: TextWidget(win_count.toString()),
                ),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: Color.fromARGB(255, 219, 219, 219)),
                          right: BorderSide(
                              width: 0.5,
                              color: Color.fromARGB(255, 219, 219, 219)))),
                  alignment: Alignment.center,
                  height: rpx(40),
                  child: TextWidget(draw_count.toString()),
                ),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: Color.fromARGB(255, 219, 219, 219)),
                          right: BorderSide(
                              width: 0.5,
                              color: Color.fromARGB(255, 219, 219, 219)))),
                  alignment: Alignment.center,
                  height: rpx(40),
                  child: TextWidget(loss_count.toString()),
                ),
              ]),
              TableRow(children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 0.5,
                              color: Color.fromARGB(255, 219, 219, 219)))),
                  alignment: Alignment.center,
                  child: TextWidget("占比"),
                  height: rpx(40),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 0.5,
                              color:
                                  const Color.fromARGB(255, 219, 219, 219)))),
                  alignment: Alignment.center,
                  height: rpx(40),
                  child: TextWidget(getWinBfb().toStringAsFixed(0) + "%"),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 0.5,
                              color:
                                  const Color.fromARGB(255, 219, 219, 219)))),
                  alignment: Alignment.center,
                  height: rpx(40),
                  child: TextWidget(getDrawBfb().toStringAsFixed(0) + "%"),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 0.5,
                              color:
                                  const Color.fromARGB(255, 219, 219, 219)))),
                  alignment: Alignment.center,
                  height: rpx(40),
                  child: TextWidget(getLossBfb().toStringAsFixed(0) + "%"),
                ),
              ])
            ],
          ),
        )
      ],
    );
  }
}
