import 'package:flutter/material.dart';
import 'package:jingcai_app/model/basketScreenModel.dart';

import 'package:jingcai_app/util/rpx.dart';

class hotBasket extends StatefulWidget {
  List<GetGuess> hot_list;
  Function setCount;
  hotBasket({required this.hot_list, required this.setCount});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _hotBasket();
  }
}

class _hotBasket extends State<hotBasket> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: rpx(11)),
      alignment: Alignment(0, -1),
      child: Wrap(
        spacing: rpx(3),
        runSpacing: rpx(4),
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        children: List.generate(
            widget.hot_list.length,
            (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.hot_list[index].checked =
                          widget.hot_list[index].checked == 1 ? 0 : 1;
                    });
                    widget.setCount(widget.hot_list);
                  },
                  child: Container(
                    alignment: Alignment(0, 0),
                    width: MediaQuery.of(context).size.width * 0.31,
                    height: rpx(35),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(rpx(5))),
                        color: Colors.white,
                        border: Border.all(
                            width: 1,
                            color: widget.hot_list[index].checked == 1
                                ? Colors.red
                                : Colors.grey)),
                    child: Text(
                      widget.hot_list[index].shortNameZh.toString(),
                      style: TextStyle(
                          color: widget.hot_list[index].checked == 1
                              ? Colors.red
                              : Colors.grey,
                          fontSize: rpx(13),
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                )),
      ),
    );
  }
}
