part of 'preferences_view_model.dart';

class PreferencesState extends Equatable {
  const PreferencesState({
    this.status = ViewModelStatus.initial,
    this.productCategories = const [],
    this.dietaryRestrictions = const [],
    this.error,
  });

  final ViewModelStatus status;
  final List<ProductCategory> productCategories;
  final List<DietaryRestriction> dietaryRestrictions;
  final Exception? error;

  PreferencesState copyWith({
    ViewModelStatus? status,
    List<ProductCategory>? productCategories,
    List<DietaryRestriction>? dietaryRestrictions,
    Exception? error,
  }) {
    return PreferencesState(
      status: status ?? this.status,
      productCategories: productCategories ?? this.productCategories,
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
      error: error ?? this.error,
    );
  }

  bool get isInitialLoading =>
      status == ViewModelStatus.initial ||
      (status == ViewModelStatus.loading &&
          productCategories.isEmpty &&
          dietaryRestrictions.isEmpty);

  @override
  List<Object?> get props => [
        status,
        productCategories,
        dietaryRestrictions,
        error,
      ];
}
