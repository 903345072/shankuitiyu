import 'package:flutter/material.dart';
import 'package:jingcai_app/model/expert.dart';
import 'package:jingcai_app/util/rpx.dart';

class expertPreview extends StatefulWidget {
  expert expertModel;
  expertPreview({required this.expertModel});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return expertPreview_();
  }
}

class expertPreview_ extends State<expertPreview> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width * 0.25, // 屏幕宽度的50%,
      child: Stack(
        children: [
          Positioned(
            bottom: rpx(27),
            right: rpx(27),
            child: CircleAvatar(
              radius: rpx(20),
              backgroundImage: NetworkImage(
                widget.expertModel.avatar.toString(),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: rpx(10)),
            margin: EdgeInsets.only(top: rpx(24), bottom: 2),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: rpx(30)),
                  child: Container(
                    padding: EdgeInsets.all(1.5),
                    margin: EdgeInsets.only(top: 2, bottom: 2),
                    color: const Color(0xfffdeaea),
                    child: Text(
                      widget.expertModel.intro.toString(),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: rpx(10),
                        color: const Color(0xffef2f2f),
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.expertModel.name.toString(),
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: rpx(13), fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Positioned(
              right: rpx(24),
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
                  widget.expertModel.count.toString(),
                  style: TextStyle(color: Colors.white, fontSize: rpx(10)),
                ),
              ))
        ],
      ),
    );
  }
}
