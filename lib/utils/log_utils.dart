import 'package:flutter/foundation.dart';

class Log {
  static const String _tag = "LogUtils: ";

  static void s(String log, {String? fileName, String? address}) {
    if (kDebugMode) {
      _print(_getLogStatement(log, fileName: fileName, address: address));
    }
  }

  static void d(String log, {String? fileName, String? address}) {
    if (kDebugMode) {
      _print(_getLogStatement(log, fileName: fileName, address: address),
          mode: "d");
    }
  }

  static void w(String log, {String? fileName, String? address}) {
    if (kDebugMode) {
      _print(_getLogStatement(log, fileName: fileName, address: address),
          mode: "w");
    }
  }

  static void e(String log, {String? fileName, String? address}) {
    if (kDebugMode) {
      _print(_getLogStatement(log, fileName: fileName, address: address),
          mode: "e");
    }
  }

  static String _getLogStatement(String log,
      {String? fileName, String? address}) {
    String fileNameStatement = fileName == null ? "" : "$fileName -> ";
    String addressStatement = address == null ? "" : "$address - ";

    return "$_tag$fileNameStatement$addressStatement$log";
  }

  static void _print(String text, {String mode = "s"}) {
    switch (mode.toLowerCase()) {
      case "d":
        debugPrint('\x1B[34m$text\x1B[0m');
        break;
      case "w":
        debugPrint('\x1B[33m$text\x1B[0m');
        break;
      case "e":
        debugPrint('\x1B[31m$text\x1B[0m');
        break;
      default:
        debugPrint('\x1B[32m$text\x1B[0m');
        break;
    }
  }

// Black:   \x1B[30m
// Red:     \x1B[31m
// Green:   \x1B[32m
// Yellow:  \x1B[33m
// Blue:    \x1B[34m
// Magenta: \x1B[35m
// Cyan:    \x1B[36m
// White:   \x1B[37m
// Reset:   \x1B[0m
}
