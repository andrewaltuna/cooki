import 'package:permission_handler/permission_handler.dart';

abstract interface class PermissionServiceInterface {
  Future<bool> isLocationPermissionGranted();

  Future<bool> isBluetoothPermissionGranted();

  Future<bool> isBluetoothScanPermissionGranted();

  Future<PermissionStatus> requestLocationPermission();

  Future<PermissionStatus> requestBluetoothPermission();

  Future<PermissionStatus> requestBluetoothScanPermission();
}
