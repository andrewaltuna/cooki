part of 'preferences_view_model.dart';

sealed class PreferencesEvent extends Equatable {
  const PreferencesEvent();

  @override
  List<Object?> get props => [];
}

/// Sets initial values based on user preferences
class PreferencesInitalized extends PreferencesEvent {
  const PreferencesInitalized(this.user);

  final UserOutput user;

  @override
  List<Object> get props => [user];
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
  const PreferencesSaved({
    this.hasSeenInitalPreferencesModal,
    this.isSkip = false,
  });

  final bool? hasSeenInitalPreferencesModal;
  final bool isSkip;

  @override
  List<Object?> get props => [
        hasSeenInitalPreferencesModal,
        isSkip,
      ];
}
