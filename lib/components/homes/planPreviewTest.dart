import 'package:flutter/material.dart';
import 'package:jingcai_app/model/recommendModel.dart';
import 'package:jingcai_app/util/rpx.dart';

class planPreviewTest extends StatefulWidget {
  recommendModel recmodel;
  bool? is_head;
  planPreviewTest({required this.recmodel, this.is_head});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return planPreview_();
  }
}

class planPreview_ extends State<planPreviewTest> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1, color: Color.fromARGB(255, 231, 231, 231)))),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Wrap(
        runSpacing: 5,
        spacing: 5,
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        direction: Axis.vertical,
        children: [
          widget.is_head == true
              ? Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  children: [
                    CircleAvatar(
                      radius: rpx(20),
                      backgroundImage: NetworkImage(
                        widget.recmodel.avatar,
                      ),
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      spacing: 3,
                      children: [
                        Text(widget.recmodel.nickname),
                        Container(
                          padding: EdgeInsets.all(2.5),
                          color: const Color(0xfffdeaea),
                          child: Text(
                            widget.recmodel.intro,
                            style: TextStyle(
                                fontSize: rpx(10),
                                color: const Color(0xffef2f2f)),
                          ),
                        )
                      ],
                    )
                  ],
                )
              : Container(),
          Container(
            width: rpx(350),
            child: Text(
              widget.recmodel.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: rpx(14), fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: rpx(350),
            child: Text(
              widget.recmodel.content_desc,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                color: Colors.black45,
                fontSize: rpx(13),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: rpx(10)),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  children: [
                    getSellState(widget.recmodel.state),
                    Text(
                      widget.recmodel.date,
                      style: TextStyle(color: Colors.red, fontSize: rpx(12)),
                    ),
                    Text(
                      "后截止",
                      style: TextStyle(
                          color: Color(0xff6f6f6f), fontSize: rpx(12)),
                    ),
                    Wrap(
                      spacing: 3,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(widget.recmodel.count.toString(),
                            style: TextStyle(
                                color: Color(0xff6f6f6f), fontSize: rpx(12))),
                        Text("查看",
                            style: TextStyle(
                                color: Color(0xff6f6f6f), fontSize: rpx(12)))
                      ],
                    )
                  ],
                ),
                widget.recmodel.is_bd == 0
                    ? Wrap(
                        spacing: 3,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(widget.recmodel.price.toInt().toString(),
                              style: TextStyle(color: Colors.red)),
                          Text("金豆", style: TextStyle(color: Colors.red))
                        ],
                      )
                    : Container(
                        child: Row(
                          children: [
                            Container(
                              height: rpx(20),
                              padding: EdgeInsets.only(left: 3, right: 3),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(3),
                                      bottomLeft: Radius.circular(3))),
                              child: Text(
                                "不中补单",
                                style: TextStyle(
                                    color: Colors.white, fontSize: rpx(13)),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 3, right: 3),
                              height: rpx(20),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.red),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(3),
                                      bottomRight: Radius.circular(3))),
                              child: Text(
                                widget.recmodel.price.toInt().toString() + "金币",
                                style: TextStyle(
                                    color: Colors.red, fontSize: rpx(13)),
                              ),
                            )
                          ],
                        ),
                      )
              ],
            ),
          ),
          widget.recmodel.game_comment != null
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.only(
                      left: rpx(10),
                      right: rpx(10),
                      top: rpx(2),
                      bottom: rpx(2)),
                  color: Color.fromRGBO(0, 0, 0, .04),
                  child: Text(
                    widget.recmodel.game_comment.toString(),
                    style: TextStyle(color: Colors.red, fontSize: rpx(12)),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  getSellState(s) {
    var t = "";
    if (s > 0) {
      if (s == 1) {
        t = "热卖中";
      }
      if (s == 2) {
        t = "预售中";
      }
      return Container(
        padding: EdgeInsets.only(left: 3, right: 3, top: 2, bottom: 2),
        margin: EdgeInsets.only(top: 2, bottom: 2),
        color: const Color(0xfffdeaea),
        child: Text(
          t,
          style: TextStyle(fontSize: rpx(10), color: const Color(0xffef2f2f)),
        ),
      );
    } else {
      return Container();
    }
  }
}
