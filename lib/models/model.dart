import 'package:intl/intl.dart';

abstract class Model {
  Map<String, dynamic> toJson();

  DateTime? parseDateTimeIntl(String input, {String format = 'yyyy-MM-dd'}) {
    try {
      return DateFormat(format).parse(input);
    } catch (_) {
      return null;
    }
  }
}
