import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:cooki/common/helper/dialog_helper.dart';
import 'package:cooki/common/service/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  const PermissionHelper._(this._context);

  factory PermissionHelper.of(BuildContext context) =>
      PermissionHelper._(context);

  static const _permissionService = PermissionService();

  final BuildContext _context;

  static Future<bool> requestBeaconPermissions() async {
    final arePermissionsGranted = [
      await _permissionService.requestBluetoothPermission(),
      await _permissionService.requestBluetoothScanPermission(),
      await _permissionService.requestLocationPermission(),
    ].every((status) => status.isGranted);

    return arePermissionsGranted;
  }

  static Future<bool> validateBeaconPermissions() async {
    final arePermissionsGranted = [
      await _permissionService.checkBluetoothPermission(),
      await _permissionService.checkBluetoothScanPermission(),
      await _permissionService.checkLocationPermission(),
    ].every((status) => status.isGranted);

    return arePermissionsGranted;
  }

  Future<void> requestBeaconPermissionsWithModal() async {
    await DialogHelper.of(_context).showDefaultDialog(
      DefaultDialogArgs(
        title: 'Permissions required',
        message:
            'Cooki uses Bluetooth and Location services to track and suggest products within your vicinity.\n\nAllow access to these permissions for a smoother experience.',
        confirmText: 'Open settings',
        onConfirm: () => AppSettings.openAppSettings(),
      ),
    );
  }
}
