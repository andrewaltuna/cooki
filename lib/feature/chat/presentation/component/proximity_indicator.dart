import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cooki/common/helper/permission_helper.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/beacon/presentation/view_model/beacon_view_model.dart';
import 'package:ionicons/ionicons.dart';

class BeaconProximityIndicator extends StatelessWidget {
  const BeaconProximityIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyles.bodySmall.copyWith(
      color: AppColors.fontSecondary,
    );

    return BlocBuilder<BeaconViewModel, BeaconState>(
      builder: (context, state) {
        if (state.permissionStatus.isSuccess && !state.arePermissionsGranted) {
          return _IndicatorContainer(
            onTap: () => PermissionHelper.of(context)
                .requestBeaconPermissionsWithModal(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Ionicons.warning,
                  color: AppColors.fontWarning,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    'Permissions required to view nearby sections. Tap for more information.',
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                ),
              ],
            ),
          );
        }

        if (state.beacons.isEmpty) {
          return _IndicatorContainer(
            child: SizedBox(
              width: 220,
              child: Text(
                'Go near a section or aisle to \nsee more information',
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
          );
        }

        return _IndicatorContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var beacon in state.beacons) ...[
                Text(
                  'Beacon detected:',
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '#${beacon.identifier}, RSSI: ${beacon.rssi}, Dist: ${beacon.distanceInMeter.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _IndicatorContainer extends StatelessWidget {
  const _IndicatorContainer({
    required this.child,
    this.onTap,
  });

  final VoidCallback? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: child,
      ),
    );
  }
}
