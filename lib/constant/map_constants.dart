import 'package:cooki/feature/map/data/model/coordinates.dart';

/// Contains values generally used across features.
class MapConstants {
  const MapConstants._();

  /// Height that the map's height is scaled to for display.
  static const fixedHeight = 1000.0;

  /// If you don't have access to beacons and want to test the map with a fixed
  /// user location, set [useFixedUserLocation] to true.
  ///
  /// Otherwise, set it to false to allow user location to be tracked using beacon data.
  ///
  /// Default: true
  static const useFixedUserLocation = true;

  /// Used to set user location when [MapConstants.useFixedUserLocation] is set to true.
  /// Uncomment the given coordinates to set the user location (or enter your own coordinates!).
  ///
  /// Note that coordinate values are based on actual map size * 2.
  ///
  /// For example, if you want to set your location to the top left corner of
  /// the map (default size 5 x 3.3 meters) use Coordinates(-5, 3.3) instead of Coordinates(-2.5, 1.15).
  ///
  /// Default: Coordinates(1, -2.6) - Veggies/Floral Sections
  static const fixedUserLocation =
      // Presets
      Coordinates(1, -2.6); // Veggies/Floral Sections
  // Coordinates(4.4, -2.7); // Bakery section
  // Coordinates(-2.5, 1.9); // Haircare/Wellness Sections
}
