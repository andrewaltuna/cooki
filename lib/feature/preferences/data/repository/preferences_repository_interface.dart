import 'package:cooki/feature/preferences/data/model/input/update_preferences_input.dart';
import 'package:cooki/feature/preferences/data/model/output/preferences_output.dart';

abstract interface class PreferencesRepositoryInterface {
  Future<PreferencesOutput> getPreferences();

  Future<PreferencesOutput> updatePreferences(
    UpdatePreferencesInput input,
  );
}
