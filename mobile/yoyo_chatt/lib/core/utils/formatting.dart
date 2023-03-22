import 'package:intl/intl.dart';

DateTime parseDateTime(String value) {
  return DateFormat("yyyy-MM-ddTHH:mm:ssZ").parseUTC(value).toLocal();
}

String utcToLocal(
  String value, {
  bool hasTime = true,
}) {
  try {
    DateTime parsed = parseDateTime(value);

    return hasTime
        ? DateFormat.yMd().add_jms().format(parsed)
        : DateFormat.yMd().format(parsed);
  } catch (_) {
    return 'Invalid DateTime';
  }
}
