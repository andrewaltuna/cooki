import 'package:cooki/feature/product/data/model/product.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_helper.dart';
import 'package:equatable/equatable.dart';

class NearbySectionsDetails extends Equatable {
  const NearbySectionsDetails({
    required this.sections,
    required this.products,
  });

  factory NearbySectionsDetails.fromJson(Map<String, dynamic> json) {
    final sections = json['section'] as List;
    final products = json['products'] as List;

    return NearbySectionsDetails(
      sections: sections
          .map((section) => ShoppingListHelper.formatSectionLabel(section))
          .toList(),
      products: products.map((product) => Product.fromJson(product)).toList(),
    );
  }

  static const empty = NearbySectionsDetails(
    sections: [],
    products: [],
  );

  final List<String> sections;
  final List<Product> products;

  bool get isEmpty => this == NearbySectionsDetails.empty;
  bool get isNotEmpty => !isEmpty;

  @override
  List<Object?> get props => [
        sections,
        products,
      ];
}
