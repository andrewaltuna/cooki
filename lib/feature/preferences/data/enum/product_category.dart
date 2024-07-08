import 'package:cooki/common/component/app_icons.dart';
import 'package:flutter_svg/svg.dart';

enum ProductCategory {
  bakery('Bakery'),
  beverages('Beverages'),
  dairy('Dairy'),
  deli('Deli'),
  frozen('Frozen'),
  produce('Produce'),
  snacks('Snacks');

  const ProductCategory(
    this.displayLabel,
  );

  final String displayLabel;

  SvgPicture get icon {
    return switch (this) {
      produce => AppIcons.produce,
      deli => AppIcons.deli,
      dairy => AppIcons.dairy,
      snacks => AppIcons.snacks,
      beverages => AppIcons.beverages,
      bakery => AppIcons.bakery,
      frozen => AppIcons.frozen,
    };
  }
}
