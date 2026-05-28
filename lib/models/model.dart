import 'package:intl/intl.dart';

abstract class Model {
  Map<String, dynamic> toJson();

  Model fromJson(Map<String, dynamic> json);

  DateTime? parseDateTime(String input, {String format = 'yyyy-MM-dd'}) {
    try {
      return DateFormat(format).parse(input);
    } catch (_) {
      return null;
    }
  }

  int? parseId(dynamic id) {
    var idConverted = int.tryParse(id.toString());

    if (idConverted != null) {
      return idConverted;
    } else {
      return null;
    }
  }
}
