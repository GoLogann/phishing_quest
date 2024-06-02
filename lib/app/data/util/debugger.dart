

import 'package:logger/web.dart';
import 'package:phishing_quest/app/data/util/helpers/index.dart';

/// `Debugger` is a class designed for logging debug information.
class Debugger {
  late final Helpers _helpers;
  late final Logger _logger;

  Debugger({Helpers? helpers, Logger? logger}) {
    _helpers = helpers ?? Helpers();
    _logger = logger ?? Logger(printer: PrettyPrinter());
  }

  static const int _limit = 2048;

  /// This function logs information for debugging.
  ///
  /// Parameters:
  /// - classPointer: Reference to the classes' instance or class name as string that invoked the method.
  /// - method: Name of the method where the log is coming from.
  /// - message: The actual information to be logged.
  /// - time: The current time that the log is being generated.
  /// - trace: StackTrace to be logged, can be helpful in debugging.
  void log({
    required dynamic classPointer,
    required String method,
    required String? message,
    DateTime? time,
    StackTrace? trace,
  }) {
    final String classType = classPointer.runtimeType.toString();
    final String className = classType == 'String' ? classPointer.toString() : classType;
    final name = className.isEmpty ? method : '$className::$method';

    String body = message?.toString() ?? '';
    if (_helpers.isRunningDebug() && body.length > _limit) {
      body = body.substring(0, _limit);
    }

    if (trace != null) {
      return _logger.e(
        {'name': name, 'body': body},
        time: time ?? DateTime.now(),
        stackTrace: trace,
      );
    }

    _logger.d(
      {'name': name, 'body': body},
      time: time ?? DateTime.now(),
    );
  }
}
