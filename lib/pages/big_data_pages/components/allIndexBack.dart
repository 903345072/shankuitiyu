import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';

class allIndexBack extends StatefulWidget {
  int? id;

  int type;

  allIndexBack({required this.id, required this.type, super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return allIndexBack_();
  }
}

class allIndexBack_ extends State<allIndexBack> {
  int page = 1;
  List data = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  addPage() {
    setState(() {
      page++;
    });
  }

  Future getData() {
    var d = G.api.game.getAllIndexData(
        {"id": widget.id, "type": widget.type, "page": page}).then((value) {
      setState(() {
        data.addAll(value);
      });

      return value;
    });
    return d;
  }

  Border getBorder() {
    return Border(
        right:
            BorderSide(width: 0.5, color: Color.fromARGB(255, 219, 219, 219)),
        bottom:
            BorderSide(width: 0.5, color: Color.fromARGB(255, 219, 219, 219)));
  }

  int getDir(double cha) {
    int c = 0;
    if (cha > 0) {
      c = 1;
    }
    if (cha < 0) {
      c = 2;
    }
    return c;
  }

  List<TableRow> getTableRow() {
    List<TableRow> rows = [];
    var a = [1, 2, 3];
    var b = [4, 5, 6];
    var c = [7, 8, 9];
    var first_index = "win";
    var first_dire = "win_direct";
    var second_index = "draw";
    var second_direct = "draw_direct";
    var last_index = "loss";
    var last_dire = "loss_direct";
    List initList = data.where((element) => element["type"] == 1).toList();
    if (initList.isNotEmpty) {
      data.removeWhere((element) => element["type"] == 1);
      data.add(initList.first);
    }
    if (a.contains(widget.type)) {
      rows.add(TableRow(
          decoration: BoxDecoration(
            color: Color(0xfffde6e6),
          ),
          children: [
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

      for (var i = 0; i < data.length; i++) {
        if (i >= 0 && i < data.length - 1) {
          data[i][first_dire] = getDir((double.parse(data[i][first_index]) -
              double.parse(data[i + 1][first_index])));
          data[i][second_direct] = getDir((double.parse(data[i][second_index]) -
              double.parse(data[i + 1][second_index])));
          data[i][last_dire] = getDir((double.parse(data[i][last_index]) -
              double.parse(data[i + 1][last_index])));
        }
      }
    }

    if (b.contains(widget.type)) {
      second_index = "handicap";
      second_direct = "no";
      rows.add(TableRow(
          decoration: BoxDecoration(
            color: Color(0xfffde6e6),
          ),
          children: [
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

      for (var i = 0; i < data.length; i++) {
        if (i >= 0 && i < data.length - 1) {
          data[i][first_dire] = getDir((double.parse(data[i][first_index]) -
              double.parse(data[i + 1][first_index])));

          data[i][last_dire] = getDir((double.parse(data[i][last_index]) -
              double.parse(data[i + 1][last_index])));
        }
      }
    }

    if (c.contains(widget.type)) {
      first_index = "dq";
      second_index = "handicap";
      last_index = "xq";
      first_dire = "dq_direct";
      second_direct = "no";
      last_dire = "xq_direct";
      rows.add(TableRow(
          decoration: BoxDecoration(
            color: Color(0xfffde6e6),
          ),
          children: [
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
      for (var i = 0; i < data.length; i++) {
        if (i >= 0 && i < data.length - 1) {
          data[i][first_dire] = getDir((double.parse(data[i][first_index]) -
              double.parse(data[i + 1][first_index])));

          data[i][last_dire] = getDir((double.parse(data[i][last_index]) -
              double.parse(data[i + 1][last_index])));
        }
      }
    }

    Color getColor(int d) {
      Color c = Colors.black;
      if (d == 1) {
        c = Colors.red;
      }
      if (d == 2) {
        c = Colors.green;
      }
      return c;
    }

    List<TableRow> child = data
        .map((e) => TableRow(children: [
              Container(
                decoration: BoxDecoration(border: getBorder()),
                alignment: Alignment.center,
                height: rpx(40),
                child: TextWidget(
                  e[first_index].toString(),
                  color: getColor(e[first_dire]),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: getBorder()),
                alignment: Alignment.center,
                height: rpx(40),
                child: TextWidget(
                  e[second_index].toString(),
                  color: second_direct != "no"
                      ? getColor(e[second_direct])
                      : Colors.black,
                ),
              ),
              Container(
                decoration: BoxDecoration(border: getBorder()),
                alignment: Alignment.center,
                height: rpx(40),
                child: TextWidget(
                  e[last_index].toString(),
                  color: getColor(e[last_dire]),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: getBorder()),
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
