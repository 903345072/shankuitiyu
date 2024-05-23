import 'package:dio/dio.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/model/jcFootPlModel.dart';
import 'package:jingcai_app/model/expert.dart';

class gameApi {
  Dio dio_;
  gameApi(this.dio_);
  Future<List<JcFootModel>> getJcFootList(Map<String, dynamic> q) async {
    Response res =
        await dio_.get("/common/game/getJcFootGameList", queryParameters: q);

    List d = res.data["data"];

    List<JcFootModel> data = d
        .map((e) => JcFootModel.fromJson((e as Map<String, dynamic>)))
        .toList();

    return data;
  }

  Future<List<JcFootModel>> getrQFootList({Map<String, dynamic>? q}) async {
    Response res =
        await dio_.get("/common/game/getrQFootList", queryParameters: q);

    List d = res.data["data"];

    List<JcFootModel> data = d
        .map((e) => JcFootModel.fromJson((e as Map<String, dynamic>)))
        .toList();

    return data;
  }

  Future<List<JcFootModel>> getBaketList(Map<String, String> q) async {
    Response res =
        await dio_.get("/common/game/getBaketList", queryParameters: q);

    List d = res.data["data"];

    List<JcFootModel> data = d
        .map((e) => JcFootModel.fromJson((e as Map<String, dynamic>)))
        .toList();

    return data;
  }

  Future getHotTalent(Map<String, String> q) async {
    Response res =
        await dio_.get("/common/home/getHotTalent", queryParameters: q);

    List d = res.data["data"];

    return d;
  }

  Future getAllTalent(Map<String, dynamic> q) async {
    Response res =
        await dio_.get("/common/home/getAllTalent", queryParameters: q);

    List d = res.data["data"];

    return d;
  }

  Future getBigDataGame({Map<String, dynamic>? q}) async {
    Response res =
        await dio_.get("/common/game/getBigDataGame", queryParameters: q);

    List act = res.data["data"]["act"];
    List exp = res.data["data"]["expect"];
    List<JcFootModel> act_data = act
        .map((e) => JcFootModel.fromJson((e as Map<String, dynamic>)))
        .toList();
    List<JcFootModel> expect = exp
        .map((e) => JcFootModel.fromJson((e as Map<String, dynamic>)))
        .toList();

    return {
      "act": act_data,
      "exp": expect,
      "offset": res.data["data"]["offset"]
    };
  }

  Future getBoSongData({Map<String, dynamic>? q}) async {
    Response res =
        await dio_.get("/common/indexData/getBoSongData", queryParameters: q);

    List d = res.data["data"];

    return d;
  }

  Future getDifferenceData({Map<String, dynamic>? q}) async {
    Response res = await dio_.get("/common/indexData/getDifferenceData",
        queryParameters: q);

    Map<String, dynamic> d = res.data["data"];

    return d;
  }

  Future getCompanyDifference({Map<String, dynamic>? q}) async {
    Response res = await dio_.get("/common/indexData/getCompanyDifference",
        queryParameters: q);

    Map<String, dynamic> d = res.data["data"];

    return d;
  }

  Future<JcFootPlModel> getJcFootPl(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/game/getJcFootPl", queryParameters: p);

    dynamic d = res.data["data"];

    JcFootPlModel data = JcFootPlModel.fromJson((d as Map<String, dynamic>));

    return data;
  }

  Future<Map> getMatchAnalyse(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/game/getMatchAnalyse", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getHistoryBattleRecord(Map<String, dynamic> p) async {
    Response res = await dio_.get("/common/game/getHistoryBattleRecord",
        queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getHistoryTeamRecorde(Map<String, dynamic> p) async {
    Response res = await dio_.get("/common/game/getHistoryTeamRecorde",
        queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getBigDataTargetStatistic(Map<String, dynamic> p) async {
    Response res = await dio_.get("/common/game/getBigDataTargetStatistic",
        queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getIndexChangeData(Map<String, dynamic> p) async {
    Response res = await dio_.get("/common/indexData/getIndexChangeData",
        queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getIndexChangeDetail(Map<String, dynamic> p) async {
    Response res = await dio_.get("/common/indexData/getIndexChangeDetail",
        queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getBoSongDetail(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/indexData/getBoSongDetail", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getResultChange(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/indexData/getResultChange", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getCompanyResultChange(Map<String, dynamic> p) async {
    Response res = await dio_.get("/common/indexData/getCompanyResultChange",
        queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getAllIndexData(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/indexData/getAllIndexData", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getTeamSeasonAnasy(Map<String, dynamic> p) async {
    Response res = await dio_.get("/common/indexData/getTeamSeasonAnasy",
        queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getHotGame(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/game/getHotGame", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getGameDetail(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/game/getGameDetail", queryParameters: p);

    dynamic d = res.data["data"];
    return d;
  }

  Future getBasketGameDetail(Map<String, dynamic> p) async {
    Response res = await dio_.get("/common/basket/getBasketGameDetail",
        queryParameters: p);

    dynamic d = res.data["data"];
    return d;
  }

  Future getLiving(Map<String, dynamic> p) async {
    Response res = await dio_.get("/common/game/getLiving", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getJcPlList(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/game/getJcPlList", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getbdPlList(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/game/getbdPlList", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getFootPl(Map<String, dynamic> p) async {
    Response res = await dio_.get("/common/game/getFootPl", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getBasketPl(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/basket/getBasketPl", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future<List<JcFootModel>> getSubject(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/basket/getSubject", queryParameters: p);
    List d = res.data["data"];

    List<JcFootModel> data = d
        .map((e) => JcFootModel.fromJson((e as Map<String, dynamic>)))
        .toList();

    return data;
  }

  Future getTalentList(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/basket/getTalentList", queryParameters: p);
    List d = res.data["data"];

    return d;
  }

  Future getObjectPlanList(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/basket/getObjectPlanList", queryParameters: p);
    List d = res.data["data"];

    return d;
  }

  Future getGamePlan(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/home/getGamePlan", queryParameters: p);
    Map d = res.data["data"];

    return d;
  }

  Future getFlowPlanList(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/home/getFlowPlanList", queryParameters: p);
    Map d = res.data["data"];

    return d;
  }

  Future getAiPlanList(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/home/getAiPlanList", queryParameters: p);
    List d = res.data["data"];

    return d;
  }

  Future AiRate(Map<String, dynamic> p) async {
    Response res = await dio_.get("/common/home/AiRate", queryParameters: p);
    Map d = res.data["data"];

    return d;
  }

  Future getUserBuyPlan(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/api/user/getUserBuyPlan", queryParameters: p);
    List d = res.data["data"];

    return d;
  }

  Future getMyPlan(Map<String, dynamic> p) async {
    Response res = await dio_.get("/api/user/getMyPlan", queryParameters: p);
    List d = res.data["data"];

    return d;
  }

  Future getUserBuyData(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/api/user/getUserBuyData", queryParameters: p);
    List d = res.data["data"];

    return d;
  }

  Future getTalentRank(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/home/getTalentRank", queryParameters: p);
    List d = res.data["data"];

    return d;
  }

  Future getTalentPlan(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/home/getTalentPlan", queryParameters: p);
    List d = res.data["data"];

    return d;
  }
}
