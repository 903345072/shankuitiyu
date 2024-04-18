import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/big_data_pages/components/jqChart.dart';
import 'package:jingcai_app/pages/big_data_pages/components/jqTable.dart';
import 'package:jingcai_app/pages/big_data_pages/components/rqChart.dart';
import 'package:jingcai_app/pages/big_data_pages/components/rqTable.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class jqAnasy extends StatelessWidget {
  List<jqPl>? jqPlList;
  jqPl jq_pl_start = jqPl.fromJson({});
  jqPl jq_pl_cur = jqPl.fromJson({});

  jqAnasy(
      {required this.jqPlList,
      required this.jq_pl_start,
      required this.jq_pl_cur});

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
              TextWidget("进球数分析"),
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
                      TextWidget("大球")
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
                      TextWidget("小球")
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
                  TextWidget(jq_pl_start.dq.toString()),
                  TextWidget(jq_pl_start.handicap.toString()),
                  TextWidget(jq_pl_start.xq.toString()),
                ],
              ),
              Wrap(
                spacing: rpx(4),
                children: [
                  TextWidget("即时"),
                  TextWidget(jq_pl_cur.dq.toString()),
                  TextWidget(jq_pl_cur.handicap.toString()),
                  TextWidget(jq_pl_cur.xq.toString()),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: rpx(15)),
          height: rpx(140),
          child: jqChart(
            jqPlList: jqPlList,
          ),
        ),
        jqTable(
          jqPlList: jqPlList,
        ),
      ],
    );
  }
}
