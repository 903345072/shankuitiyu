import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class gameHistoryTable extends StatelessWidget {
  List datas = [];
  gameHistoryTable({required this.datas});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        SizedBox(
          height: rpx(15),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: rpx(10)),
          child: Table(
            border: TableBorder(
                bottom: BorderSide(
                    width: 0.5,
                    color: const Color.fromARGB(255, 219, 219, 219))),
            children: getTabRow(),
          ),
        )
      ],
    );
  }

  List<TableRow> getTabRow() {
    List<TableRow> s = [];
    s.add(TableRow(
        decoration: BoxDecoration(
          color: Color(0xfffde6e6),
        ),
        children: [
          Container(
            alignment: Alignment.center,
            height: rpx(35),
            child: TextWidget(
              "日期/赛事",
              fontSize: rpx(13),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: rpx(35),
            child: TextWidget(
              "主队",
              fontSize: rpx(13),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: rpx(35),
            child: TextWidget(
              "比分",
              fontSize: rpx(13),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: rpx(35),
            child: TextWidget(
              "客队",
              fontSize: rpx(13),
            ),
          )
        ]));

    int index = 0;
    datas.forEach((element) {
      s.add(
        TableRow(
            decoration: BoxDecoration(
              color: index % 2 == 0 ? Colors.white : Color(0xfffde6e6),
            ),
            children: [
              Container(
                alignment: Alignment.center,
                height: rpx(45),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWidget(
                      element["start_at"],
                      fontSize: rpx(13),
                    ),
                    TextWidget(
                      element["league_name"],
                      fontSize: rpx(13),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: rpx(45),
                child: TextWidget(
                  element["home_name"],
                  fontSize: rpx(13),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: rpx(45),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWidget(
                      element["full_score"],
                      fontSize: rpx(13),
                    ),
                    TextWidget(
                      "(" + element['half_score'] + ")",
                      fontSize: rpx(13),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: rpx(45),
                child: TextWidget(
                  element["away_name"],
                  fontSize: rpx(13),
                ),
              )
            ]),
      );
      index++;
    });
    return s;
  }
}
