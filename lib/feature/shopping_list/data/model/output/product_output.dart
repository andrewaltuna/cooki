import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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
    return empty.copyWith(
      id: json['id'] as String,
      category: json['category'] as ProductCategory,
      section: json['section'] as String,
      brand: json['brand'] as String,
      keyIngredients: json['keyIngredients'] as List<String>,
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

  // TODO: Remove once query is placed
  static List<ProductOutput> getDummyProducts() {
    List<ProductOutput> dummyProducts = [];

    for (var i = 0; i < 10; i++) {
      dummyProducts.add(ProductOutput(
        id: 'dummy$i',
        category: ProductCategory.bakery,
        section: 'dummy_section$i',
        brand: 'dummy_brand$i',
        keyIngredients: ['dummy_ingredient$i', 'dummy_ingredient$i'],
        description: 'dummy description',
        price: 10.99,
        unitSize: 'dummy unit size',
      ));
    }

    return dummyProducts;
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
