import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jingcai_app/components/jcFootPlanWidget.dart';
import 'package:jingcai_app/components/publishPlanFactory.dart';
import 'package:jingcai_app/model/jcFootMetModel.dart';
import 'package:jingcai_app/model/jcFootModel.dart';

import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

import 'gameTitle.dart';

class jcFootPublishPlanFactory implements publishPlanFactory {
  @override
  Widget PlanGameDetail(
      JcFootModel f, int index, Function delete, Function change) {
    // TODO: implement PlanGameDetail
    return jcFootPlanWidget(
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
    return jcGameTitle(
      footModel_: f,
    );
  }

  @override
  Future<JcFootMetModel> setGamePl(JcFootModel f) async {
    String jsonData = await rootBundle.loadString("assets/mock/jcFoot.json");
    JcFootMetModel jfm = JcFootMetModel.fromJson(json.decode(jsonData));
    List<jcPl>? spfpl = f.jc!.spfPl;
    List<jcPl>? rqpl = f.jc!.rqPl;

    if (spfpl!.isNotEmpty) {
      jfm.spf!.forEach((key, v) {
        if (key == "1-1") {
          v.pl = spfpl[spfpl.length - 1].win;
        }
        if (key == "1-2") {
          v.pl = spfpl[spfpl.length - 1].draw;
        }
        if (key == "1-3") {
          v.pl = spfpl[spfpl.length - 1].loss;
        }
      });
    }

    if (rqpl!.isNotEmpty) {
      jfm.rqNum = rqpl[rqpl.length - 1].handicap.toString();
      jfm.rq!.forEach((key, v) {
        if (key == "2-1") {
          v.pl = rqpl[rqpl.length - 1].win;
        }
        if (key == "2-2") {
          v.pl = rqpl[rqpl.length - 1].draw;
        }
        if (key == "2-3") {
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
      Map<String, Rq> spf = element.jcFootMetModel_!.spf!;
      Map<String, Rq> rq = element.jcFootMetModel_!.rq!;
      List<Rq> spfs = spf.values.toList();
      List<Rq> rqs = rq.values.toList();
      return spfs.where((element1) => element1.check == true).isNotEmpty ||
          rqs.where((element2) => element2.check == true).isNotEmpty;
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
                  f.jc!.matchNumStr.toString() +
                  " " +
                  f.leagues!.nameShort.toString() +
                  " " +
                  f.homeTeam!.nameShort.toString() +
                  "VS" +
                  f.awayTeam!.nameShort.toString(),
              fontSize: rpx(14),
            ),
          ),
          Icon(Icons.arrow_right_outlined)
        ],
      ),
    );
  }
}
