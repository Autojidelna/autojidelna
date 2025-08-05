import 'package:flutter/foundation.dart';

/// This is a test function that will crash the app.
void crashTestFunction() async {
  if (kIsWeb) {
    throw StateError('Crash WEB');
  }
  throw StateError('Crash native');
}
