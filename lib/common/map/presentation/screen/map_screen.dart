import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/map/presentation/component/map_view.dart';
import 'package:cooki/common/map/presentation/view_model/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Map',
      contentPadding: EdgeInsets.zero,
      body: BlocProvider(
        create: (_) => MapViewModel(),
        child: const MapView(),
      ),
    );
  }
}
