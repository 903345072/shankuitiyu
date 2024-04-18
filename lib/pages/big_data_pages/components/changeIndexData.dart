import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class changeIndexData extends StatelessWidget {
  Map initPl = {};
  Map curPl = {};
  Map first_change = {};
  Map max_change = {};
  int type = 0;
  double change_value = 0;
  changeIndexData(
      {required this.initPl,
      required this.change_value,
      required this.curPl,
      required this.first_change,
      required this.max_change,
      required this.type});

  List<Widget> getSpfIndexNoArrow(Map pl, int type_) {
    return [
      TextWidget(
        pl["win"],
        color: getIColor(pl["win_direct"], type_),
      ),
      TextWidget(
        pl["draw"],
        color: getIColor(pl["draw_direct"], type_),
      ),
      TextWidget(
        pl["loss"],
        color: getIColor(pl["loss_direct"], type_),
      )
    ];
  }

  List<Widget> getJqIndexNoArrow(Map pl, int type_) {
    var h = pl['handicap'];
    return [
      TextWidget(
        pl["dq"].toString(),
        color: getIColor(pl["dq_direct"], type_),
      ),
      TextWidget(
        "($h)",
        color: Colors.blue,
      ),
      TextWidget(
        pl["xq"].toString(),
        color: getIColor(pl["xq_direct"], type_),
      )
    ];
  }

  List<Widget> getRqIndexNoArrow(Map pl, int type_) {
    var h = pl['handicap'];
    return [
      TextWidget(
        pl["win"].toString(),
        color: getIColor(pl["win_direct"], type_),
      ),
      TextWidget(
        "($h)",
        color: Colors.blue,
      ),
      TextWidget(
        pl["loss"].toString(),
        color: getIColor(pl["loss_direct"], type_),
      )
    ];
  }

  getIColor(int d, int type) {
    Color c = Colors.black;
    if (type == 1) {
      return c;
    }

    if (d == 1) {
      c = Colors.red;
    }
    if (d == 2) {
      c = Colors.green;
    }
    return c;
  }

  List<Widget> getInitIndex(Map pl, String text, int type_) {
    var a = [1, 2, 3];
    var b = [4, 5, 6];
    var c = [7, 8, 9];
    if (a.contains(type)) {
      return [
        TextWidget(text),
        Wrap(
          spacing: rpx(5),
          children: getSpfIndexNoArrow(pl, type_),
        )
      ];
    }
    if (b.contains(type)) {
      var h = pl['handicap'];
      return [
        TextWidget(text),
        Wrap(
          spacing: rpx(5),
          children: getRqIndexNoArrow(pl, type_),
        )
      ];
    }
    if (c.contains(type)) {
      return [
        TextWidget(text),
        Wrap(
          spacing: rpx(5),
          children: getJqIndexNoArrow(pl, type_),
        )
      ];
    }
    return [TextWidget(text)];
  }

  Widget getSpfIndexWithArrow(pl, initpl_) {
    return Wrap(
      spacing: rpx(2),
      children: [
        Wrap(
          spacing: rpx(2),
          children: [
            TextWidget(
              pl["win"],
              color: getColor(
                  double.parse(pl["win"]) - double.parse(initpl_["win"])),
            ),
            getIcon(double.parse(pl["win"]) - double.parse(initpl_["win"]))
          ],
        ),
        Wrap(
          spacing: rpx(2),
          children: [
            TextWidget(
              pl["draw"],
              color: getColor(
                  double.parse(pl["draw"]) - double.parse(initpl_["draw"])),
            ),
            getIcon(double.parse(pl["draw"]) - double.parse(initpl_["draw"]))
          ],
        ),
        Wrap(
          spacing: rpx(2),
          children: [
            TextWidget(
              pl["loss"],
              color: getColor(
                  double.parse(pl["loss"]) - double.parse(initpl_["loss"])),
            ),
            getIcon(double.parse(pl["loss"]) - double.parse(initpl_["loss"]))
          ],
        )
      ],
    );
  }

  Widget getRqIndexWithArrow(pl, initpl_) {
    var h = pl["handicap"];
    return Wrap(
      spacing: rpx(2),
      children: [
        Wrap(
          spacing: rpx(2),
          children: [
            TextWidget(
              pl["win"],
              color: getColor(
                  double.parse(pl["win"]) - double.parse(initpl_["win"])),
            ),
            getIcon(double.parse(pl["win"]) - double.parse(initpl_["win"]))
          ],
        ),
        Wrap(
          spacing: rpx(2),
          children: [
            TextWidget(
              "($h)",
            )
          ],
        ),
        Wrap(
          spacing: rpx(2),
          children: [
            TextWidget(
              pl["loss"],
              color: getColor(
                  double.parse(pl["loss"]) - double.parse(initpl_["loss"])),
            ),
            getIcon(double.parse(pl["loss"]) - double.parse(initpl_["loss"]))
          ],
        )
      ],
    );
  }

  Widget getJqIndexWithArrow(pl, initpl_) {
    var h = pl["handicap"];
    return Wrap(
      spacing: rpx(2),
      children: [
        Wrap(
          spacing: rpx(2),
          children: [
            TextWidget(
              pl["dq"],
              color: getColor(
                  double.parse(pl["dq"]) - double.parse(initpl_["dq"])),
            ),
            getIcon(double.parse(pl["dq"]) - double.parse(initpl_["dq"]))
          ],
        ),
        Wrap(
          spacing: rpx(2),
          children: [
            TextWidget(
              "($h)",
            )
          ],
        ),
        Wrap(
          spacing: rpx(2),
          children: [
            TextWidget(
              pl["xq"],
              color: getColor(
                  double.parse(pl["xq"]) - double.parse(initpl_["xq"])),
            ),
            getIcon(double.parse(pl["xq"]) - double.parse(initpl_["xq"]))
          ],
        )
      ],
    );
  }

  Icon getIcon(double cha) {
    Icon c = Icon(
      Icons.trending_flat,
      size: rpx(16),
    );
    if (cha > 0) {
      c = Icon(Icons.arrow_upward, color: Colors.red, size: rpx(16));
    }
    if (cha < 0) {
      c = Icon(Icons.arrow_downward, color: Colors.green, size: rpx(16));
    }

    return c;
  }

  Color getColor(double cha) {
    Color c = Colors.black54;

    if (cha > 0) {
      c = Colors.red;
    }
    if (cha < 0) {
      c = Colors.green;
    }

    return c;
  }

  Widget GetChangeIndex() {
    var a = [1, 2, 3];
    var b = [4, 5, 6];
    var c = [7, 8, 9];

    if (a.contains(type)) {
      var desc = {1: "主胜", 2: "平局", 3: "客胜"};
      var index_s = {1: "win", 2: "draw", 3: "loss"};
      var first_dir = "降";
      var max_dir = "降";
      var index_ = index_s[type];
      var first_value = (change_value * 100);
      var max_value =
          (double.parse(max_change[index_]) - double.parse(initPl[index_])) *
              100 /
              double.parse(initPl[index_]);
      if (first_value > 0) {
        first_dir = "升";
      }
      if (max_value > 0) {
        max_dir = "升";
      }
      first_value = first_value.abs();
      max_value = max_value.abs();
      return Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              spacing: rpx(2),
              children: [
                TextWidget("首次异动"),
                getSpfIndexWithArrow(first_change, initPl)
              ],
            ),
            TextWidget(desc[type].toString() +
                "指数" +
                first_dir +
                first_value.toStringAsFixed(0) +
                "%")
          ],
        ),
        Container(
          height: rpx(10),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              spacing: rpx(5),
              children: [
                TextWidget("最大异动"),
                getSpfIndexWithArrow(max_change, initPl)
              ],
            ),
            TextWidget(desc[type].toString() +
                "指数" +
                max_dir +
                max_value.toStringAsFixed(0) +
                "%")
          ],
        )
      ]);
    }

    if (b.contains(type)) {
      var desc = {4: "让球主胜", 5: "让球", 6: "让球客胜"};
      var index_s = {4: "win", 5: "handicap", 6: "loss"};

      var first_dir = "降";
      var max_dir = "降";
      var index_ = index_s[type];
      var first_value = (change_value * 100);
      var max_value =
          (double.parse(max_change[index_]) - double.parse(initPl[index_])) *
              100 /
              double.parse(initPl[index_]);
      if (type == 5) {
        max_value =
            (double.parse(max_change[index_]) - double.parse(initPl[index_])) /
                0.25;
        first_value = first_value / 100;
      }

      if (first_value > 0) {
        first_dir = "升";
      }
      if (max_value > 0) {
        max_dir = "升";
      }
      first_value = first_value.abs();
      max_value = max_value.abs();
      String first_str = desc[type].toString() +
          "指数" +
          first_dir +
          first_value.toStringAsFixed(0) +
          "%";
      String max_str = desc[type].toString() +
          "指数" +
          max_dir +
          max_value.toStringAsFixed(0) +
          "%";
      if (type == 5) {
        first_str = "让球" + first_dir + first_value.toString() + "层级";
        max_str = "让球" + first_dir + max_value.toString() + "层级";
      }
      return Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              spacing: rpx(5),
              children: [
                TextWidget("首次异动"),
                getRqIndexWithArrow(first_change, initPl)
              ],
            ),
            TextWidget(first_str)
          ],
        ),
        Container(
          height: rpx(10),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              spacing: rpx(5),
              children: [
                TextWidget("最大异动"),
                getRqIndexWithArrow(max_change, initPl)
              ],
            ),
            TextWidget(max_str)
          ],
        )
      ]);
    }

    if (c.contains(type)) {
      var desc = {7: "大球", 8: "大小球", 9: "小球"};
      var index_s = {7: "dq", 8: "handicap", 9: "xq"};

      var first_dir = "降";
      var max_dir = "降";
      var index_ = index_s[type];
      var first_value = (change_value * 100);
      var max_value =
          (double.parse(max_change[index_]) - double.parse(initPl[index_])) *
              100 /
              double.parse(initPl[index_]);
      if (type == 8) {
        max_value =
            (double.parse(max_change[index_]) - double.parse(initPl[index_])) /
                0.25;
        first_value = first_value / 100;
      }
      if (first_value > 0) {
        first_dir = "升";
      }
      if (max_value > 0) {
        max_dir = "升";
      }

      first_value = first_value.abs();
      max_value = max_value.abs();
      String first_str = desc[type].toString() +
          "指数" +
          first_dir +
          first_value.toStringAsFixed(0) +
          "%";
      String max_str = desc[type].toString() +
          "指数" +
          max_dir +
          max_value.toStringAsFixed(0) +
          "%";
      if (type == 8) {
        first_str = "大小球" + first_dir + first_value.toStringAsFixed(0) + "层级";
        max_str = "大小球" + first_dir + max_value.toStringAsFixed(0) + "层级";
      }
      return Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              spacing: rpx(5),
              children: [
                TextWidget("首次异动"),
                getJqIndexWithArrow(first_change, initPl)
              ],
            ),
            TextWidget(first_str)
          ],
        ),
        Container(
          height: rpx(10),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              spacing: rpx(5),
              children: [
                TextWidget("最大异动"),
                getJqIndexWithArrow(max_change, initPl)
              ],
            ),
            TextWidget(max_str)
          ],
        )
      ]);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: rpx(10),
            ),
            Container(
              width: rpx(4),
              height: rpx(20),
              color: Colors.red,
            ),
            Container(
              width: rpx(5),
            ),
            TextWidget(
              "异动数据",
              fontSize: rpx(18),
              fontWeight: FontWeight.bold,
            )
          ],
        ),
        SizedBox(
          height: rpx(10),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: rpx(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: rpx(5),
                children: getInitIndex(initPl, "初指", 1),
              ),
              Wrap(
                spacing: rpx(5),
                children: getInitIndex(curPl, "即指", 2),
              )
            ],
          ),
        ),
        SizedBox(
          height: rpx(10),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: rpx(10)),
          child: GetChangeIndex(),
        ),
      ],
    );
  }
}
