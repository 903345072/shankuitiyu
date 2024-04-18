import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/components/homes/expertPreview.dart';
import 'package:jingcai_app/model/expert.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';

class hotExpert extends StatefulWidget {
  List<expert> data = [];
  hotExpert({super.key, required this.data});

  @override
  State<StatefulWidget> createState() {
    return _hotExpert();
  }
}

class _hotExpert extends State<hotExpert> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      runSpacing: rpx(3),
      children: List.generate(
          widget.data.length,
          (index) => GestureDetector(
                onTap: () {
                  G.router.navigateTo(
                      context,
                      "/talentDetail" +
                          G.parseQuery(params: {"uid": widget.data[index].id}));
                },
                child: expertPreview(expertModel: widget.data[index]),
              )),
    );
  }
}
