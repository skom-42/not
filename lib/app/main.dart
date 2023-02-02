import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noty_mobile/app/noty_app.dart';
import 'package:firebase_core/firebase_core.dart';

import '../core/di/app_di.dart';
import '../core/di/data_di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  await Firebase.initializeApp();

  appDI.initDependencies();
  await dataDI.initDependencies();

  runApp(const NotyApp());
}
