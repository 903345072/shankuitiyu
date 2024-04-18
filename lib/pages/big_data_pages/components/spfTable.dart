import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class spfTable extends StatelessWidget {
  List<spfPl>? spfPlList;
  double win_kaili = 0;
  double draw_kaili = 0;
  double loss_kaili = 0;
  spfTable({
    super.key,
    required this.spfPlList,
    required this.draw_kaili,
    required this.loss_kaili,
    required this.win_kaili,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        SizedBox(
          height: rpx(15),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: rpx(10)),
          child: Table(
            border: TableBorder(
                bottom: BorderSide(
                    width: 0.5,
                    color: const Color.fromARGB(255, 219, 219, 219))),
            columnWidths: {4: FixedColumnWidth(rpx(45))},
            children: [
              TableRow(
                  decoration: BoxDecoration(
                    color: Color(0xfffde6e6),
                  ),
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: rpx(45),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: rpx(45),
                      child: TextWidget(
                        "最高",
                        fontSize: rpx(13),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: rpx(45),
                      child: TextWidget(
                        "最低",
                        fontSize: rpx(13),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: rpx(45),
                      child: TextWidget(
                        "平均",
                        fontSize: rpx(13),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: rpx(45),
                      child: Text(
                        "即时平均凯利",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: rpx(13)),
                      ),
                    )
                  ]),
              TableRow(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: rpx(20),
                      child: TextWidget(
                        "主胜",
                        fontSize: rpx(13),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: rpx(20),
                      child: TextWidget(
                        spfPlList!
                            .map((e) => double.parse(e.win.toString()))
                            .toList()
                            .reduce(max)
                            .toString(),
                        fontSize: rpx(13),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: rpx(20),
                      child: TextWidget(
                        spfPlList!
                            .map((e) => double.parse(e.win.toString()))
                            .toList()
                            .reduce(min)
                            .toString(),
                        fontSize: rpx(13),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: rpx(20),
                        child: TextWidget(
                          getAvg(spfPlList!
                              .map((e) => double.parse(e.win.toString()))
                              .toList()),
                          fontSize: rpx(13),
                        )),
                    Container(
                      alignment: Alignment.center,
                      height: rpx(20),
                      child: TextWidget(
                        win_kaili.toString(),
                        fontSize: rpx(13),
                      ),
                    )
                  ]),
              TableRow(
                  decoration: BoxDecoration(
                    color: Color(0xfffde6e6),
                  ),
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: rpx(20),
                      child: TextWidget(
                        "平",
                        fontSize: rpx(13),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: rpx(20),
                      child: TextWidget(
                        spfPlList!
                            .map((e) => double.parse(e.draw.toString()))
                            .toList()
                            .reduce(max)
                            .toString(),
                        fontSize: rpx(13),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: rpx(20),
                      child: TextWidget(
                        spfPlList!
                            .map((e) => double.parse(e.draw.toString()))
                            .toList()
                            .reduce(min)
                            .toString(),
                        fontSize: rpx(13),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: rpx(20),
                        child: TextWidget(
                          getAvg(spfPlList!
                              .map((e) => double.parse(e.draw.toString()))
                              .toList()),
                          fontSize: rpx(13),
                        )),
                    Container(
                      alignment: Alignment.center,
                      height: rpx(20),
                      child: TextWidget(
                        draw_kaili.toString(),
                        fontSize: rpx(13),
                      ),
                    )
                  ]),
              TableRow(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: rpx(20),
                      child: TextWidget(
                        "客胜",
                        fontSize: rpx(13),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: rpx(20),
                      child: TextWidget(
                        spfPlList!
                            .map((e) => double.parse(e.loss.toString()))
                            .toList()
                            .reduce(max)
                            .toString(),
                        fontSize: rpx(13),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: rpx(20),
                      child: TextWidget(
                        spfPlList!
                            .map((e) => double.parse(e.loss.toString()))
                            .toList()
                            .reduce(min)
                            .toString(),
                        fontSize: rpx(13),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: rpx(20),
                        child: TextWidget(
                          getAvg(spfPlList!
                              .map((e) => double.parse(e.loss.toString()))
                              .toList()),
                          fontSize: rpx(13),
                        )),
                    Container(
                      alignment: Alignment.center,
                      height: rpx(20),
                      child: TextWidget(
                        loss_kaili.toString(),
                        fontSize: rpx(13),
                      ),
                    )
                  ]),
            ],
          ),
        )
      ],
    );
  }

  getAvg(List<double> s) {
    return (s.reduce((value, element) => value + element) / s.length)
        .toStringAsFixed(2);
  }
}
