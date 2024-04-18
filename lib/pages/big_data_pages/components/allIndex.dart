import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class allIndex extends StatelessWidget {
  List data = [];
  int type = 1;
  allIndex({required this.data, required this.type});

  Border getBorder() {
    return Border(
        right:
            BorderSide(width: 0.5, color: Color.fromARGB(255, 219, 219, 219)),
        bottom:
            BorderSide(width: 0.5, color: Color.fromARGB(255, 219, 219, 219)));
  }

  List<TableRow> getTableRow() {
    List<TableRow> rows = [];
    var a = [1, 2, 3];
    var b = [4, 5, 6];
    var c = [7, 8, 9];
    var first_index = "win";
    var second_index = "draw";
    var last_index = "loss";
    if (a.contains(type)) {
      rows.add(TableRow(children: [
        Container(
          alignment: Alignment.center,
          child: const TextWidget("主胜"),
          height: rpx(40),
        ),
        Container(
          alignment: Alignment.center,
          height: rpx(40),
          child: TextWidget("平"),
        ),
        Container(
          alignment: Alignment.center,
          height: rpx(40),
          child: TextWidget("客胜"),
        ),
        Container(
          alignment: Alignment.center,
          height: rpx(40),
          child: TextWidget("更新时间"),
        ),
      ]));
    }

    if (b.contains(type)) {
      second_index = "handicap";
      rows.add(TableRow(children: [
        Container(
          alignment: Alignment.center,
          child: const TextWidget("让胜"),
          height: rpx(40),
        ),
        Container(
          alignment: Alignment.center,
          height: rpx(40),
          child: TextWidget("指数"),
        ),
        Container(
          alignment: Alignment.center,
          height: rpx(40),
          child: TextWidget("让负"),
        ),
        Container(
          alignment: Alignment.center,
          height: rpx(40),
          child: TextWidget("更新时间"),
        ),
      ]));
    }

    if (c.contains(type)) {
      first_index = "dq";
      second_index = "handicap";
      last_index = "xq";
      rows.add(TableRow(children: [
        Container(
          alignment: Alignment.center,
          child: const TextWidget("大球"),
          height: rpx(40),
        ),
        Container(
          alignment: Alignment.center,
          height: rpx(40),
          child: TextWidget("指数"),
        ),
        Container(
          alignment: Alignment.center,
          height: rpx(40),
          child: TextWidget("小球"),
        ),
        Container(
          alignment: Alignment.center,
          height: rpx(40),
          child: TextWidget("更新时间"),
        ),
      ]));
    }

    List<TableRow> child = data
        .map((e) => TableRow(children: [
              Container(
                alignment: Alignment.center,
                height: rpx(40),
                child: TextWidget(e[first_index].toString()),
              ),
              Container(
                alignment: Alignment.center,
                height: rpx(40),
                child: TextWidget(e[second_index].toString()),
              ),
              Container(
                alignment: Alignment.center,
                height: rpx(40),
                child: TextWidget(e[last_index].toString()),
              ),
              Container(
                alignment: Alignment.center,
                height: rpx(40),
                child: TextWidget(e["time"].toString()),
              ),
            ]))
        .toList();
    rows.addAll(child);
    return rows;
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
                    "指数详情",
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
            children: getTableRow(),
          ),
        )
      ],
    );
  }
}
