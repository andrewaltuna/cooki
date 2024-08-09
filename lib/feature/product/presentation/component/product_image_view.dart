import 'package:cached_network_image/cached_network_image.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductImageView extends StatelessWidget {
  const ProductImageView({
    required this.imageUrl,
    this.height,
    this.width,
    super.key,
  });

  final String imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: AppColors.backgroundSecondary,
        highlightColor: AppColors.backgroundTertiary,
        child: Container(
          height: height,
          width: width,
          color: AppColors.backgroundSecondary,
        ),
      ),
    );
  }
}
