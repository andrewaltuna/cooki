import 'package:cooki/common/extension/enum_extension.dart';
import 'package:cooki/feature/preferences/data/enum/dietary_restriction.dart';
import 'package:cooki/feature/preferences/data/enum/medication.dart';
import 'package:cooki/feature/product/data/model/product.dart';
import 'package:equatable/equatable.dart';

class ShoppingListItem extends Equatable {
  const ShoppingListItem({
    required this.id,
    required this.label,
    required this.product,
    required this.quantity,
    required this.isChecked,
    required this.medications,
    required this.dietaryRestrictions,
  });

  static const ShoppingListItem empty = ShoppingListItem(
    id: '',
    label: '',
    product: Product.empty,
    quantity: 0,
    isChecked: false,
    medications: [],
    dietaryRestrictions: [],
  );

  factory ShoppingListItem.fromJson(Map<String, dynamic> json) {
    final output = empty.copyWith(
      id: json['_id'],
      label: json['label'],
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
      isChecked: json['isInCart'],
    );

    final interferedRestrictions = json['interferedRestrictions'];

    if (interferedRestrictions != null) {
      final medications = interferedRestrictions['medications'] as List;
      final dietaryRestrictions =
          interferedRestrictions['dietaryRestrictions'] as List;

      return output.copyWith(
        medications: medications
            .map(
              (medication) => Medication.values.firstWhere(
                (element) => element.apiValue == medication['genericName'],
                orElse: () => Medication.values.first,
              ),
            )
            .toList(),
        dietaryRestrictions: dietaryRestrictions
            .map(
              (restriction) => DietaryRestriction.values.firstWhere(
                (element) => element.apiValue == restriction['restrictionName'],
                orElse: () => DietaryRestriction.values.first,
              ),
            )
            .toList(),
      );
    }

    return output;
  }

  final String id;
  final String label;
  final Product product;
  final int quantity;
  final bool isChecked;
  final List<Medication> medications;
  final List<DietaryRestriction> dietaryRestrictions;

  ShoppingListItem copyWith({
    String? id,
    String? label,
    Product? product,
    int? quantity,
    bool? isChecked,
    List<Medication>? medications,
    List<DietaryRestriction>? dietaryRestrictions,
  }) {
    return ShoppingListItem(
      id: id ?? this.id,
      label: label ?? this.label,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      isChecked: isChecked ?? this.isChecked,
      medications: medications ?? this.medications,
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
    );
  }

  @override
  List<Object?> get props => [
        id,
        label,
        product,
        quantity,
        isChecked,
        medications,
        dietaryRestrictions,
      ];
}
