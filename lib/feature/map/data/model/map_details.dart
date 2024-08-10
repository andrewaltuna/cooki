import 'package:cooki/constant/map_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class MapDetails extends Equatable {
  const MapDetails({
    required this.size,
    required this.scaledBy,
  });

  factory MapDetails.fromJson(Map<String, dynamic> json) {
    final width = json['width'] as num;
    final height = json['height'] as num;

    final scaledBy = MapConstants.fixedHeight / height;

    return MapDetails(
      size: Size(
        width * scaledBy,
        height * scaledBy,
      ),
      scaledBy: scaledBy,
    );
  }

  static const empty = MapDetails(
    size: Size.zero,
    scaledBy: 0,
  );

  final Size size;

  /// The scale factor used to scale the map to fixed height.
  final double scaledBy;

  @override
  List<Object> get props => [
        size,
        scaledBy,
      ];
}
