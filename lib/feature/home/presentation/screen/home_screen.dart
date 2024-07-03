import 'package:flutter/material.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/feature/home/presentation/component/proximity_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainScaffold(
      body: Column(
        children: [
          SizedBox(height: 16),
          BeaconProximityIndicator(),
        ],
      ),
    );
  }
}
