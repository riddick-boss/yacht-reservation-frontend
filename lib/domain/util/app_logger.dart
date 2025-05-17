
import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger();

  /// Loguje informację (info)
  static void i(String message) {
    _logger.i(message);
  }

  /// Loguje błąd z opcjonalnym error i stack trace
  static void e(String message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
