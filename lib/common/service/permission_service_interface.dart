import 'package:permission_handler/permission_handler.dart';

abstract interface class PermissionServiceInterface {
  Future<PermissionStatus> checkLocationPermission();

  Future<PermissionStatus> checkBluetoothPermission();

  Future<PermissionStatus> checkBluetoothScanPermission();

  Future<PermissionStatus> requestLocationPermission();

  Future<PermissionStatus> requestBluetoothPermission();

  Future<PermissionStatus> requestBluetoothScanPermission();
}
