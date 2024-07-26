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

  factory Product.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return empty;
    }
    final productCategory = json['productCategory'] as dynamic;
    final keyIngredients = json['key_ingredients'] as List?;

    return empty.copyWith(
      id: json['_id'],
      category: ProductCategory.values.firstWhere(
        (element) => element.apiValue == productCategory,
        orElse: () => ProductCategory.values.first,
      ),
      section: json['section'],
      brand: json['brand'],
      keyIngredients:
          keyIngredients?.map((ingredient) => ingredient as String).toList(),
      description: json['description'],
      price: json['price'],
      unitSize: json['unitSize'],
      manufacturer: json['manufacturer'],
    );
  }

  final String id;
  final ProductCategory category;
  final String section;
  final String brand;
  final List<String> keyIngredients;
  final String description;
  final num price;
  final String unitSize;
  final String manufacturer;

  Product copyWith({
    String? id,
    ProductCategory? category,
    String? section,
    String? brand,
    List<String>? keyIngredients,
    String? description,
    num? price,
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
