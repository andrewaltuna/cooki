import 'package:equatable/equatable.dart';

class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class ProductsRequested extends ProductEvent {
  const ProductsRequested();
}

class ProductRequested extends ProductEvent {
  const ProductRequested(this.id);

  final String id;

  @override
  List<Object?> get props => [
        id,
      ];
}
