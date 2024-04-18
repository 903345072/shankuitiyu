import 'package:flutter/material.dart';
import 'package:jingcai_app/util/rpx.dart';

Set dict = Set();
bool loadingStatus = false;

class Loading {
  static dynamic ctx;

  static void show(uri, String text) {
    dict.add(uri);
    // 已有弹窗，则不再显示弹窗, dict.length >= 2 保证了有一个执行弹窗即可，
    if (loadingStatus == true || dict.length >= 2) {
      return;
    }
    loadingStatus = true; // 修改状态
    // 请求前显示弹窗
    showDialog(
      context: ctx,
      builder: (context) {
        return YmDialog(text);
      },
    );
  }

  static void tip(uri, String text,
      {IconData icon = Icons.warning, Color color = Colors.red}) async {
    dict.add(uri);
    // 已有弹窗，则不再显示弹窗, dict.length >= 2 保证了有一个执行弹窗即可，
    if (loadingStatus == true || dict.length >= 2) {
      return;
    }
    loadingStatus = true; // 修改状态
    // 请求前显示弹窗
    showDialog(
      context: ctx,
      builder: (context) {
        return tips(text, icon, color);
      },
    );
    await Future.delayed(Duration(seconds: 1));
    Loading.complete(uri);
  }

  static void complete(uri) {
    dict.remove(uri);

    // 完成后关闭loading窗口
    if (dict.length == 0 && loadingStatus == true) {
      loadingStatus = false; // 修改状态
      // 完成后关闭loading窗口

      Navigator.of(ctx, rootNavigator: true).pop();
    }
  }
}

class YmDialog extends Dialog {
  final String title;

  const YmDialog(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AbsorbPointer(
      child: Center(
        //创建透明层
        child: Material(
          type: MaterialType.transparency, //透明类型
          child: SizedBox(
            width: 120,
            height: 120,
            child: Container(
              decoration: ShapeDecoration(
                  color: Color.fromARGB(115, 61, 61, 61),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Text(
                      title,
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class tips extends Dialog {
  String title = "";
  IconData icon_ = Icons.warning;
  Color color_ = Colors.red;
  tips(this.title, this.icon_, this.color_, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AbsorbPointer(
      child: Center(
        //创建透明层
        child: Material(
          type: MaterialType.transparency, //透明类型
          child: SizedBox(
            width: 130,
            height: 130,
            child: Container(
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                  color: Color.fromARGB(115, 61, 61, 61),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon_,
                    color: color_,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Text(
                      title,
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
