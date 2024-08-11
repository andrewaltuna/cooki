import 'package:cooki/common/theme/app_theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:cooki/common/component/global/global_blocs.dart';
import 'package:cooki/common/component/global/global_listeners.dart';
import 'package:cooki/common/helper/permission_helper.dart';
import 'package:cooki/common/navigation/app_router.dart';
import 'package:cooki/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    await flutterBeacon.initializeScanning;
  } on PlatformException catch (error) {
    if (kDebugMode) {
      print('flutterBeacon ERROR: ${error.toString()}');
    }
  }

  await PermissionHelper.requestBeaconPermissions();

  runApp(
    const GlobalBlocs(
      child: GlobalListeners(
        child: MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: appThemeData,
    );
  }
}
