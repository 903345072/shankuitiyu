import 'package:flutter/material.dart';
import 'package:jingcai_app/model/talentExpert.dart';
import 'package:jingcai_app/util/rpx.dart';

class expertExplain extends StatelessWidget {
  Map data;
  expertExplain({required this.data});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getExpert(data);
  }

  Widget getExpert(Map data) {
    // TODO: implement build
    return Stack(
      children: [
        Positioned(
            top: rpx(5),
            left: rpx(15),
            child: CircleAvatar(
              radius: rpx(20),
              backgroundImage: NetworkImage(
                data["avatar"].toString(),
              ),
            )),
        Container(
          margin: EdgeInsets.only(top: rpx(30)),
          width: rpx(75),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(1.5),
                margin: EdgeInsets.only(top: 2, bottom: 2),
                color: const Color(0xfffdeaea),
                child: Text(
                  data["lable"].toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: rpx(10), color: const Color(0xffef2f2f)),
                ),
              ),
              Container(
                child: Text(
                  data["real_name"].toString(),
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: rpx(11), fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        data["plan_num"] > 0
            ? Positioned(
                right: rpx(16),
                top: rpx(3),
                child: Container(
                  height: 16,
                  alignment: Alignment(0, 0),
                  padding: EdgeInsets.only(left: rpx(4), right: rpx(4)),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Text(
                    data["plan_num"].toString(),
                    style: TextStyle(color: Colors.white, fontSize: rpx(10)),
                  ),
                ))
            : Container()
      ],
    );
  }
}
