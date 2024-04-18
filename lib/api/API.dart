import 'package:dio/dio.dart';
import 'package:jingcai_app/api/gameAddApi.dart';

import 'gameApi.dart';
import 'payApi.dart';
import 'planApi.dart';
import 'userApi.dart';

class API {
  Dio _dio;

  API(this._dio);

  gameApi get game => gameApi(_dio);
  userApi get user => userApi(_dio);
  payApi get pay => payApi(_dio);
  planApi get plan => planApi(_dio);
  gameAddApi get gameAdd => gameAddApi(_dio);
}
