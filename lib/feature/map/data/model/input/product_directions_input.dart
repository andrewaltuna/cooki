import 'package:cooki/feature/map/data/model/coordinates.dart';
import 'package:equatable/equatable.dart';

class ProductDirectionsInput extends Equatable {
  const ProductDirectionsInput({
    required this.productId,
    required this.coordinates,
  });

  final String productId;
  final Coordinates coordinates;

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'coordinates': coordinates.toJson(),
    };
  }

  @override
  List<Object> get props => [
        productId,
        coordinates,
      ];
}
