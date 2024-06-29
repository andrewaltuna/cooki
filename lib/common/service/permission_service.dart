import 'package:grocery_helper/common/service/permission_service_interface.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService implements PermissionServiceInterface {
  const PermissionService();

  @override
  Future<bool> isBluetoothPermissionGranted() async {
    return await Permission.bluetooth.status.isGranted;
  }

  @override
  Future<bool> isBluetoothScanPermissionGranted() async {
    return await Permission.bluetoothScan.status.isGranted;
  }

  @override
  Future<bool> isLocationPermissionGranted() async {
    return await Permission.locationWhenInUse.status.isGranted;
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
