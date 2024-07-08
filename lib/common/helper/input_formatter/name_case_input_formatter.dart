import 'package:flutter/services.dart';

class NameCaseInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Get the new text
    final text = newValue.text;

    // Check if the text is empty
    if (text.isEmpty) {
      return newValue;
    }

    // Capitalize the first letter and lowercase the rest
    final newText = text[0].toUpperCase() + text.substring(1).toLowerCase();

    // Create a new TextEditingValue with the formatted text
    return newValue.copyWith(
      text: newText,
      selection: newValue.selection.copyWith(
        baseOffset: newText.length,
        extentOffset: newText.length,
      ),
    );
  }
}
