import 'package:intl/intl.dart';

class DateFormatUtil {
  static String dateTimeFormatted(String dateTime) {
    return DateFormat('dd/MM/yyyy - HH:mm:ss').format(DateTime.parse(dateTime)).toString();
  }

  static String formatStringDateWhenNotStartedWithZero(String date) {
    if (date.length < 2) {
      return "0$date";
    } else {
      return date;
    }
  }

  static String getCurrentDateInyyyyMMdd() {
    return "${DateFormat('y').format(DateTime.now())}-${formatStringDateWhenNotStartedWithZero(DateFormat('M').format(DateTime.now()))}-${formatStringDateWhenNotStartedWithZero(DateFormat('d').format(DateTime.now()))}";
  }
}
