import 'package:equatable/equatable.dart';

class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class ProductsRequested extends ProductEvent {
  const ProductsRequested();
}
