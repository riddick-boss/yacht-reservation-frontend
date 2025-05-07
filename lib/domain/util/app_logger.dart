import 'package:logger/logger.dart';

class AppLogger {
  static final logger = Logger();

  static void d(String message) {
    logger.d(message);
  }

  static void i(String message) {
    logger.i(message);
  }

  static void e(String message, {Object? error}) {
    logger.e(message, error: error);
  }
}
