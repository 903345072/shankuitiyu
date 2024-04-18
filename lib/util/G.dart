import 'package:fluro/fluro.dart';

import 'package:jingcai_app/api/API.dart';
import 'package:jingcai_app/api/initDio.dart';

class G {
  // Fluro路由

  static FluroRouter router = FluroRouter();
  static final API api = API(initDio());

  static parseQuery({required Map<String, dynamic> params}) {
    String query = "";
    if (params != null) {
      int index = 0;
      for (String key in params.keys) {
        final String value = Uri.encodeComponent(params[key].toString());

        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }

      return query.toString();
    }
  }
}
