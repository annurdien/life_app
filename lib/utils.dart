import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';

final logger = Logger();

Future<void> logToCrashlytics(dynamic exception, StackTrace? stack) async {
  FirebaseCrashlytics.instance.recordError(exception, stack);
}

int secondsToMinutes(int seconds) => (seconds / 60).floor();

extension Emotion on num {
  String get feeling {
    switch (this) {
      case 0:
        return "😢";
      case 1:
        return "😕";
      case 2:
        return "😊";
      case 3:
        return "😄";
      case 4:
        return "😆";
      default:
        return "😐";
    }
  }

  String get feelingText {
    switch (this) {
      case 0:
        return "Bad";
      case 1:
        return "Meh";
      case 2:
        return "OK";
      case 3:
        return "Good";
      case 4:
        return "Great";
      default:
        return "Meh";
    }
  }
}
