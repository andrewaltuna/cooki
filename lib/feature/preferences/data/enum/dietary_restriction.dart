import 'package:cooki/common/component/app_icons.dart';
import 'package:flutter_svg/svg.dart';

enum DietaryRestriction {
  eggFree('Egg-free'),
  glutenFree('Gluten-free'),
  halal('Halal'),
  nutFree('Nut-free'),
  soyFree('Soy-free'),
  vegan('Vegan');

  const DietaryRestriction(
    this.displayLabel,
  );

  final String displayLabel;

  SvgPicture get icon {
    return switch (this) {
      vegan => AppIcons.vegan,
      halal => AppIcons.halal,
      glutenFree => AppIcons.glutenFree,
      soyFree => AppIcons.soyFree,
      nutFree => AppIcons.nutFree,
      eggFree => AppIcons.eggFree,
    };
  }
}
