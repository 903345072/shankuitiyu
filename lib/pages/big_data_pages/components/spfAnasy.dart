import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/big_data_pages/components/spfChart.dart';
import 'package:jingcai_app/pages/big_data_pages/components/spfTable.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class spfAnasy extends StatelessWidget {
  List<spfPl>? spfPlList;
  spfPl spf_pl_start = spfPl.fromJson({});
  spfPl spf_pl_cur = spfPl.fromJson({});
  double win_kaili = 0;
  double draw_kaili = 0;
  double loss_kaili = 0;
  spfAnasy(
      {required this.draw_kaili,
      required this.loss_kaili,
      required this.win_kaili,
      required this.spfPlList,
      required this.spf_pl_start,
      required this.spf_pl_cur});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: rpx(15), vertical: rpx(15)),
          padding: EdgeInsets.symmetric(horizontal: rpx(15), vertical: rpx(6)),
          color: Color.fromRGBO(0, 40, 104, .06),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget("胜平负分析"),
              Wrap(
                spacing: rpx(10),
                children: [
                  Row(
                    children: [
                      Container(
                        width: rpx(10),
                        height: rpx(10),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(rpx(10))),
                      ),
                      TextWidget("主胜")
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: rpx(10),
                        height: rpx(10),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(rpx(10))),
                      ),
                      TextWidget("平")
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: rpx(10),
                        height: rpx(10),
                        decoration: BoxDecoration(
                            color: Color(0xff002868),
                            borderRadius: BorderRadius.circular(rpx(10))),
                      ),
                      TextWidget("客胜")
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: rpx(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: rpx(4),
                children: [
                  TextWidget("初始"),
                  TextWidget(spf_pl_start.win.toString()),
                  TextWidget(spf_pl_start.draw.toString()),
                  TextWidget(spf_pl_start.loss.toString()),
                ],
              ),
              Wrap(
                spacing: rpx(4),
                children: [
                  TextWidget("即时"),
                  TextWidget(spf_pl_cur.win.toString()),
                  TextWidget(spf_pl_cur.draw.toString()),
                  TextWidget(spf_pl_cur.loss.toString()),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: rpx(15)),
          padding: EdgeInsets.symmetric(horizontal: rpx(15)),
          height: rpx(150),
          child: spfChart(
            spfPlList: spfPlList,
          ),
        ),
        spfTable(
          spfPlList: spfPlList,
          win_kaili: win_kaili,
          draw_kaili: draw_kaili,
          loss_kaili: loss_kaili,
        )
      ],
    );
  }
}
