extension EnumExtension on Enum {
  String get apiValue {
    final regex = RegExp(r'(?<=[a-z])[A-Z]');
    final formatted = name.replaceAllMapped(
      regex,
      (match) => '_${match.group(0)}',
    );

    return formatted.toUpperCase();
  }
}
