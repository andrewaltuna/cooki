import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_helper/common/component/global_blocs.dart';
import 'package:grocery_helper/common/helper/permission_helper.dart';
import 'package:grocery_helper/common/navigation/app_router.dart';
import 'package:grocery_helper/feature/account/presentation/view_model/auth_view_model.dart';
import 'package:grocery_helper/firebase_options.dart';
import 'package:grocery_helper/common/theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    await flutterBeacon.initializeAndCheckScanning;
  } on PlatformException catch (error) {
    print('flutterBeacon ERROR: ${error.toString()}');
  }

  await PermissionHelper.checkBluetoothPermission();
  await PermissionHelper.checkLocationPermission();

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
    return BlocListener<AuthViewModel, AuthState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.isAuthenticated != current.isAuthenticated,
      listener: (context, state) {
        if (state.status.isInitial) return;

        appRouter.refresh();
      },
      child: MaterialApp.router(
        routerConfig: appRouter,
        theme: ThemeData(scaffoldBackgroundColor: AppColors.backgroundPrimary),
      ),
    );
  }
}
