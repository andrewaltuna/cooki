extension StringExtension on String {
  String toTitleCase() {
    final words = split(RegExp(r'[\s_]+'));

    final capitalizedWords = words.map((word) {
      if (word.isEmpty) return '';

      return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
    }).toList();

    return capitalizedWords.join(' ');
  }
}
