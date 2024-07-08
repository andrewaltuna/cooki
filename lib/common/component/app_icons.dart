import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  const AppIcons._();

  static const _basePath = 'assets/icons';

  static const _prefsPath = '$_basePath/preferences';

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
}
