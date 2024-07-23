import 'dart:math';

import 'package:cooki/common/extension/enum_extension.dart';
import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:equatable/equatable.dart';

class ProductOutput extends Equatable {
  const ProductOutput({
    required this.id,
    required this.category,
    required this.section,
    required this.brand,
    required this.keyIngredients,
    required this.description,
    required this.price,
    required this.unitSize,
  });

  static const ProductOutput empty = ProductOutput(
    id: '',
    category: ProductCategory.produce,
    section: '',
    brand: '',
    keyIngredients: [],
    description: '',
    price: 0.0,
    unitSize: '',
  );

  factory ProductOutput.fromJson(Map<String, dynamic> json) {
    final productCategory = json['category'] as dynamic;
    final keyIngredients = json['keyIngredients'] as List;

    return empty.copyWith(
      id: json['id'] as String,
      category: ProductCategory.values.firstWhere(
        (element) => element.apiValue == productCategory,
        orElse: () => ProductCategory.values.first,
      ),
      section: json['section'] as String,
      brand: json['brand'] as String,
      keyIngredients:
          keyIngredients.map((ingredient) => ingredient as String).toList(),
      description: json['description'] as String,
      price: json['price'] as double,
      unitSize: json['unitSize'] as String,
    );
  }

  final String id;
  final ProductCategory category;
  final String section;
  final String brand;
  final List<String> keyIngredients;
  final String description;
  final double price;
  final String unitSize;

  ProductOutput copyWith({
    String? id,
    ProductCategory? category,
    String? section,
    String? brand,
    List<String>? keyIngredients,
    String? description,
    double? price,
    String? unitSize,
  }) {
    return ProductOutput(
      id: id ?? this.id,
      category: category ?? this.category,
      section: section ?? this.section,
      brand: brand ?? this.brand,
      keyIngredients: keyIngredients ?? this.keyIngredients,
      description: description ?? this.description,
      price: price ?? this.price,
      unitSize: unitSize ?? this.unitSize,
    );
  }

  @override
  List<Object?> get props => [
        id,
        category,
        section,
        brand,
        keyIngredients,
        description,
        price,
        unitSize
      ];
}
