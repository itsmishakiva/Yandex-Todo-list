import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/data/db_client.dart';
import 'package:todo_list/presentation/app.dart';
import 'package:todo_list/presentation/navigation/navigation_controller.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBClient.openDataBase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DBClient(),
        ),
        Provider<NavigationController>(
          create: (context) => NavigationController(),
        ),
        ChangeNotifierProvider<FirebaseRemoteConfig>.value(
          value: await getConfig(),
        )
      ],
      child: const App(),
    ),
  );
}

Future<FirebaseRemoteConfig> getConfig () async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
  FlutterError.onError= crashlytics.recordFlutterFatalError;
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 10),
    minimumFetchInterval: const Duration(seconds: 20),
  ));
  await remoteConfig.fetchAndActivate();
  return remoteConfig;
}
