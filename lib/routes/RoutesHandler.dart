import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/model/PlanModel.dart';
import 'package:jingcai_app/pages/big_data_pages/companyDiff.dart';
import 'package:jingcai_app/pages/big_data_pages/competitionList.dart';
import 'package:jingcai_app/pages/big_data_pages/components/boSongDetail.dart';
import 'package:jingcai_app/pages/big_data_pages/components/boSongDistribute.dart';
import 'package:jingcai_app/pages/big_data_pages/components/companyDiffDetail.dart';
import 'package:jingcai_app/pages/big_data_pages/components/indexChangeDetail.dart';
import 'package:jingcai_app/pages/big_data_pages/components/indexDiffDetail.dart';
import 'package:jingcai_app/pages/big_data_pages/components/leagueDetail.dart';
import 'package:jingcai_app/pages/big_data_pages/components/teamDetail.dart';
import 'package:jingcai_app/pages/big_data_pages/dataReport.dart';
import 'package:jingcai_app/pages/big_data_pages/gameBigData.dart';
import 'package:jingcai_app/pages/big_data_pages/indexChange.dart';
import 'package:jingcai_app/pages/big_data_pages/indexDiff.dart';
import 'package:jingcai_app/pages/botom_pages/my/page/ApplicationInfluencerPage.dart';
import 'package:jingcai_app/pages/botom_pages/my/page/SubmitExpertInformationPage.dart';
import 'package:jingcai_app/pages/botom_pages/my/page/publish.dart';
import 'package:jingcai_app/pages/botom_pages/my/page/publishPlan.dart';
import 'package:jingcai_app/pages/botom_pages/my/page/realName.dart';
import 'package:jingcai_app/pages/botom_pages/my/page/withdraw.dart';
import 'package:jingcai_app/pages/commity_pages/expertTalent.dart';
import 'package:jingcai_app/pages/commity_pages/talentRank.dart';
import 'package:jingcai_app/pages/home_pages/BasketGameDetail.dart';
import 'package:jingcai_app/pages/home_pages/basketSubject.dart';
import 'package:jingcai_app/pages/home_pages/expertDetail.dart';
import 'package:jingcai_app/pages/home_pages/gameDetail.dart';
import 'package:jingcai_app/pages/home_pages/gameSearch.dart';
import 'package:jingcai_app/pages/home_pages/hotMatchPage.dart';
import 'package:jingcai_app/pages/home_pages/talentDetail.dart';
import 'package:jingcai_app/pages/home_pages/talentSearch.dart';
import 'package:jingcai_app/pages/login/login.dart';
import 'package:jingcai_app/pages/score_pages/basketScreen.dart';
import 'package:jingcai_app/pages/score_pages/footScreen.dart';

var footScreenHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return footScreen(
    date_: params["date"]!.first.toString(),
  );
});
var basketScreenHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return basketScreen(
    date_: params["date"]!.first.toString(),
  );
});

var expertTalentHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return expertTalent(
    index: int.parse(params["index"]!.first),
    is_flow: int.parse(params["is_flow"]!.first),
  );
});
var talentRankHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return talentRank(
    index: int.parse(params["index"]!.first),
  );
});

var competitionListHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return competitionList(
    id: int.parse(params["id"]!.first),
    name: params["name"]!.first,
  );
});

var basketSubjectHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return basketSubject();
});

var expertDetailHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return expertDetail(
    id: int.parse(params["id"]!.first),
  );
});

var gameDetailHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return gameDetail(
    id: int.parse(params["id"]!.first),
    is_detail: int.parse(params["is_detail"]!.first),
  );
});
var basketGameDetailHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return BasketGameDetail(
    id: int.parse(params["id"]!.first),
    is_detail: int.parse(params["is_detail"]!.first),
  );
});
var publishHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return publish(type: params["type"]!.first);
});
var applyTalentHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ApplicationInfluencerPage();
});

var subTalentHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return SubmitExpertInformationPage();
});

var dataReportHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return dataReport(
    price: params["price"]!.first,
    buy_count: int.parse(params["buy_count"]!.first),
  );
});

var gameBigDatatHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return gameBigData(
    id: int.parse(params["id"]!.first),
  );
});

var indexChangeHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return indexChange(
    price: params["price"]!.first,
    buy_count: int.parse(params["buy_count"]!.first),
  );
});

var indexChangeDetailHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return indexChangeDetail(
    id: int.parse(params["id"]!.first),
  );
});
var bsfbHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return boSongDistribute(
    price: params["price"]!.first,
    buy_count: int.parse(params["buy_count"]!.first),
  );
});
var boSongDetailHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return boSongDetail(
    id: int.parse(params["id"]!.first),
  );
});
var indexDiffHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return indexDiff(
    price: params["price"]!.first,
    buy_count: int.parse(params["buy_count"]!.first),
  );
});

var indexDiffDetailHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return indexDiffDetail(
    id: int.parse(params["id"]!.first),
  );
});

var companyDiffHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return companyDiff(
    price: params["price"]!.first,
    buy_count: int.parse(params["buy_count"]!.first),
  );
});
var companyDiffDetailHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return companyDiffDetail(
    id: int.parse(params["id"]!.first),
  );
});
var leagueDetailHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return leagueDetail(
    id: int.parse(params["id"]!.first),
    logo: params["logo"]!.first,
    name: params["name"]!.first,
  );
});

var teamDetailHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return teamDetail(
    id: int.parse(params["id"]!.first),
    logo: params["logo"]!.first,
    name: params["name"]!.first,
  );
});

var gameSearchHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return gameSearch(
    type: int.parse(params["type"]!.first),
  );
});

var talentSearchHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return talentSearch();
});

var hotMatchhHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return hotMatchPage(
    id: int.parse(params["id"]!.first),
    type: int.parse(params["type"]!.first),
    name: params["name"]!.first,
  );
});

var publishPlanHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return publishPlan();
});

var talentDetailHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return talentDetail(
    uid: int.parse(params["uid"]!.first),
  );
});
var loginHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return login();
});
var withdrawHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return withdraw();
});
var realNameHand = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return realName();
});
