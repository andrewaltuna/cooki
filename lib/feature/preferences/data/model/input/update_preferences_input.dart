import 'package:cooki/common/extension/enum_extension.dart';
import 'package:cooki/feature/preferences/data/enum/dietary_restriction.dart';
import 'package:cooki/feature/preferences/data/enum/medication.dart';
import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:equatable/equatable.dart';

class UpdatePreferencesInput extends Equatable {
  const UpdatePreferencesInput({
    required this.productCategories,
    required this.dietaryRestrictions,
    required this.medications,
    required this.promoNotifications,
  });

  final Set<ProductCategory> productCategories;
  final Set<DietaryRestriction> dietaryRestrictions;
  final Set<Medication> medications;
  final bool promoNotifications;

  Map<String, dynamic> toJson() {
    return {
      'productCategories': productCategories
          .map(
            (category) => {
              'categoryName': category.apiValue,
            },
          )
          .toList(),
      'dietaryRestrictions': dietaryRestrictions
          .map(
            (restriction) => {
              'restrictionName': restriction.apiValue,
            },
          )
          .toList(),
      'medications': medications
          .map(
            (medication) => {
              'genericName': medication.apiValue,
            },
          )
          .toList(),
      'promoNotifications': promoNotifications,
    };
  }

  @override
  List<Object?> get props => [
        productCategories,
        dietaryRestrictions,
        medications,
        promoNotifications,
      ];
}
