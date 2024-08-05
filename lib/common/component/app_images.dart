import 'package:flutter/material.dart';

class AppImages {
  const AppImages._();

  static const _basePath = 'assets/imgs';

  static Image get logo => Image.asset('$_basePath/logo.png');
  static Image get logoAlt => Image.asset('$_basePath/logo_alt.png');
  static Image get cooki => Image.asset('$_basePath/cooki.png');

  // Chat
  static Image get cookiChat => Image.asset('$_basePath/cooki_chat.png');

  // Map
  static Image get map => Image.asset('$_basePath/map.png');
}

extension ImageExtension on Image {
  Image copyWith({
    double? width,
    double? height,
  }) {
    return Image(
      image: image,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }
}
