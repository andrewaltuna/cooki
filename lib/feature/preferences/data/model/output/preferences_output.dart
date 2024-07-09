import 'package:cooki/common/extension/enum_extension.dart';
import 'package:cooki/feature/preferences/data/enum/dietary_restriction.dart';
import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:equatable/equatable.dart';

class PreferencesOutput extends Equatable {
  const PreferencesOutput({
    required this.productCategories,
    required this.dietaryRestrictions,
  });

  factory PreferencesOutput.fromJson(Map<String, dynamic> json) {
    return PreferencesOutput(
      productCategories: json['general']
          .map(
            (restriction) => ProductCategory.values.firstWhere(
              (element) => element.apiValue == restriction,
              orElse: () => ProductCategory.values.first,
            ),
          )
          .toList(),
      dietaryRestrictions: json['dietary_restrictions']
          .map(
            (restriction) => DietaryRestriction.values.firstWhere(
              (element) => element.apiValue == restriction,
              orElse: () => DietaryRestriction.values.first,
            ),
          )
          .toList(),
    );
  }

  final List<ProductCategory> productCategories;
  final List<DietaryRestriction> dietaryRestrictions;

  @override
  List<Object?> get props => [
        productCategories,
        dietaryRestrictions,
      ];
}
