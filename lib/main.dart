import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_app/app.dart';
import 'package:life_app/constants.dart';
import 'package:life_app/firebase_options.dart';

import 'models/user_model.dart';

void main() async {
  init();
}

Future<void> init() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    }

    await FirebaseAnalytics.instance
        .setAnalyticsCollectionEnabled(kReleaseMode);

    // await Supabase.initialize(
    //   url: Constants.SUPABASE_URL,
    //   anonKey: Constants.SUPABASE_ANON_KEY,
    //   debug: Constants.isDebugMode,
    // );

    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openLazyBox(Constants.BOX_NAME);

    return runApp(
      const ProviderScope(
        child: LifeApp(),
      ),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}
