import 'package:cooki/common/extension/enum_extension.dart';
import 'package:cooki/feature/preferences/data/enum/dietary_restriction.dart';
import 'package:cooki/feature/preferences/data/enum/medication.dart';
import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:equatable/equatable.dart';

class PreferencesOutput extends Equatable {
  const PreferencesOutput({
    required this.productCategories,
    required this.dietaryRestrictions,
    required this.promoNotifications,
    required this.medications,
  });

  factory PreferencesOutput.fromJson(Map<String, dynamic> json) {
    final productCategories = json['productCategories'] as List;
    final dietaryRestrictions = json['dietaryRestrictions'] as List;
    final medications = json['medications'] as List;
    final promoNotifications = json['promoNotifications'] as bool;

    return PreferencesOutput(
      productCategories: productCategories
          .map(
            (category) => ProductCategory.values.firstWhere(
              (element) => element.apiValue == category['categoryName'],
              orElse: () => ProductCategory.values.first,
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
      medications: medications
          .map(
            (medication) => Medication.values.firstWhere(
              (element) => element.apiValue == medication['genericName'],
              orElse: () => Medication.values.first,
            ),
          )
          .toList(),
      promoNotifications: promoNotifications,
    );
  }

  final List<ProductCategory> productCategories;
  final List<DietaryRestriction> dietaryRestrictions;
  final List<Medication> medications;
  final bool promoNotifications;

  @override
  List<Object?> get props => [
        productCategories,
        dietaryRestrictions,
        medications,
        promoNotifications,
      ];
}
