import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootMetModel.dart';
import 'package:jingcai_app/model/jcFootModel.dart';

abstract class publishPlanFactory {
  Widget PlanGameTitle(JcFootModel f);
  Widget PlanGameDetail(
      JcFootModel f, int index, Function delete, Function change);
  Future<JcFootMetModel> setGamePl(JcFootModel f);
  List<JcFootModel> getValidCheckList(List<JcFootModel> list);
  Widget PlanGameContent(JcFootModel f);
}
