import 'package:jingcai_app/components/scores/basketGame.dart';
import 'package:jingcai_app/components/scores/footGame.dart';
import 'package:jingcai_app/model/BasketModel.dart';
import 'package:jingcai_app/model/footModel.dart';
import 'package:jingcai_app/model/jcFootModel.dart';

import 'package:jingcai_app/pages/score_pages/dataSource.dart';

class dataSourceFactory {
  dataSource getFootDataSource(String url) {
    return dataSource(url, (dd) {
      return JcFootModel.fromJson(dd);
    }, (e) {
      return footGame(footListElement: e);
    });
  }

  dataSource getBasketDataSource(String url) {
    return dataSource(url, (dd) {
      return BasketModel.fromJson(dd);
    }, (e) {
      return basketGame(basketListElement: e);
    });
  }
}
