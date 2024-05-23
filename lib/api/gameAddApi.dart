import 'package:dio/dio.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/model/jcFootPlModel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class gameAddApi {
  Dio dio_;
  gameAddApi(this.dio_);

  Future getLineUp(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/gameAdd/getLineUp", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getHistoryData(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/gameAdd/getHistoryData", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getGen(Map<String, dynamic> p) async {
    Response res = await dio_.get("/common/gameAdd/getGen", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getBasketGen(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/gameAdd/getBasketGen", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getHotGame(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/gameAdd/getHotGame", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getStateCountry(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/gameAdd/getStateCountry", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getLeagueInfo(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/gameAdd/getLeagueInfo", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getRank(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/gameAdd/getRank", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getLeagueMatch(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/gameAdd/getLeagueMatch", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getLeagueSeaSons(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/gameAdd/getLeagueSeaSons", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getLeagueRounds(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/gameAdd/getLeagueRounds", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getPlayerRank(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/gameAdd/getPlayerRank", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getTeamRank(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/gameAdd/getTeamRank", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getTeamBaseInfo(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/gameAdd/getTeamBaseInfo", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getTeamSeasonAndRound(Map<String, dynamic> p) async {
    Response res = await dio_.get("/common/gameAdd/getTeamSeasonAndRound",
        queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getTeamScoreRank(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/gameAdd/getTeamScoreRank", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getTeamMatch(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/gameAdd/getTeamMatch", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getTeamLineUp(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/gameAdd/getTeamLineUp", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getTeamSeasonAndLeague(Map<String, dynamic> p) async {
    Response res = await dio_.get("/common/gameAdd/getTeamSeasonAndLeague",
        queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future collectMatch(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/score/collectMatch", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getModelList(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/score/getModelList", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getScoreList(Map<String, dynamic> p, String url) async {
    Response res = await dio_.get(url, queryParameters: p);

    List act = res.data["data"]["footAct"];

    List<JcFootModel> act_data = act
        .map((e) => JcFootModel.fromJson((e as Map<String, dynamic>)))
        .toList();

    return {"act": act_data, "offset": res.data["data"]["offset"]};
  }

  Future getFootLeagues(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/score/getFootLeagues", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getBasketLeagues(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/basket/getBasketLeagues", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future<List<JcFootModel>> searchFootGame(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/score/searchFootGame", queryParameters: p);
    List d = res.data["data"];
    List<JcFootModel> act_data = d
        .map((e) => JcFootModel.fromJson((e as Map<String, dynamic>)))
        .toList();
    return act_data;
  }

  Future<List<JcFootModel>> searchBasketGame(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/score/searchBasketGame", queryParameters: p);
    List d = res.data["data"];
    List<JcFootModel> act_data = d
        .map((e) => JcFootModel.fromJson((e as Map<String, dynamic>)))
        .toList();
    return act_data;
  }

  Future getGameSearchRecord(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/score/getGameSearchRecord", queryParameters: p);
    dynamic d = res.data["data"];

    return d;
  }

  Future getHotLeagues(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/score/getHotLeagues", queryParameters: p);
    dynamic d = res.data["data"];

    return d;
  }

  Future<List<JcFootModel>> getGamesByLeague(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/common/score/getGamesByLeague", queryParameters: p);
    List d = res.data["data"];
    List<JcFootModel> foot_data = d
        .map((e) => JcFootModel.fromJson((e as Map<String, dynamic>)))
        .toList();

    return foot_data;
  }
}
