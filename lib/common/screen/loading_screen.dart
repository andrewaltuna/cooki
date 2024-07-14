import 'package:cooki/common/component/indicator/loading_indicator.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: LoadingIndicator(),
      ),
    );
  }
}
