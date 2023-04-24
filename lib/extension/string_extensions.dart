extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension Extension on Object? {
  String toEmptyStringIfNull() {
    if (this == null) {
      return '';
    } else if (this == 'null' || this == "null") {
      return '';
    } else if (this is num) {
      return toString();
    } else if (this is String) {
      return toString();
    } else {
      return '';
    }
  }
}