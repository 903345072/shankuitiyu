import 'package:flutter/material.dart';
import 'package:jingcai_app/model/footScreenModel.dart';
import 'package:jingcai_app/util/rpx.dart';

class allFoot extends StatefulWidget {
  List<AllMatch> all_list;
  Function setCount;
  allFoot({required this.all_list, required this.setCount});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _allFoot();
  }
}

class _allFoot extends State<allFoot> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        ListView(
          controller: _scrollController,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    widget.all_list.length,
                    (index) => Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 20,
                                child: Text(
                                    widget.all_list[index].initials.toString()),
                              ),
                              Container(
                                height: 10,
                              ),
                              Container(
                                child: Wrap(
                                  spacing: 3,
                                  runSpacing: 4,
                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.start,
                                  children: List.generate(
                                      widget.all_list[index].list!.length,
                                      (index1) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                widget
                                                    .all_list[index]
                                                    .list?[index1]
                                                    .checked = widget
                                                            .all_list[index]
                                                            .list?[index1]
                                                            .checked ==
                                                        1
                                                    ? 0
                                                    : 1;
                                              });
                                              widget.setCount(widget.all_list);
                                            },
                                            child: Container(
                                              alignment: Alignment(0, 0),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.29,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              rpx(5))),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      width: 1,
                                                      color: widget
                                                                  .all_list[
                                                                      index]
                                                                  .list?[index1]
                                                                  .checked ==
                                                              1
                                                          ? Colors.red
                                                          : Colors.grey)),
                                              child: Text(
                                                widget.all_list[index]
                                                    .list![index1].shortNameZh
                                                    .toString(),
                                                style: TextStyle(
                                                    color: widget
                                                                .all_list[index]
                                                                .list?[index1]
                                                                .checked ==
                                                            1
                                                        ? Colors.red
                                                        : Colors.grey,
                                                    fontSize: rpx(13)),
                                              ),
                                            ),
                                          )),
                                ),
                              ),
                              Container(
                                height: 10,
                              )
                            ],
                          ),
                        )),
              ),
            ),
            Container(
              height: rpx(80),
            ),
          ],
        ),
        Positioned(
            width: rpx(25),
            right: 0,
            top: 0,
            bottom: rpx(80),
            child: Container(
              color: const Color.fromARGB(255, 255, 145, 137),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Column(
                    children: List.generate(
                        indexWords.length,
                        (index) => GestureDetector(
                              onTap: () {
                                var item_count = 0;
                                var word_count = 0;
                                var word_height = 0.0;
                                var item_height = 0.0;
                                var item_space_height = 0.0;
                                var found = false;

                                for (var i = 0;
                                    i <= widget.all_list.length - 1;
                                    i++) {
                                  if (widget.all_list[i].initials ==
                                      indexWords[index]) {
                                    found = true;
                                    break;
                                  }
                                  item_count = widget.all_list[i].list!.length;
                                  item_height +=
                                      (item_count / 3).ceilToDouble() * 30;
                                  word_height += 40;
                                  item_space_height +=
                                      ((item_count / 3).ceilToDouble() - 1) * 4;
                                }
                                if (!found) {
                                  return;
                                }

                                var h = word_height +
                                    item_height +
                                    item_space_height;

                                _scrollController.jumpTo(h);
                              },
                              child: Text(
                                indexWords[index],
                                style: TextStyle(fontSize: rpx(14)),
                              ),
                            )),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

const indexWords = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
