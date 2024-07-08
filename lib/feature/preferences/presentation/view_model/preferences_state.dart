part of 'preferences_view_model.dart';

class PreferencesState extends Equatable {
  const PreferencesState({
    this.status = ViewModelStatus.initial,
    this.productCategories = const [],
    this.dietaryRestrictions = const [],
  });

  final ViewModelStatus status;
  final List<ProductCategory> productCategories;
  final List<DietaryRestriction> dietaryRestrictions;

  PreferencesState copyWith({
    ViewModelStatus? status,
    List<ProductCategory>? productCategories,
    List<DietaryRestriction>? dietaryRestrictions,
  }) {
    return PreferencesState(
      status: status ?? this.status,
      productCategories: productCategories ?? this.productCategories,
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
    );
  }

  @override
  List<Object> get props => [
        status,
        productCategories,
        dietaryRestrictions,
      ];
}
