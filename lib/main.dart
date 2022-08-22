import 'dart:developer' as dev;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:todo_list/data/local/db_client.dart';
import 'package:todo_list/presentation/app.dart';
import 'package:todo_list/presentation/navigation/router_delegate.dart';

import 'firebase_options.dart';

Provider loggerProvider = Provider(
  (ref) => Logger('logger'),
);

ChangeNotifierProvider<TasksRouterDelegate> navigationProvider =
    ChangeNotifierProvider(
  (ref) => TasksRouterDelegate(ref),
);

FutureProvider<FirebaseRemoteConfig> remoteConfigProvider =
    FutureProvider((ref) async => await getConfig());

Provider<FirebaseAnalytics> analyticsProvider =
    Provider((ref) => FirebaseAnalytics.instance);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBClient.openDataBase();
  initLogger();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

Future<FirebaseRemoteConfig> getConfig() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
  FlutterError.onError = crashlytics.recordFlutterFatalError;
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(minutes: 5),
  ));
  remoteConfig.setDefaults({'color': -1});
  await remoteConfig.fetchAndActivate();
  return remoteConfig;
}

void initLogger() {
  if (kDebugMode) {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      dev.log('${record.level.name}: ${record.time}: ${record.message}');
    });
  }
}
