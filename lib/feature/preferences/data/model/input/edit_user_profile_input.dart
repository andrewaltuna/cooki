import 'package:cooki/feature/preferences/data/enum/dietary_restriction.dart';
import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:equatable/equatable.dart';

class EditUserProfileInput extends Equatable {
  const EditUserProfileInput({
    this.productCategories,
    this.dietaryRestrictions,
    this.hasSeenInitialPreferencesModal,
  });

  final List<ProductCategory>? productCategories;
  final List<DietaryRestriction>? dietaryRestrictions;
  final bool? hasSeenInitialPreferencesModal;

  Map<String, dynamic> toJson() {
    return {
      // TODO uncomment once set prefs api is implemented
      // 'preferences': {
      //   'productCategories': productCategories
      //       .map(
      //         (category) => category.apiValue,
      //       )
      //       .toList(),
      //   'dietaryRestrictions': dietaryRestrictions
      //       .map(
      //         (restriction) => restriction.apiValue,
      //       )
      //       .toList(),
      // },
      'hasSeenInitialPreferencesModal': hasSeenInitialPreferencesModal,
    };
  }

  @override
  List<Object?> get props => [
        productCategories,
        dietaryRestrictions,
        hasSeenInitialPreferencesModal,
      ];
}
