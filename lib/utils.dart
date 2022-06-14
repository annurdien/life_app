import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';

final logger = Logger();

Future<void> logToCrashlytics(dynamic exception, StackTrace? stack) async {
  FirebaseCrashlytics.instance.recordError(exception, stack);
}
