import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:cooki/common/component/global_blocs.dart';
import 'package:cooki/common/component/global_listeners.dart';
import 'package:cooki/common/helper/permission_helper.dart';
import 'package:cooki/common/navigation/app_router.dart';
import 'package:cooki/firebase_options.dart';
import 'package:cooki/common/theme/app_colors.dart';

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
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.backgroundPrimary,
        ),
      ),
    );
  }
}
