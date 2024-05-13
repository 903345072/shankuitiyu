import 'package:dio/dio.dart';
import 'package:jingcai_app/pages/botom_pages/widget/routes.dart';
import 'package:jingcai_app/pages/login/login.dart';
import 'package:jingcai_app/util/G.dart';

import 'package:jingcai_app/util/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio initDio() {
  BaseOptions _baseOptions = BaseOptions(
    baseUrl: "http://47.122.18.242:83",
  );
  Dio dio = Dio(_baseOptions);

  dio.interceptors.add(InterceptorsWrapper(
    onRequest:
        (RequestOptions options, RequestInterceptorHandler handler) async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("token");
      //  print(options.uri);
      options.headers["bear_token"] = token;
      Loading.show(options.uri, "玩命加载中");
      return handler.next(options);
    },
    onResponse: (
      Response<dynamic> response,
      ResponseInterceptorHandler handler,
    ) async {
      Loading.complete(response.requestOptions.uri);

      if (response.data["code"] == 502) {
        Routes.pushPage(login());
        return;
      }
      if (response.data['code'] != 200) {
        Loading.tip(response.requestOptions.uri, response.data['msg']);
      } else {
        // Loading.tip(response.requestOptions.uri, response.data['msg']);
      }

      return handler.next(response);
    },
    onError: (
      DioException e,
      ErrorInterceptorHandler handler,
    ) async {
      Loading.complete(e.requestOptions.uri);
      print("请求错误");
      return handler.next(e);
    },
  ));

  return dio;
}
