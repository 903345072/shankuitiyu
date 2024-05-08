import 'package:flutter/material.dart';
import 'package:jingcai_app/components/payWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class subscribeDataDetail extends StatefulWidget {
  Map? data;
  subscribeDataDetail({required this.data});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return subscribeDataDetail_();
  }
}

class subscribeDataDetail_ extends State<subscribeDataDetail> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: appbar("订单详情"),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(rpx(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextWidget(
                  widget.data!["title"],
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: rpx(15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    netImg(widget.data!["logo"], rpx(100), rpx(100)),
                    SizedBox(
                      width: rpx(15),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: rpx(220),
                          child: Text(
                            widget.data!["desc"].toString(),
                            softWrap: true,
                            overflow: TextOverflow.clip,
                            style: TextStyle(fontSize: rpx(12)),
                          ),
                        ),
                        Row(
                          children: [
                            TextWidget("原价"),
                            TextWidget(
                              widget.data!["price"].toString(),
                              color: Colors.red,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Container(
                  height: rpx(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    payWidget(
                        price: widget.data!["price"].toString(),
                        button: Container(
                          width: rpx(90),
                          alignment: Alignment.center,
                          height: rpx(35),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(rpx(35))),
                          child: TextWidget(
                            "再次购买",
                            color: Colors.red,
                          ),
                        ),
                        pay_after: (Map data) {
                          G.router.pop(context);
                        },
                        map: {"id": widget.data!["id"].toString()},
                        type: 2)
                  ],
                )
              ],
            ),
          ),
          Container(
            height: rpx(5),
            color: Colors.grey.shade100,
          ),
          Container(
            height: rpx(15),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: rpx(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget("商品原价"),
                TextWidget(widget.data!["price"].toString() + "金豆")
              ],
            ),
          ),
          Container(
            height: rpx(10),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: rpx(10)),
            child: Divider(
              color: Colors.grey.shade300,
            ),
          ),
          Container(
            height: rpx(15),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: rpx(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget("实际付款"),
                TextWidget(
                  widget.data!["pay_money"].toString() + "金豆",
                  color: Colors.red,
                )
              ],
            ),
          ),
          Container(
            height: rpx(10),
          ),
          Container(
            height: rpx(5),
            color: Colors.grey.shade100,
          ),
          Container(
            padding: EdgeInsets.all(rpx(15)),
            child: Row(
              children: [
                Container(
                  color: Colors.red,
                  height: rpx(14),
                  width: rpx(3),
                ),
                SizedBox(
                  width: rpx(10),
                ),
                TextWidget(
                  "订单信息",
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: rpx(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget("付款时间"),
                TextWidget(widget.data!["add_time"].toString())
              ],
            ),
          ),
          Container(
            height: rpx(10),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: rpx(10)),
            child: Divider(
              color: Colors.grey.shade300,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: rpx(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget("订单号"),
                TextWidget(widget.data!["order_no"].toString())
              ],
            ),
          ),
          Container(
            height: rpx(10),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: rpx(10)),
            child: Divider(
              color: Colors.grey.shade300,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: rpx(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [TextWidget("订单状态"), TextWidget("正常")],
            ),
          ),
          Container(
            height: rpx(10),
          ),
          Container(
            color: Colors.grey.shade100,
            height: rpx(100),
          )
        ],
      ),
    );
  }
}
