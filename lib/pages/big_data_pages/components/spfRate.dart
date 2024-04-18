import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class spfRate extends StatelessWidget {
  String win_rate;
  String draw_rate;
  String loss_rate;
  spfRate(
      {required this.win_rate,
      required this.draw_rate,
      required this.loss_rate});
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
          child: TextWidget("胜平负概率分布"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Wrap(
              spacing: rpx(10),
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                TextWidget(
                  "$win_rate%",
                  fontSize: rpx(27),
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                TextWidget(
                  "主胜",
                  fontSize: rpx(16),
                )
              ],
            ),
            Wrap(
              spacing: rpx(10),
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                TextWidget(
                  "$draw_rate%",
                  fontSize: rpx(27),
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
                TextWidget(
                  "平",
                  fontSize: rpx(16),
                )
              ],
            ),
            Wrap(
              spacing: rpx(10),
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                TextWidget(
                  "$loss_rate%",
                  fontSize: rpx(27),
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                TextWidget(
                  "客胜",
                  fontSize: rpx(16),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
