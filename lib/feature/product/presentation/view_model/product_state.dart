import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/product/data/model/product.dart';
import 'package:equatable/equatable.dart';

class ProductState extends Equatable {
  const ProductState({
    this.status = ViewModelStatus.initial,
    this.sections = const [],
    this.products = const [],
    this.error,
  });

  final ViewModelStatus status;
  final List<String> sections;
  final List<Product> products;
  final Exception? error;

  ProductState copyWith({
    ViewModelStatus? status,
    List<String>? sections,
    List<Product>? products,
    Exception? error,
  }) {
    return ProductState(
      status: status ?? this.status,
      sections: sections ?? this.sections,
      products: products ?? this.products,
      error: error ?? this.error,
    );
  }

  bool get isInitialLoading =>
      status == ViewModelStatus.initial ||
      (status == ViewModelStatus.loading && products.isEmpty);

  Product productById(String id) {
    return products.firstWhere(
      (element) => element.id == id,
      orElse: () => Product.empty,
    );
  }

  List<Product> productsBySection(String section) {
    return products
        .where(
          (product) => product.section.toLowerCase() == section.toLowerCase(),
        )
        .toList();
  }

  @override
  List<Object?> get props => [
        status,
        sections,
        products,
        error,
      ];
}
