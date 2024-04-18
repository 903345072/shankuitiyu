import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';

class jcFootPlList extends StatefulWidget {
  int? id;
  jcFootPlList({required this.id});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return jcFootPlList_();
  }
}

class jcFootPlList_ extends State<jcFootPlList> {
  @override
  void initState() {
    super.initState();
    // print(widget.id);
    getData();
  }

  List spfs = [];
  List rq = [];
  Map jq = {};
  Map bqc = {};
  Map bf = {};

  getData() {
    print(widget.id);
    G.api.game.getJcPlList({"id": widget.id}).then((value) {
      setState(() {
        spfs = value["spf_odds"];
        rq = value["rq_odds"];
        jq = value["jq_odds"] ?? {};
        bqc = value["bqc_odds"] ?? {};
        bf = value["bf_odds"] ?? {};
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: rpx(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: rpx(15),
              ),
              TextWidget(
                "胜平负",
                fontSize: rpx(15),
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: rpx(15),
              ),
              Table(
                columnWidths: {0: FixedColumnWidth(rpx(145))},
                border: TableBorder.all(width: rpx(0.5), color: Colors.grey),
                children: getspfTabRow(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: rpx(20),
        ),
        Container(
          color: Color(0xfff0f0f0),
          height: rpx(5),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: rpx(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: rpx(15),
              ),
              TextWidget(
                "让球胜平负",
                fontSize: rpx(15),
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: rpx(15),
              ),
              Table(
                columnWidths: {0: FixedColumnWidth(rpx(145))},
                border: TableBorder.all(width: rpx(0.5), color: Colors.grey),
                children: getrqTabRow(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: rpx(20),
        ),
        Container(
          color: Color(0xfff0f0f0),
          height: rpx(5),
        ),
        jq.isNotEmpty
            ? Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: rpx(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: rpx(15),
                        ),
                        TextWidget(
                          "总进球",
                          fontSize: rpx(15),
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: rpx(15),
                        ),
                        Table(
                          border: TableBorder.all(
                              width: rpx(0.5), color: Colors.grey),
                          children: getjqTabRow(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: rpx(20),
                  ),
                  Container(
                    color: Color(0xfff0f0f0),
                    height: rpx(5),
                  )
                ],
              )
            : Container(),
        bqc.isNotEmpty
            ? Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: rpx(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: rpx(15),
                        ),
                        TextWidget(
                          "半全场",
                          fontSize: rpx(15),
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: rpx(15),
                        ),
                        Table(
                          border: TableBorder.all(
                              width: rpx(0.5), color: Colors.grey),
                          children: getbqcTabRow(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: rpx(20),
                  ),
                  Container(
                    color: Color(0xfff0f0f0),
                    height: rpx(5),
                  )
                ],
              )
            : Container(),
        bf.isNotEmpty
            ? Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: rpx(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: rpx(15),
                        ),
                        TextWidget(
                          "比分",
                          fontSize: rpx(15),
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: rpx(15),
                        ),
                        Table(
                          border: TableBorder.all(
                              width: rpx(0.5), color: Colors.grey),
                          children: getbfTabRow(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: rpx(20),
                  ),
                  Container(
                    color: Color(0xfff0f0f0),
                    height: rpx(5),
                  )
                ],
              )
            : Container(),
      ],
    );
  }

  List<TableRow> getbfTabRow() {
    List<TableRow> c = [];
    Map d = bf["texts"];
    c.add(
      TableRow(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 245, 245, 245),
          ),
          children: [
            Container(
              alignment: Alignment.center,
              height: rpx(20),
              child: TextWidget("发布时间:   " + bf!["change_at"]),
            ),
          ]),
    );

    c.add(TableRow(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        children: [
          Wrap(
            direction: Axis.horizontal,
            children: d.entries
                .map((e) => Container(
                      width: rpx(57.5),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: rpx(0.2), color: Colors.grey)),
                      alignment: Alignment.center,
                      height: rpx(45),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextWidget(
                            getbfText(e.key.toString()),
                            fontSize: rpx(12),
                          ),
                          TextWidget(
                            e.value.toString(),
                            fontSize: rpx(12),
                          )
                        ],
                      ),
                    ))
                .toList(),
          )
        ]));
    return c;
  }

  String getbfText(s) {
    if (s == "wx") {
      s = "胜其他";
    }
    if (s == "dx") {
      s = "平其他";
    }
    if (s == "lx") {
      s = "负其他";
    }
    return s;
  }

  List<TableRow> getbqcTabRow() {
    List<TableRow> c = [];
    Map d = bqc["texts"];
    c.add(
      TableRow(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 245, 245, 245),
          ),
          children: [
            Container(
              alignment: Alignment.center,
              height: rpx(20),
              child: TextWidget("发布时间:   " + bqc!["change_at"]),
            ),
          ]),
    );

    c.add(TableRow(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: d.entries
                .map((e) => Container(
                      padding: EdgeInsets.symmetric(horizontal: rpx(4)),
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  width: rpx(0.2), color: Colors.grey))),
                      alignment: Alignment.center,
                      height: rpx(45),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextWidget(
                            e.key.toString(),
                            fontSize: rpx(12),
                          ),
                          TextWidget(
                            e.value.toString(),
                            fontSize: rpx(12),
                          )
                        ],
                      ),
                    ))
                .toList(),
          )
        ]));
    return c;
  }

  List<TableRow> getjqTabRow() {
    List<TableRow> c = [];
    Map d = jq["texts"];
    c.add(
      TableRow(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 245, 245, 245),
          ),
          children: [
            Container(
              alignment: Alignment.center,
              height: rpx(20),
              child: TextWidget("发布时间:   " + jq!["change_at"]),
            ),
          ]),
    );

    c.add(TableRow(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: d.entries
                .map((e) => Container(
                      padding: EdgeInsets.symmetric(horizontal: rpx(7)),
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  width: rpx(0.2), color: Colors.grey))),
                      alignment: Alignment.center,
                      height: rpx(45),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextWidget(
                            e.key.toString(),
                            fontSize: rpx(12),
                          ),
                          TextWidget(
                            e.value.toString(),
                            fontSize: rpx(12),
                          )
                        ],
                      ),
                    ))
                .toList(),
          )
        ]));
    return c;
  }

  List<TableRow> getspfTabRow() {
    List<TableRow> c = [];
    c.add(TableRow(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 245, 245, 245),
        ),
        children: [
          Container(
            alignment: Alignment.center,
            height: rpx(20),
            child: TextWidget("发布时间"),
          ),
          Container(
            alignment: Alignment.center,
            height: rpx(20),
            child: TextWidget("胜"),
          ),
          Container(
            alignment: Alignment.center,
            height: rpx(20),
            child: TextWidget("平"),
          ),
          Container(
            alignment: Alignment.center,
            height: rpx(20),
            child: TextWidget("负"),
          ),
        ]));
    List<TableRow> d = List.generate(
        spfs.length,
        (index) => TableRow(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: rpx(20),
                    child: TextWidget(spfs[index]["change_at"].toString()),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: rpx(20),
                    child: TextWidget(spfs[index]["win"]),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: rpx(20),
                    child: TextWidget(spfs[index]["draw"]),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: rpx(20),
                    child: TextWidget(spfs[index]["loss"]),
                  ),
                ]));
    if (d.isNotEmpty) {
      c.addAll(d);
    }
    return c;
  }

  List<TableRow> getrqTabRow() {
    List<TableRow> c = [];
    c.add(TableRow(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 245, 245, 245),
        ),
        children: [
          Container(
            alignment: Alignment.center,
            height: rpx(20),
            child: TextWidget("发布时间"),
          ),
          Container(
            alignment: Alignment.center,
            height: rpx(20),
            child: TextWidget("让"),
          ),
          Container(
            alignment: Alignment.center,
            height: rpx(20),
            child: TextWidget("胜"),
          ),
          Container(
            alignment: Alignment.center,
            height: rpx(20),
            child: TextWidget("平"),
          ),
          Container(
            alignment: Alignment.center,
            height: rpx(20),
            child: TextWidget("负"),
          ),
        ]));
    List<TableRow> d = List.generate(
        rq.length,
        (index) => TableRow(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: rpx(20),
                    child: TextWidget(rq[index]["change_at"].toString()),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: rpx(20),
                    child: TextWidget(rq[index]["handicap"].toString()),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: rpx(20),
                    child: TextWidget(rq[index]["win"]),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: rpx(20),
                    child: TextWidget(rq[index]["draw"]),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: rpx(20),
                    child: TextWidget(rq[index]["loss"]),
                  ),
                ]));
    if (d.isNotEmpty) {
      c.addAll(d);
    }
    return c;
  }
}
