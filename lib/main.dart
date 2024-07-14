import 'package:cooki/common/component/indicator/loading_indicator.dart';
import 'package:cooki/common/theme/app_theme_data.dart';
import 'package:cooki/feature/account/presentation/view_model/auth_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:cooki/common/component/global_blocs.dart';
import 'package:cooki/common/component/global_listeners.dart';
import 'package:cooki/common/helper/permission_helper.dart';
import 'package:cooki/common/navigation/app_router.dart';
import 'package:cooki/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    await flutterBeacon.initializeScanning;
  } on PlatformException catch (error) {
    print('flutterBeacon ERROR: ${error.toString()}');
  }

  await PermissionHelper.requestBeaconPermissions();

  runApp(
    const GlobalBlocs(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalListeners(
      child: MaterialApp.router(
        routerConfig: appRouter,
        theme: appThemeData,
        builder: (_, child) {
          if (child == null) return const SizedBox.shrink();

          return _LoadingIndicator(child: child);
        },
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthViewModel, AuthState, bool>(
      selector: (state) => state.isFetchingAuthStatus,
      builder: (_, isFetchingAuthStatus) {
        if (isFetchingAuthStatus) {
          return const Scaffold(
            body: Center(
              child: LoadingIndicator(),
            ),
          );
        }

        return child;
      },
    );
  }
}
