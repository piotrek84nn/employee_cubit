import 'package:intl/intl.dart';

extension FormattedDate on DateTime {
  static final _ddMMyyyyFormatter = DateFormat('dd.MM.yyyy');

  String get ddMMYYYY => _ddMMyyyyFormatter.format(toLocalOverridable());
}

bool dateTimeOverrideToLocal = false;

extension DateLocal on DateTime {
  DateTime toLocalOverridable() => dateTimeOverrideToLocal ? this : toLocal();
}
