import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/product/data/model/product.dart';
import 'package:equatable/equatable.dart';

class ProductState extends Equatable {
  const ProductState({
    this.status = ViewModelStatus.initial,
    this.products = const [],
    this.error,
  });

  final ViewModelStatus status;
  final List<Product> products;
  final Exception? error;

  ProductState copyWith({
    ViewModelStatus? status,
    List<Product>? products,
    Product? selectedProduct,
    Exception? error,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      error: error ?? this.error,
    );
  }

  bool get isInitialLoading =>
      status == ViewModelStatus.initial ||
      (status == ViewModelStatus.loading && products.isEmpty);

  @override
  List<Object?> get props => [
        status,
        products,
        error,
      ];
}