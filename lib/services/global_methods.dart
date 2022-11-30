import 'package:intl/intl.dart';

class GlobalMethods {
  static String formattedDateText(String publishedAt) {
    final parsedDate = DateTime.parse(publishedAt);
    String formattedDate = DateFormat("yyyy-MM-dd").format(parsedDate);
    DateTime publishedDate = DateFormat("yyyy-MM-dd").parse(formattedDate);

    return "${publishedDate.day}/${publishedDate.month}/${publishedDate.year}";
  }
}