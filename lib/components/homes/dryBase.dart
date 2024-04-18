import 'package:flutter/material.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:jingcai_app/model/draymodel.dart';

class dryBase extends StatefulWidget {
  drayModel data;
  dryBase({super.key, required this.data});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dryBase_();
  }
}

class dryBase_ extends State<dryBase> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1, color: Color.fromARGB(255, 231, 231, 231)))),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: Wrap(
        direction: Axis.vertical,
        spacing: 15,
        children: [
          Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            children: [
              CircleAvatar(
                radius: rpx(20),
                backgroundImage: NetworkImage(
                  widget.data.user_avatar,
                ),
              ),
              Wrap(
                direction: Axis.vertical,
                spacing: 3,
                children: [
                  Text(
                    widget.data.nickname,
                    style: TextStyle(
                        fontSize: rpx(13), fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.all(2.5),
                    child: Text(
                      widget.data.date,
                      style: TextStyle(fontSize: rpx(12), color: Colors.grey),
                    ),
                  )
                ],
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(right: rpx(20)),
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                Wrap(
                  direction: Axis.vertical,
                  spacing: 15,
                  children: [
                    Container(
                      width: rpx(150),
                      child: Text(
                        widget.data.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: Color(0xff1b1b1b), fontSize: rpx(14)),
                      ),
                    ),
                    Text(
                      widget.data.count.toString() + "查看",
                      style: TextStyle(fontSize: rpx(11)),
                    )
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    widget.data.avatar,
                    width: rpx(120),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
