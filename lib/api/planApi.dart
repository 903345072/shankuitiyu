import 'package:dio/dio.dart';

import 'package:http_parser/http_parser.dart';
import 'package:jingcai_app/model/PlanModel.dart';

class planApi {
  Dio dio_;
  planApi(this.dio_);
  Future creatTalent(Map<String, dynamic> m) async {
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
    List<String> p1 = m["plan1"]["files"];
    p1.forEach((element) {
      formData.files.add(MapEntry(
        "plan1_imgs[]", //后台接收的名字
        MultipartFile.fromFileSync(element,
            filename: 'flied.jpg', contentType: MediaType('image', 'jpg')),
      ));
    });

    List<String> p2 = m["plan2"]["files"];

    p2!.forEach((element) {
      formData.files.add(MapEntry(
        "plan2_imgs[]", //后台接收的名字
        MultipartFile.fromFileSync(element,
            filename: 'flied.jpg', contentType: MediaType('image', 'jpg')),
      ));
    });
    Response res = await dio_.post("/common/game/creatTalent",
        data: formData, options: option);
    return res;
  }

  Future publishPlan(Map<String, dynamic> m) async {
    var option = Options(
      headers: {"Content-Type": "multipart/form-data"},
    );
    FormData formData = FormData.fromMap(m);

    List<String> p1 = m["plan1"]["files"];
    p1.forEach((element) {
      formData.files.add(MapEntry(
        "plan1_imgs[]", //后台接收的名字
        MultipartFile.fromFileSync(element,
            filename: 'flied.jpg', contentType: MediaType('image', 'jpg')),
      ));
    });
    Response res = await dio_.post("/api/plan/publishPlan",
        data: formData, options: option);
    return res.data["code"];
  }

  Future getUserPlan(Map<String, dynamic> m) async {
    Response res =
        await dio_.get("/common/game/getUserPlan", queryParameters: {});
    return res.data["data"];
  }

  Future getCheckState(Map<String, dynamic> m) async {
    Response res =
        await dio_.get("/common/game/getCheckState", queryParameters: {});
    return res.data["data"];
  }
}
