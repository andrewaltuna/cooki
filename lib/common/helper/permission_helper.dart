import 'package:grocery_helper/common/service/permission_service.dart';

class PermissionHelper {
  const PermissionHelper._();

  static const _permissionService = PermissionService();

  static Future<void> checkBluetoothPermission() async {
    final isGranted = await _permissionService.isBluetoothPermissionGranted();

    if (!isGranted) {
      await _permissionService.requestBluetoothPermission();
    }

    final isScanGranted =
        await _permissionService.isBluetoothScanPermissionGranted();
    if (!isScanGranted) {
      await _permissionService.requestBluetoothScanPermission();
    }
  }

  static Future<void> checkLocationPermission() async {
    final isGranted = await _permissionService.isLocationPermissionGranted();

    if (!isGranted) {
      await _permissionService.requestLocationPermission();
    }
  }
}
