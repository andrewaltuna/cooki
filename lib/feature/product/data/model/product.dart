import 'package:cooki/feature/chat/data/enum/certification.dart';
import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:cooki/feature/product/data/model/product_manufacturer.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_helper.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.category,
    required this.section,
    required this.brand,
    required this.name,
    required this.imageUrl,
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
    name: '',
    imageUrl: '',
    description: '',
    price: 0.0,
    unitSize: '',
    manufacturer: ProductManufacturer.empty,
  );

  factory Product.fromJson(Map<String, dynamic> json) {
    final productCategory = json['productCategory'] as String;

    return Product(
      id: json['_id'],
      category: ProductCategory.values.firstWhere(
        (element) => element.displayLabel == productCategory,
        orElse: () => ProductCategory.values.first,
      ),
      section: json['section'],
      brand: json['brand'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      price: json['price'],
      unitSize: json['unitSize'],
      manufacturer: ProductManufacturer.fromJson(json['manufacturer']),
    );
  }

  final String id;
  final ProductCategory category;
  final String section;
  final String brand;
  final String name;
  final String imageUrl;
  final String description;
  final num price;
  final String unitSize;
  final ProductManufacturer manufacturer;

  Product copyWith({
    String? id,
    ProductCategory? category,
    String? section,
    String? brand,
    String? name,
    String? imageUrl,
    String? description,
    num? price,
    String? unitSize,
    ProductManufacturer? manufacturer,
  }) {
    return Product(
      id: id ?? this.id,
      category: category ?? this.category,
      section: section ?? this.section,
      brand: brand ?? this.brand,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      price: price ?? this.price,
      unitSize: unitSize ?? this.unitSize,
      manufacturer: manufacturer ?? this.manufacturer,
    );
  }

  bool get isEmpty => this == Product.empty;
  bool get isNotEmpty => !isEmpty;

  List<Certification> get certifications => manufacturer.certifications;

  String get sectionLabel => ShoppingListHelper.formatSectionLabel(section);

  String get pricePerUnitLabel => '$unitSize / USD ${price.toStringAsFixed(2)}';

  @override
  List<Object?> get props => [
        id,
        category,
        section,
        brand,
        name,
        imageUrl,
        description,
        price,
        unitSize,
        manufacturer,
      ];
}
