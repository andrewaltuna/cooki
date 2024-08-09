part of 'preferences_view_model.dart';

sealed class PreferencesEvent extends Equatable {
  const PreferencesEvent();

  @override
  List<Object?> get props => [];
}

class PreferencesRequested extends PreferencesEvent {
  const PreferencesRequested();
}

class PreferencesProductCategorySelected extends PreferencesEvent {
  const PreferencesProductCategorySelected(this.category);

  final ProductCategory category;

  @override
  List<Object> get props => [category];
}

class PreferencesDietaryRestrictionSelected extends PreferencesEvent {
  const PreferencesDietaryRestrictionSelected(this.restriction);

  final DietaryRestriction restriction;

  @override
  List<Object> get props => [restriction];
}

class PreferencesMedicationAdded extends PreferencesEvent {
  const PreferencesMedicationAdded({
    required this.medication,
  });

  final Medication medication;

  @override
  List<Object> get props => [
        medication,
      ];
}

class PreferencesMedicationRemoved extends PreferencesEvent {
  const PreferencesMedicationRemoved(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}

class PreferencesSaved extends PreferencesEvent {
  const PreferencesSaved();
}
