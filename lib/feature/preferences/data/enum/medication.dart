import 'package:cooki/common/extension/string_extension.dart';

enum Medication {
  warfarin,
  simvastatin,
  levothyroxine,
  metronidazole,
  phenelzine,
  lisinopril,
  alprazolam,
  ciprofloxacin,
  ibuprofen,
  metformin;

  String get displayLabel => name.toTitleCase();
}
