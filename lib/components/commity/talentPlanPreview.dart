import 'package:flutter/material.dart';
import 'package:jingcai_app/model/talentModel.dart';
import 'package:jingcai_app/util/rpx.dart';

class talentPlanPreview extends StatefulWidget {
  Datum data;
  talentPlanPreview({required this.data});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _talentPlanPreview();
  }
}

class _talentPlanPreview extends State<talentPlanPreview> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1, color: Color.fromARGB(255, 231, 231, 231)))),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Wrap(
        runSpacing: 5,
        spacing: 5,
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        direction: Axis.vertical,
        children: [
          Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            children: [
              CircleAvatar(
                radius: rpx(20),
                backgroundImage: NetworkImage(
                  widget.data.baseInfo!.userImg.toString(),
                ),
              ),
              Wrap(
                direction: Axis.vertical,
                spacing: 3,
                children: [
                  Text(widget.data.baseInfo!.userName.toString()),
                  Container(
                    padding: EdgeInsets.all(2.5),
                    color: const Color(0xfffdeaea),
                    child: Text(
                      "近10中" + widget.data.baseInfo!.mingzhongRate.toString(),
                      style: TextStyle(
                          fontSize: rpx(10), color: const Color(0xffef2f2f)),
                    ),
                  )
                ],
              )
            ],
          ),
          Container(
            width: rpx(350),
            child: Text(
              widget.data.baseInfo!.title.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: rpx(14), fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 14, right: 12, top: 2, bottom: 2),
            height: rpx(30),
            color: Color(0xfff0f0f0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: rpx(280),
                  child: Text(
                    widget.data.zucaiTuijianMatch![0].competitionName
                            .toString() +
                        "" +
                        widget.data.zucaiTuijianMatch![0].matchFutureTime
                            .toString() +
                        "" +
                        widget.data.zucaiTuijianMatch![0].issueNum.toString() +
                        "" +
                        widget.data.zucaiTuijianMatch![0].homeTeamName
                            .toString() +
                        "" +
                        widget.data.zucaiTuijianMatch![0].awayTeamName
                            .toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: rpx(13),
                    ),
                  ),
                ),
                getClassify(widget.data.baseInfo)
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: rpx(15),
                  children: [
                    Text(
                      widget.data.baseInfo!.createdAt.toString() + "发布",
                      style: TextStyle(
                          color: Color(0xff6f6f6f), fontSize: rpx(12)),
                    ),
                    Wrap(
                      spacing: 3,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(widget.data.baseInfo!.click.toString().toString(),
                            style: TextStyle(
                                color: Color(0xff6f6f6f), fontSize: rpx(12))),
                        Text("查看",
                            style: TextStyle(
                                color: Color(0xff6f6f6f), fontSize: rpx(12)))
                      ],
                    )
                  ],
                ),
                widget.data.baseInfo!.isFree == 0
                    ? Wrap(
                        spacing: 3,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text("免费", style: TextStyle(color: Colors.blue))
                        ],
                      )
                    : Wrap(
                        spacing: 3,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                              (widget.data.baseInfo!.sf! / 100)
                                  .toInt()
                                  .toString(),
                              style: TextStyle(color: Colors.red)),
                          Text("金豆", style: TextStyle(color: Colors.red)),
                        ],
                      )
              ],
            ),
          )
        ],
      ),
    );
  }

  getClassify(BaseInfo? e) {
    Color back_grond = Color.fromRGBO(239, 47, 47, .1);
    Color border_color = Color(0xffef2f2f);
    Color text_color = Color(0xffef2f2f);
    var id = e!.classfly;
    if (id == 1) {
      back_grond = Color.fromRGBO(239, 47, 47, .1);
      border_color = Color(0xffef2f2f);
      text_color = Color(0xffef2f2f);
    }
    if (id == 2) {
      back_grond = Color.fromRGBO(0, 40, 104, .1);
      border_color = Color(0xff002868);
      text_color = Color(0xff002868);
    }

    if (id == 3) {
      back_grond = Color.fromRGBO(48, 178, 122, .1);
      border_color = Color(0xff30b27a);
      text_color = Color(0xff30b27a);
    }
    return Container(
      height: rpx(20),
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 3, right: 3),
      decoration: BoxDecoration(
          color: back_grond,
          border: Border.all(color: border_color, width: rpx(1))),
      child: Text(
        e.classflyDesc.toString(),
        style: TextStyle(color: text_color, fontSize: rpx(11)),
      ),
    );
  }
}
