import 'dart:io';

import 'package:dio/dio.dart';

import 'package:jingcai_app/model/userModel.dart';
import 'package:http_parser/http_parser.dart';

class userApi {
  Dio dio_;
  userApi(this.dio_);

  Future<userModel> getUserIfno(Map<String, dynamic> p) async {
    Response res = await dio_.get("/api/user/userInfo", queryParameters: p);
    dynamic d = userModel.fromJson(res.data["data"]);
    return d;
  }

  Future getUserBattleRecord(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/api/user/getUserBattleRecord", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getPlans(Map<String, dynamic> p) async {
    Response res = await dio_.get("/api/user/getPlanList", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future setAvatar(Map<String, dynamic> m) async {
    var option = Options(
      headers: {"Content-Type": "multipart/form-data"},
    );
    FormData formData = FormData.fromMap(m);

    if (m["path"] != null) {
      formData.files.add(MapEntry(
        "talent_img", //后台接收的名字
        MultipartFile.fromFileSync(m["path"],
            filename: 'flied.jpg', contentType: MediaType('image', 'jpg')),
      ));
    }
    Response res =
        await dio_.post("/api/user/setAvatar", data: formData, options: option);
    return res.data["data"];
  }

  Future setName(Map<String, dynamic> p) async {
    Response res = await dio_.post("/api/user/editName", data: p);

    return res.data["data"];
  }

  Future sendCode(Map<String, dynamic> p) async {
    Response res = await dio_.post("/common/index/sendCode", data: p);

    return res.data["data"];
  }

  Future login(Map<String, dynamic> p) async {
    Response res = await dio_.post("/common/index/userLogin", data: p);

    return res.data;
  }

  Future editPhone(Map<String, dynamic> p) async {
    Response res = await dio_.post("/api/user/editPhone", data: p);

    return res.data["data"];
  }

  Future editPass(Map<String, dynamic> p) async {
    Response res = await dio_.post("/api/user/editPass", data: p);

    return res.data["data"];
  }

  Future editAliNo(Map<String, dynamic> p) async {
    Response res = await dio_.post("/api/user/editAliNo", data: p);

    return res.data["msg"];
  }

  Future cancelUser(Map<String, dynamic> p) async {
    Response res = await dio_.post("/api/user/cancelUser", data: p);

    return res.data["msg"];
  }

  Future iosNotify(Map<String, dynamic> p) async {
    Response res = await dio_.post("/api/user/iosNotify", data: p);

    return res.data["msg"];
  }

  Future iosRecharge(Map<String, dynamic> p) async {
    Response res = await dio_.post("/api/user/iosRecharge", data: p);

    return res.data["data"];
  }

  Future realName(Map<String, dynamic> p) async {
    Response res = await dio_.post("/api/user/RealNameAuthentication", data: p);

    return res.data["data"];
  }

  Future editBank(Map<String, dynamic> p) async {
    Response res = await dio_.post("/api/user/editBank", data: p);

    return res.data["msg"];
  }

  Future doWithdraw(Map<String, dynamic> p) async {
    Response res = await dio_.post("/api/user/doWithdraw", data: p);

    return res.data["msg"];
  }

  Future getWithdrawList(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/api/user/getWithdrawList", queryParameters: p);

    return res.data["data"];
  }

  Future getTalentSearchRecord(Map<String, dynamic> p) async {
    Response res = await dio_.post("/api/user/getTalentSearchRecord", data: p);

    return res.data["data"];
  }

  Future searchTalent(Map<String, dynamic> p) async {
    Response res = await dio_.get("/api/user/searchTalent", queryParameters: p);
    dynamic d = res.data["data"];

    return d;
  }

  Future getKefuUrl(Map<String, dynamic> p) async {
    Response res = await dio_.get("/api/user/getKefuUrl", queryParameters: p);
    dynamic d = res.data["data"];

    return d;
  }

  Future getIsBuy(Map<String, dynamic> p) async {
    Response res = await dio_.get("/api/user/getIsBuy", queryParameters: p);
    dynamic d = res.data["data"];

    return d;
  }

  Future getUserTxInfo(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/api/user/getUserTxInfo", queryParameters: p);
    dynamic d = res.data["data"];

    return d;
  }

  Future getUserYhq(Map<String, dynamic> p) async {
    Response res = await dio_.get("/api/user/getUserYhq", queryParameters: p);
    dynamic d = res.data["data"];

    return d;
  }

  Future getWidrawInfo(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/api/user/getWidrawInfo", queryParameters: p);
    dynamic d = res.data["data"];

    return d;
  }

  Future getBillList(Map<String, dynamic> p) async {
    Response res = await dio_.get("/api/user/getBillList", queryParameters: p);
    dynamic d = res.data["data"];

    return d;
  }

  Future openBag(Map<String, dynamic> p) async {
    Response res = await dio_.get("/api/user/openBag", queryParameters: p);
    dynamic d = res.data;

    return d;
  }

  Future getInviteRecord(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/api/user/getInviteRecord", queryParameters: p);
    dynamic d = res.data["data"];

    return d;
  }

  Future getAllIsBuy(Map<String, dynamic> p) async {
    Response res = await dio_.get("/api/user/getAllIsBuy", queryParameters: p);
    List d = res.data["data"];

    return d;
  }

  Future getSettingState(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/api/user/getSettingState", queryParameters: p);
    Map d = res.data["data"];
    return d;
  }

  Future settingState(Map<String, dynamic> p) async {
    Response res = await dio_.get("/api/user/settingState", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getSharePic(Map<String, dynamic> p) async {
    Response res = await dio_.get("/api/user/getSharePic", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getgzh(Map<String, dynamic> p) async {
    Response res = await dio_.get("/api/user/getgzh", queryParameters: p);
    dynamic d = res.data["data"];

    return d;
  }

  Future flowUser(Map<String, dynamic> p) async {
    Response res = await dio_.get("/api/user/flowTalent", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getPlanDetail(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/api/user/getPlanDetail", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getNoticeList(Map<String, dynamic> p) async {
    Response res =
        await dio_.get("/api/user/getNoticeList", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future submitFeedBack(Map<String, dynamic> m) async {
    var option = Options(
      headers: {"Content-Type": "multipart/form-data"},
    );
    FormData formData = FormData.fromMap(m);
    List<File> imgs = m["img"];
    imgs.forEach((element) {
      formData.files.add(MapEntry(
        "feedback[]", //后台接收的名字
        MultipartFile.fromFileSync(element.path,
            filename: 'flied.jpg', contentType: MediaType('image', 'jpg')),
      ));
    });
    Response res = await dio_.post("/api/user/submitFeedBack",
        data: formData, options: option);

    return res.data["msg"];
  }
}
