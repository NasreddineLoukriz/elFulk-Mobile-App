import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/app/elfulk_app.dart';
import 'package:elfulk/src/core/config/app_environment.dart';
import 'package:elfulk/src/core/config/di/dependency_injection.dart';

Future<void> bootApp({
  required AppFlavor flavor,
  required FirebaseOptions firebaseOptions,
}) async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(options: firebaseOptions);

  final AppEnvironment environment = AppEnvironment.fromFlavor(flavor);
  await setupGetIt(environment);

  FlutterNativeSplash.remove();

  runApp(const ElFulkApp());
}
