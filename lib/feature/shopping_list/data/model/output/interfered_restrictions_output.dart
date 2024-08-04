import 'package:cooki/common/extension/enum_extension.dart';
import 'package:cooki/feature/preferences/data/enum/dietary_restriction.dart';
import 'package:cooki/feature/preferences/data/enum/medication.dart';
import 'package:cooki/feature/product/data/model/product.dart';
import 'package:equatable/equatable.dart';

class InterferedRestrictionsOutput extends Equatable {
  const InterferedRestrictionsOutput({
    required this.medications,
    required this.dietaryRestrictions,
    required this.alternativeProducts,
  });

  factory InterferedRestrictionsOutput.fromJson(
    Map<String, dynamic> json,
  ) {
    final medications = json['medications'] as List;
    final dietaryRestrictions = json['dietaryRestrictions'] as List;
    final alternatives = json['alternatives'] as List;

    return InterferedRestrictionsOutput(
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
      alternativeProducts: alternatives
          .map((alternative) => Product.fromJson(alternative))
          .toList(),
    );
  }

  static const empty = InterferedRestrictionsOutput(
    medications: [],
    dietaryRestrictions: [],
    alternativeProducts: [],
  );

  final List<Medication> medications;
  final List<DietaryRestriction> dietaryRestrictions;
  final List<Product> alternativeProducts;

  @override
  List<Object?> get props => [
        medications,
        dietaryRestrictions,
        alternativeProducts,
      ];
}
