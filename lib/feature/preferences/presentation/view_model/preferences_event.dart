part of 'preferences_view_model.dart';

sealed class PreferencesEvent extends Equatable {
  const PreferencesEvent();

  @override
  List<Object?> get props => [];
}

/// Sets initial values based on user preferences
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

class PreferencesSaved extends PreferencesEvent {
  const PreferencesSaved();
}
