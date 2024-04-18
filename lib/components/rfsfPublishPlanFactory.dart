import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jingcai_app/components/publishPlanFactory.dart';
import 'package:jingcai_app/components/rqFootPlanWidget.dart';

import 'package:jingcai_app/model/jcFootMetModel.dart';
import 'package:jingcai_app/model/jcFootModel.dart';

import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

import 'gameTitle.dart';
import 'rfsfFootPlanWidget.dart';

class rfsfPublishPlanFactory implements publishPlanFactory {
  @override
  Widget PlanGameDetail(
      JcFootModel f, int index, Function delete, Function change) {
    // TODO: implement PlanGameDetail
    return rfsfFootPlanWidget(
      j: f,
      index: index,
      deleteGame: (int id) {
        delete(id);
      },
      changeGame: (int id) {
        change(id);
      },
    );
  }

  @override
  Widget PlanGameTitle(JcFootModel f) {
    // TODO: implement PlanGameTitle
    return rqGameTitle(
      footModel_: f,
    );
  }

  @override
  Future<JcFootMetModel> setGamePl(JcFootModel f) async {
    String jsonData = await rootBundle.loadString("assets/mock/jcFoot.json");
    JcFootMetModel jfm = JcFootMetModel.fromJson(json.decode(jsonData));
    List<RqPl>? rqpl = f.rqPl;
    if (rqpl!.isNotEmpty) {
      jfm.rqNum = rqpl[rqpl.length - 1].handicap.toString();
      jfm.rfsf!.forEach((key, v) {
        if (key == "1-1") {
          v.pl = rqpl[rqpl.length - 1].win;
        }
        if (key == "1-2") {
          v.pl = rqpl[rqpl.length - 1].loss;
        }
      });
    }
    return jfm;
  }

  @override
  List<JcFootModel> getValidCheckList(List<JcFootModel> list) {
    // TODO: implement getValidCheckList
    return list.where((element) {
      Map<String, Rq> footrq = element.jcFootMetModel_!.rfsf!;
      List<Rq> footrqs = footrq.values.toList();
      return footrqs.where((element1) => element1.check == true).isNotEmpty;
    }).toList();
  }

  @override
  Widget PlanGameContent(JcFootModel f) {
    // TODO: implement PlanGameContent
    return Container(
      padding: EdgeInsets.symmetric(vertical: rpx(5), horizontal: rpx(5)),
      color: Color(0xfff0f0f0),
      child: Row(
        children: [
          Container(
            width: rpx(300),
            alignment: Alignment.centerLeft,
            child: TextWidget(
              f.startAt.toString().substring(5, 10) +
                  " " +
                  f.leagues!.nameShort.toString() +
                  " " +
                  f.awayTeam!.nameShort.toString() +
                  "VS" +
                  f.homeTeam!.nameShort.toString(),
              fontSize: rpx(14),
            ),
          ),
          Icon(Icons.arrow_right_outlined)
        ],
      ),
    );
  }
}
