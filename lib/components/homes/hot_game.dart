import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:jingcai_app/model/HotGameModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';

class HotGame extends StatefulWidget {
  List<List<HotGameModel>> data = [];
  HotGame({required this.data});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HotGame();
  }
}

class _HotGame extends State<HotGame> with TickerProviderStateMixin {
  late TabController _tabC = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Swiper(
      autoplay: false,
      loop: false,
      pagination: SwiperPagination(
        margin: EdgeInsets.only(bottom: 5),
        builder: DotSwiperPaginationBuilder(
          ///          设置指示器颜色
          color: Colors.grey,
          activeColor: Colors.red,
        ),
      ),
      itemBuilder: (BuildContext context, int index) {
        return GridView.count(
          padding: EdgeInsets.all(rpx(12)),
          physics: const NeverScrollableScrollPhysics(), // 设
          mainAxisSpacing: 7,
          crossAxisSpacing: 7,
          childAspectRatio: 3,
          crossAxisCount: 2,
          children: List.generate(
              widget.data[index].length,
              (index1) => GestureDetector(
                    onTap: () {
                      G.router.navigateTo(
                          context,
                          // ignore: prefer_interpolation_to_compose_strings
                          "/gameDetail" +
                              G.parseQuery(params: {
                                "id": widget.data[index][index1].id,
                                "is_detail": 1
                              }),
                          transition: TransitionType.inFromRight);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      color: Color(0xfff1f8ff),
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: rpx(8)),
                            child: Wrap(
                              runSpacing: 5,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: rpx(30),
                                      child: TextWidget(
                                        widget.data[index][index1].ls_name,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        widget.data[index][index1].date,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: rpx(13)),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: rpx(70),
                                      child: TextWidget(
                                        widget.data[index][index1].h_name,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: rpx(20),
                                      child: const TextWidget(
                                        "VS",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: rpx(70),
                                      child: TextWidget(
                                        widget.data[index][index1].a_name,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(3),
                                color: Color(0xfffdeaea),
                                child: Text(
                                  widget.data[index][index1].count.toString() +
                                      "方案",
                                  style: TextStyle(
                                      color: Color(0xffef2f2f),
                                      fontSize: rpx(11)),
                                ),
                              ))
                        ],
                      ),
                    ),
                  )),
        );
      },
      itemCount: widget.data.length,
    );
  }
}
