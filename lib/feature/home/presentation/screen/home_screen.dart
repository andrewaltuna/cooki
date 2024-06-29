import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_helper/common/component/main_scaffold.dart';
import 'package:grocery_helper/common/constants/app_strings.dart';
import 'package:grocery_helper/common/theme/app_colors.dart';
import 'package:grocery_helper/common/theme/app_text_styles.dart';
import 'package:grocery_helper/feature/beacon/presentation/view_model/beacon_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainScaffold(
      body: Column(
        children: [
          SizedBox(height: 16),
          _ProximityIndicator(),
        ],
      ),
    );
  }
}

class _ProximityIndicator extends StatelessWidget {
  const _ProximityIndicator();

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyles.label.copyWith(
      color: AppColors.fontSecondary,
    );

    return BlocBuilder<BeaconViewModel, BeaconState>(
      builder: (context, state) {
        return Container(
          constraints: const BoxConstraints(maxWidth: 220),
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Column(
            children: [
              if (state.beacons.isEmpty)
                Text(
                  AppStrings.beaconPlaceholder,
                  textAlign: TextAlign.center,
                  style: textStyle,
                )
              else
                for (var beacon in state.beacons) ...[
                  Text(
                    'Beacon detected:',
                    style: textStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    beacon.proximityUUID,
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                  Text(
                    'Distance: ${beacon.accuracy}m',
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
