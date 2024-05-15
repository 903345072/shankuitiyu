import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/loading.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'G.dart';

Widget netImg(String? src, double width, double height) {
  if (src != "null") {
    return src != null
        ? Image.network(
            src,
            width: width,
            height: height,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child, c) {
              if (c == null) {
                return child;
              } else {
                return Container(
                  width: width,
                  height: height,
                  child: Center(
                      child: CircularProgressIndicator(
                    value: c.expectedTotalBytes != null
                        ? c.cumulativeBytesLoaded /
                            (c.expectedTotalBytes as int)
                        : null,
                  )),
                );
              }
            },
          )
        : Container(
            width: width,
            height: height,
          );
  }
  return Container(
    width: width,
    height: height,
  );
}

Widget classHeader() {
  return ClassicHeader(
      completeText: "刷新成功", refreshingText: "刷新中", idleText: "下拉刷新");
}

Widget classFooter() {
  return CustomFooter(
    builder: (BuildContext context, LoadStatus? mode) {
      Widget body;
      if (mode == LoadStatus.idle) {
        body = Text("下拉刷新");
      } else if (mode == LoadStatus.loading) {
        body = CupertinoActivityIndicator();
      } else if (mode == LoadStatus.failed) {
        body = Text("加载失败");
      } else if (mode == LoadStatus.canLoading) {
        body = Text("释放加载更多");
      } else {
        body = Text("——————没有更多内容——————");
      }
      return Container(
        height: 55.0,
        child: Center(child: body),
      );
    },
  );
}

Color hexToColor(String? code) {
  //先判断是否符合#RRGGBB的要求如果不符合给一个默认颜色
  if (code == null || code == "" || code.length != 7) {
    return Color(0xFFFF0000); //定了一个默认的主题色常量
  }

  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

Widget getBasketGameStateText(JcFootModel foot,
    {double size = 0, bool is_white = false}) {
  Widget c = Container();

  switch (foot.statusId) {
    case 1:
      c = TextWidget(
        "未",
        fontSize: size != 0 ? size : rpx(13),
        color: is_white ? Colors.white : Colors.black,
      );
    case 10:
      c = TextWidget(
        "完",
        color: is_white ? Colors.white : Colors.red,
        fontSize: size != 0 ? size : rpx(13),
      );
    case 11:
      c = TextWidget(
        "中断",
        fontSize: size != 0 ? size : rpx(13),
        color: is_white ? Colors.white : Colors.black,
      );
    case 12:
      c = TextWidget(
        "暂停",
        fontSize: size != 0 ? size : rpx(13),
        color: is_white ? Colors.white : Colors.black,
      );
    case 13:
      c = TextWidget(
        "推迟",
        fontSize: size != 0 ? size : rpx(13),
        color: is_white ? Colors.white : Colors.black,
      );
    case 14:
      c = TextWidget(
        "取消",
        fontSize: size != 0 ? size : rpx(13),
        color: is_white ? Colors.white : Colors.black,
      );
    default:
      c = TextWidget(
        "未知",
        color: is_white ? Colors.white : Colors.red,
        fontSize: size != 0 ? size : rpx(13),
      );
  }

  var acting_ids = [2, 3, 4, 5, 6, 7];
  if (acting_ids.contains(foot.statusId)) {
    String str = "";
    if (foot.statusId == 2) {
      str = "第一节";
    }
    if (foot.statusId == 3) {
      str = "第二节";
    }
    if (foot.statusId == 4) {
      str = "中场休息";
    }
    if (foot.statusId == 5) {
      str = "第三节";
    }
    if (foot.statusId == 6) {
      str = "第四节";
    }
    if (foot.statusId == 7) {
      str = "加时赛";
    }
    var tt = foot.elapsed != null ? foot.elapsed + "'" : "";
    c = TextWidget(
      str + ' ' + tt,
      color: is_white ? Colors.white : Colors.green,
      fontSize: size != 0 ? size : rpx(13),
    );
  }
  return c;
}

Widget getFootGameStateText(int? id, dynamic time, {double size = 0}) {
  Widget c = Container();

  switch (id) {
    case 1:
      c = TextWidget(
        "未",
        fontSize: size != 0 ? size : rpx(13),
      );
    case 10:
      c = TextWidget(
        "完",
        color: Colors.red,
        fontSize: size != 0 ? size : rpx(13),
      );
    case 11:
      c = TextWidget(
        "中断",
        fontSize: size != 0 ? size : rpx(13),
      );
    case 12:
      c = TextWidget(
        "暂停",
        fontSize: size != 0 ? size : rpx(13),
      );
    case 13:
      c = TextWidget(
        "推迟",
        fontSize: size != 0 ? size : rpx(13),
      );
    case 14:
      c = TextWidget(
        "取消",
        fontSize: size != 0 ? size : rpx(13),
      );
    default:
      c = TextWidget(
        "未知",
        color: Colors.red,
        fontSize: size != 0 ? size : rpx(13),
      );
  }

  var acting_ids = [2, 3, 4, 5, 7];
  if (acting_ids.contains(id)) {
    c = TextWidget(
      time.toString() + "'",
      color: Colors.green,
      fontSize: size != 0 ? size : rpx(13),
    );
  }
  return c;
}

Widget getFootGameStateTextWhite(int? id, dynamic time, {double size = 0}) {
  Widget c = Container();

  switch (id) {
    case 1:
      c = TextWidget(
        "未",
        fontSize: size != 0 ? size : rpx(13),
        color: Colors.white,
      );
    case 10:
      c = TextWidget(
        "完",
        color: Colors.white,
        fontSize: size != 0 ? size : rpx(13),
      );
    case 11:
      c = TextWidget(
        "中断",
        fontSize: size != 0 ? size : rpx(13),
        color: Colors.white,
      );
    case 12:
      c = TextWidget(
        "暂停",
        fontSize: size != 0 ? size : rpx(13),
        color: Colors.white,
      );
    case 13:
      c = TextWidget(
        "推迟",
        fontSize: size != 0 ? size : rpx(13),
        color: Colors.white,
      );
    case 14:
      c = TextWidget(
        "取消",
        fontSize: size != 0 ? size : rpx(13),
        color: Colors.white,
      );
    default:
      c = TextWidget(
        "待定",
        color: Colors.white,
        fontSize: size != 0 ? size : rpx(13),
      );
  }

  var acting_ids = [2, 3, 4, 5, 7];
  if (acting_ids.contains(id)) {
    c = TextWidget(
      time.toString() + "'",
      color: Colors.white,
      fontSize: size != 0 ? size : rpx(13),
    );
  }
  return c;
}

getPlanState(int? wl) {
  var url = "";
  if (wl == 0) {
    return Container();
  }
  if (wl == 1) {
    url = "assets/images/hei.png";
  }
  if (wl == 2) {
    url = "assets/images/zou.png";
  }
  if (wl == 3) {
    url = "assets/images/hong.png";
  }
  if (wl == 4) {
    url = "assets/images/quxiao.png";
  }
  if (wl == 5) {
    url = "assets/images/game_late.png";
  }

  return Image.asset(
    url,
    width: rpx(40),
    fit: BoxFit.cover,
  );
}

tipSucess(String title) {
  Loading.tip("uri", title, icon: Icons.tips_and_updates, color: Colors.green);
}

Widget getFootGameScoreText(int? id, dynamic score, {double size = 0}) {
  Widget c = Container();
  if (score == null) {
    score = "";
  }
  switch (id) {
    case 1:
      c = TextWidget(
        "VS",
        fontWeight: FontWeight.bold,
        fontSize: size != 0 ? size : rpx(16),
        color: Colors.grey,
      );
    case 10:
      c = TextWidget(
        score,
        color: Colors.red,
        fontSize: size != 0 ? size : rpx(16),
        fontWeight: FontWeight.bold,
      );
    default:
      c = TextWidget(
        "VS",
        color: Colors.grey,
        fontSize: size != 0 ? size : rpx(16),
        fontWeight: FontWeight.bold,
      );
  }

  var acting_ids = [2, 3, 4, 5, 7];
  if (acting_ids.contains(id)) {
    c = TextWidget(
      score,
      color: Colors.green,
      fontSize: size != 0 ? size : rpx(16),
      fontWeight: FontWeight.bold,
    );
  }
  return c;
}

Widget getFootGameScoreTextWithWhite(int? id, dynamic score,
    {double size = 0}) {
  Widget c = Container();

  switch (id) {
    case 1:
      c = TextWidget(
        "VS",
        fontWeight: FontWeight.bold,
        fontSize: size != 0 ? size : rpx(16),
        color: Colors.white,
      );
    case 10:
      c = TextWidget(
        score,
        color: Colors.white,
        fontSize: size != 0 ? size : rpx(16),
        fontWeight: FontWeight.bold,
      );
    default:
      c = TextWidget(
        "VS",
        color: Colors.white,
        fontSize: size != 0 ? size : rpx(16),
        fontWeight: FontWeight.bold,
      );
  }

  var acting_ids = [2, 3, 4, 5, 7];
  if (acting_ids.contains(id)) {
    c = TextWidget(
      score,
      color: Colors.white,
      fontSize: size != 0 ? size : rpx(16),
      fontWeight: FontWeight.bold,
    );
  }
  return c;
}

Widget getBasketGameScoreTextWithWhite(int? id, dynamic score,
    {double size = 0, Color color = Colors.white}) {
  Widget c = Container();
  if (score != null) {
    List s = score.toString().split(":");
    score = s[1] + ":" + s[0];
  }
  switch (id) {
    case 1:
      c = TextWidget(
        "VS",
        fontWeight: FontWeight.bold,
        fontSize: size != 0 ? size : rpx(16),
        color: color,
      );
    case 10:
      c = TextWidget(
        score,
        color: color,
        fontSize: size != 0 ? size : rpx(16),
        fontWeight: FontWeight.bold,
      );
    default:
      c = TextWidget(
        "VS",
        color: color,
        fontSize: size != 0 ? size : rpx(16),
        fontWeight: FontWeight.bold,
      );
  }

  var acting_ids = [2, 3, 4, 5, 7, 6];
  if (acting_ids.contains(id)) {
    c = TextWidget(
      score,
      color: color,
      fontSize: size != 0 ? size : rpx(16),
      fontWeight: FontWeight.bold,
    );
  }
  return c;
}

getClassify(Map e) {
  Color back_grond = Color.fromRGBO(239, 47, 47, .1);
  Color border_color = Color(0xffef2f2f);
  Color text_color = Color(0xffef2f2f);
  var id = e["class_fy"];

  if (id == "竞足") {
    back_grond = Color.fromRGBO(239, 47, 47, .1);
    border_color = Color(0xffef2f2f);
    text_color = Color(0xffef2f2f);
  }
  if (id == "让球") {
    back_grond = Color.fromRGBO(0, 40, 104, .1);
    border_color = Color(0xff002868);
    text_color = Color(0xff002868);
  }

  if (id == "大小球") {
    back_grond = Color.fromRGBO(48, 178, 122, .1);
    border_color = Color(0xff30b27a);
    text_color = Color(0xff30b27a);
  }
  if (id == "总分") {
    back_grond = Color.fromRGBO(48, 178, 122, .1);
    border_color = Color.fromARGB(255, 165, 178, 48);
    text_color = Color.fromARGB(255, 165, 178, 48);
  }
  if (id == "让分") {
    back_grond = Color.fromRGBO(48, 178, 122, .1);
    border_color = Color.fromARGB(255, 178, 48, 156);
    text_color = Color.fromARGB(255, 178, 48, 156);
  }
  return Container(
    height: rpx(20),
    alignment: Alignment.center,
    padding: EdgeInsets.only(left: 3, right: 3),
    decoration: BoxDecoration(
        color: back_grond,
        border: Border.all(color: border_color, width: rpx(1))),
    child: Text(
      id.toString(),
      style: TextStyle(color: text_color, fontSize: rpx(11)),
    ),
  );
}

void showConfirmationDialog(BuildContext context, Function confirm,
    {String title = "你确定要执行这个操作吗？",
    String leftTxt = "取消",
    String rightTxt = "确定",
    bool close_ = false}) {
  // 设置对话框的标题、内容、以及操作按钮

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          height: rpx(130),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(rpx(10)),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextWidget(title),
              SizedBox(
                height: rpx(15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    child: TextWidget(leftTxt),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: TextWidget(
                      rightTxt,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      if (close_) {
                        G.router.pop(context);
                      }
                      confirm();
                      //  Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
