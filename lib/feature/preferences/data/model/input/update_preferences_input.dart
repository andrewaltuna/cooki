import 'package:cooki/common/extension/enum_extension.dart';
import 'package:cooki/feature/preferences/data/enum/dietary_restriction.dart';
import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:equatable/equatable.dart';

class UpdatePreferencesInput extends Equatable {
  const UpdatePreferencesInput({
    this.productCategories,
    this.dietaryRestrictions,
  });

  final List<ProductCategory>? productCategories;
  final List<DietaryRestriction>? dietaryRestrictions;

  Map<String, dynamic> toJson() {
    return {
      'general': productCategories
          ?.map(
            (category) => category.apiValue,
          )
          .toList(),
      'dietary_restrictions': dietaryRestrictions
          ?.map(
            (restriction) => restriction.apiValue,
          )
          .toList(),
    };
  }

  @override
  List<Object?> get props => [
        productCategories,
        dietaryRestrictions,
      ];
}
