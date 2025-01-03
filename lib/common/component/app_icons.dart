import 'dart:ui';

import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  const AppIcons._();

  static const _basePath = 'assets/icons';

  static const _prefsPath = '$_basePath/preferences';
  static const _chatPath = '$_basePath/chat';
  static const _certsPath = '$_basePath/certifications';

  // Product category
  static SvgPicture get frozen => SvgPicture.asset('$_prefsPath/frozen.svg');
  static SvgPicture get produce => SvgPicture.asset('$_prefsPath/produce.svg');
  static SvgPicture get snacks => SvgPicture.asset('$_prefsPath/snacks.svg');
  static SvgPicture get deli => SvgPicture.asset('$_prefsPath/deli.svg');
  static SvgPicture get bakery => SvgPicture.asset('$_prefsPath/bakery.svg');
  static SvgPicture get beverages =>
      SvgPicture.asset('$_prefsPath/beverages.svg');
  static SvgPicture get dairy => SvgPicture.asset('$_prefsPath/dairy.svg');

  // Dietary restrictions
  static SvgPicture get vegan => SvgPicture.asset('$_prefsPath/vegan.svg');
  static SvgPicture get halal => SvgPicture.asset('$_prefsPath/halal.svg');
  static SvgPicture get glutenFree =>
      SvgPicture.asset('$_prefsPath/gluten_free.svg');
  static SvgPicture get soyFree => SvgPicture.asset('$_prefsPath/soy_free.svg');
  static SvgPicture get nutFree => SvgPicture.asset('$_prefsPath/nut_free.svg');
  static SvgPicture get eggFree => SvgPicture.asset('$_prefsPath/egg_free.svg');

  // Chat presets
  static SvgPicture get activity => SvgPicture.asset('$_chatPath/activity.svg');
  static SvgPicture get ecoWarrior =>
      SvgPicture.asset('$_chatPath/eco_warrior.svg');
  static SvgPicture get recipeGenerator =>
      SvgPicture.asset('$_chatPath/recipe_generator.svg');
  static SvgPicture get specialOffers =>
      SvgPicture.asset('$_chatPath/special_offers.svg');

  // Certifications
  static SvgPicture get certifications =>
      SvgPicture.asset('$_certsPath/certifications.svg');
}

extension SvgPictureExtension on SvgPicture {
  SvgPicture copyWith({
    double? height,
    double? width,
    Color? color,
  }) {
    final assetName = (bytesLoader as SvgAssetLoader).assetName;

    return SvgPicture.asset(
      assetName,
      height: height,
      width: width,
      colorFilter: color == null
          ? colorFilter
          : ColorFilter.mode(
              color,
              BlendMode.srcIn,
            ),
    );
  }
}
