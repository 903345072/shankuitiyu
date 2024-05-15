import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class jqRqRate extends StatelessWidget {
  String rq_num;
  String dxq_num;
  int dq_rate;
  int xq_rate;
  int rq_win_rate;
  int rq_lose_rate;
  jqRqRate(
      {required this.rq_num,
      required this.dxq_num,
      required this.dq_rate,
      required this.xq_rate,
      required this.rq_win_rate,
      required this.rq_lose_rate});

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
          child: TextWidget("进球&让球概率分布"),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: rpx(15)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget("进球数($dxq_num)"),
                  Row(
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
                      Container(
                        width: rpx(10),
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
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: rpx(5)),
                    alignment: Alignment.centerLeft,
                    color: Colors.red,
                    height: rpx(25),
                    width: (MediaQuery.of(context).size.width - rpx(50)) *
                        dq_rate /
                        100,
                    child: TextWidget(
                      dq_rate.toString() + "%",
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    color: Color(0xff002868),
                    height: rpx(25),
                    width: (MediaQuery.of(context).size.width - rpx(50)) *
                        xq_rate /
                        100,
                  ),
                ],
              ),
              SizedBox(
                height: rpx(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget("让球($rq_num)"),
                  Row(
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
                      Container(
                        width: rpx(10),
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
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: rpx(10)),
                    color: Colors.red,
                    height: rpx(25),
                    width: (MediaQuery.of(context).size.width - rpx(50)) *
                        rq_win_rate /
                        100,
                    child: TextWidget(
                      rq_win_rate.toString() + "%",
                      color: Colors.white,
                    ),
                  ),
                  Container(
                      color: Color(0xff002868),
                      height: rpx(25),
                      width: (MediaQuery.of(context).size.width - rpx(50)) *
                          rq_lose_rate /
                          100),
                ],
              ),
              SizedBox(
                height: rpx(10),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    "注",
                    color: Colors.grey,
                  ),
                  Container(
                    width: rpx(5),
                  ),
                  Wrap(
                    spacing: rpx(3),
                    direction: Axis.vertical,
                    children: [
                      TextWidget(
                        "1.数据仅供参考！不做结果保证，请理性对待",
                        color: Colors.grey,
                      ),
                      TextWidget(
                        "2.数据提前12小时给出，每小时更新，请及时关注！",
                        color: Colors.grey,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: rpx(10),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
