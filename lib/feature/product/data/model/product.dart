import 'package:cooki/common/extension/enum_extension.dart';
import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.category,
    required this.section,
    required this.brand,
    required this.keyIngredients,
    required this.description,
    required this.price,
    required this.unitSize,
    required this.manufacturer,
  });

  static const Product empty = Product(
    id: '',
    category: ProductCategory.produce,
    section: '',
    brand: '',
    keyIngredients: [],
    description: '',
    price: 0.0,
    unitSize: '',
    manufacturer: '',
  );

  factory Product.fromJson(Map<String, dynamic> json) {
    final productCategory = json['productCategory'] as dynamic;
    final keyIngredients = json['key_ingredients'] as List;

    return empty.copyWith(
      id: json['_id'] as String,
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
      manufacturer: json['manufacturer'] as String,
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
  final String manufacturer;

  Product copyWith({
    String? id,
    ProductCategory? category,
    String? section,
    String? brand,
    List<String>? keyIngredients,
    String? description,
    double? price,
    String? unitSize,
    String? manufacturer,
  }) {
    return Product(
      id: id ?? this.id,
      category: category ?? this.category,
      section: section ?? this.section,
      brand: brand ?? this.brand,
      keyIngredients: keyIngredients ?? this.keyIngredients,
      description: description ?? this.description,
      price: price ?? this.price,
      unitSize: unitSize ?? this.unitSize,
      manufacturer: manufacturer ?? this.manufacturer,
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
        unitSize,
        manufacturer,
      ];
}
