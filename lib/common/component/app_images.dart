import 'package:flutter/material.dart';

class AppImages {
  const AppImages._();

  static const _basePath = 'assets/imgs';
  static const _certPath = '$_basePath/certifications';

  static Image get logo => Image.asset('$_basePath/logo.png');
  static Image get logoAlt => Image.asset('$_basePath/logo_alt.png');
  static Image get cooki => Image.asset('$_basePath/cooki.png');

  // Chat
  static Image get cookiChat => Image.asset('$_basePath/cooki_chat.png');

  // Map
  static Image get map => Image.asset('$_basePath/map.png');

  // Product Certifications
  static Image get bCorp => Image.asset('$_certPath/b_corp.png');
  static Image get ewg => Image.asset('$_certPath/ewg.png');
  static Image get fairTrade => Image.asset('$_certPath/fair_trade.png');
  static Image get fsc => Image.asset('$_certPath/fsc.png');
  static Image get gmoFree => Image.asset('$_certPath/gmo_free.png');
  static Image get locallyGrown => Image.asset('$_certPath/locally_grown.png');
  static Image get msc => Image.asset('$_certPath/msc.png');
  static Image get plantBased => Image.asset('$_certPath/plant_based.png');
  static Image get rainforestAlliance =>
      Image.asset('$_certPath/rainforest_alliance.png');
  static Image get usdaOrganic => Image.asset('$_certPath/usda_organic.png');
}

extension ImageExtension on Image {
  Image copyWith({
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    return Image(
      image: image,
      width: width ?? this.width,
      height: height ?? this.height,
      fit: fit ?? this.fit,
    );
  }
}
