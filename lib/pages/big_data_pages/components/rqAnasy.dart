import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/big_data_pages/components/rqChart.dart';
import 'package:jingcai_app/pages/big_data_pages/components/rqTable.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class rqAnasy extends StatelessWidget {
  List<RqPl>? rqPlList;
  RqPl rq_pl_start = RqPl.fromJson({});
  RqPl rq_pl_cur = RqPl.fromJson({});

  rqAnasy(
      {required this.rqPlList,
      required this.rq_pl_cur,
      required this.rq_pl_start});

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
              TextWidget("让球分析"),
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
                      TextWidget("主队")
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
                      TextWidget("指数")
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
                      TextWidget("客队")
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
                  TextWidget(rq_pl_start.win.toString()),
                  TextWidget(rq_pl_start.handicap.toString()),
                  TextWidget(rq_pl_start.loss.toString()),
                ],
              ),
              Wrap(
                spacing: rpx(4),
                children: [
                  TextWidget("即时"),
                  TextWidget(rq_pl_cur.win.toString()),
                  TextWidget(rq_pl_cur.handicap.toString()),
                  TextWidget(rq_pl_cur.loss.toString()),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: rpx(15)),
          height: rpx(140),
          child: rqChart(
            rqPlList: rqPlList,
          ),
        ),
        rqTable(
          rqPlList: rqPlList,
        ),
      ],
    );
  }
}
