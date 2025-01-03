part of 'preferences_view_model.dart';

class PreferencesState extends Equatable {
  const PreferencesState({
    this.status = ViewModelStatus.initial,
    this.submissionStatus = ViewModelStatus.initial,
    this.productCategories = const [],
    this.dietaryRestrictions = const [],
    this.medications = const [],
    this.error,
  });

  final ViewModelStatus status;
  final ViewModelStatus submissionStatus;
  final List<ProductCategory> productCategories;
  final List<DietaryRestriction> dietaryRestrictions;
  final List<Medication> medications;
  final Exception? error;

  PreferencesState copyWith({
    ViewModelStatus? status,
    ViewModelStatus? submissionStatus,
    List<ProductCategory>? productCategories,
    List<DietaryRestriction>? dietaryRestrictions,
    List<Medication>? medications,
    Exception? error,
  }) {
    return PreferencesState(
      status: status ?? this.status,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      productCategories: productCategories ?? this.productCategories,
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
      medications: medications ?? this.medications,
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
        submissionStatus,
        productCategories,
        dietaryRestrictions,
        medications,
        error,
      ];
}
