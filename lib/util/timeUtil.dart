import 'package:date_format/date_format.dart';

class TimeUtils {
  static String formatDateTime(int? timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp! * 1000);
    var formatter = formatDate(date,
        [yyyy, '-', mm, '-', dd, ' ', HH, ':', mm]); //'yyyy-MM-dd HH:mm:ss'
    return formatter;
  }
}
