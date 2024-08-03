part of 'interfered_restrictions_view_model.dart';

sealed class InterferedRestrictionsEvent extends Equatable {
  const InterferedRestrictionsEvent();

  @override
  List<Object> get props => [];
}

class InterferedRestrictionsRequested extends InterferedRestrictionsEvent {
  const InterferedRestrictionsRequested(this.productId);

  final String productId;

  @override
  List<Object> get props => [productId];
}
