import 'package:intl/intl.dart';

class UIFormatter {
  static String formatDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }
}
