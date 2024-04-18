import 'package:dio/dio.dart';

class payApi {
  Dio dio_;
  payApi(this.dio_);

  Future getPayList(Map<String, dynamic> p) async {
    Response res = await dio_.get("/api/pay/getPayList", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future payOrderWithHongBi(Map<String, dynamic> p) async {
    Response res = await dio_.post("/api/pay/payOrderWithHongBi", data: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future payDataModelWithHongBi(Map<String, dynamic> p) async {
    Response res = await dio_.post("/api/pay/payDataModelWithHongBi", data: p);
    dynamic d = res.data["data"];
    return d;
  }

  Future getPriceList(Map<String, dynamic> p) async {
    Response res = await dio_.get("/api/pay/getPriceList", queryParameters: p);
    dynamic d = res.data["data"];
    return d;
  }
}
