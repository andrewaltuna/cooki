import 'package:grocery_helper/common/service/permission_service_interface.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService implements PermissionServiceInterface {
  const PermissionService();

  @override
  Future<PermissionStatus> checkBluetoothPermission() async {
    return await Permission.bluetooth.status;
  }

  @override
  Future<PermissionStatus> checkBluetoothScanPermission() async {
    return await Permission.bluetoothScan.status;
  }

  @override
  Future<PermissionStatus> checkLocationPermission() async {
    return await Permission.locationWhenInUse.status;
  }

  @override
  Future<PermissionStatus> requestBluetoothPermission() async {
    return await Permission.bluetooth.request();
  }

  @override
  Future<PermissionStatus> requestBluetoothScanPermission() async {
    return await Permission.bluetoothScan.request();
  }

  @override
  Future<PermissionStatus> requestLocationPermission() async {
    return await Permission.locationWhenInUse.request();
  }
}
