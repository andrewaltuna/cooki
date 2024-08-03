part of 'interfered_restrictions_view_model.dart';

class InterferedRestrictionsState extends Equatable {
  const InterferedRestrictionsState({
    this.status = ViewModelStatus.initial,
    this.productId = '',
    this.medications = const [],
    this.dietaryRestrictions = const [],
    this.alternativeProducts = const [],
    this.error,
  });

  final ViewModelStatus status;
  final String productId;
  final List<Medication> medications;
  final List<DietaryRestriction> dietaryRestrictions;
  final List<Product> alternativeProducts;
  final Exception? error;

  InterferedRestrictionsState copyWith({
    ViewModelStatus? status,
    String? productId,
    List<Medication>? medications,
    List<DietaryRestriction>? dietaryRestrictions,
    List<Product>? alternativeProducts,
    Exception? error,
  }) {
    return InterferedRestrictionsState(
      status: status ?? this.status,
      productId: productId ?? this.productId,
      medications: medications ?? this.medications,
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
      alternativeProducts: alternativeProducts ?? this.alternativeProducts,
      error: error ?? this.error,
    );
  }

  bool get isLoading => status.isInitial || status.isLoading;

  @override
  List<Object> get props => [
        status,
        productId,
        medications,
        dietaryRestrictions,
        alternativeProducts,
      ];
}
