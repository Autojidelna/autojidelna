import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class LocalLogger {
  static final String _fileName = 'autojidelna_crash_log.txt';
  static late Logger _logger;
  static late File _logFile;
  static late String _logFilePath;

  static Future<void> init() async {
    _logFilePath = '${(await getApplicationCacheDirectory()).path}/$_fileName';
    _logFile = File(_logFilePath);
    _logger = Logger(
      printer: PrettyPrinter(dateTimeFormat: DateTimeFormat.dateAndTime, printEmojis: false, methodCount: 0, errorMethodCount: 8),
      filter: ProductionFilter(),
      output: MultiOutput([ConsoleOutput(), FileOutput(file: _logFile, overrideExisting: true)]),
    );
  }

  static Future<void> downloadLogFile() async {
    if (!_logFile.existsSync()) _logFile = File(_logFilePath);
    await FilePicker.saveFile(fileName: _fileName, bytes: _logFile.readAsBytesSync());
  }

  static void logError(String message, Object error, StackTrace? stack) => _logger.e(message, error: error, stackTrace: stack);
  static void logInfo(String message) => _logger.i(message);
}

Future<String> logSystemInfo() async {
  final BaseDeviceInfo deviceInfo = await DeviceInfoPlugin().deviceInfo;
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String deviceDetails;

  if (kIsWeb) {
    deviceInfo as WebBrowserInfo;
    deviceDetails =
        '''
Web Browser Info
- Browser: ${deviceInfo.browserName.toString().split('.').last}
- User Agent: ${deviceInfo.userAgent}
- Platform: ${deviceInfo.platform}
- Vendor: ${deviceInfo.vendor}
- App Version: ${deviceInfo.appVersion}
''';
  } else if (Platform.isAndroid) {
    deviceInfo as AndroidDeviceInfo;
    deviceDetails =
        '''
Device Info
- Name: ${deviceInfo.device} (${deviceInfo.product})
- Model: ${deviceInfo.model}
- Brand: ${deviceInfo.manufacturer}
- Manufacturer: ${deviceInfo.manufacturer}
- Android Version: ${deviceInfo.version.release} (SDK ${deviceInfo.version.sdkInt})
''';
  } else if (Platform.isIOS) {
    deviceInfo as IosDeviceInfo;
    deviceDetails =
        '''
Device Info
- Name: ${deviceInfo.modelName}
- Model: ${deviceInfo.model}
- Manufacturer: ${deviceInfo.isiOSAppOnMac}
- iOS Version: ${deviceInfo.systemVersion}
''';
  } else {
    deviceDetails = '''
Device Info
Unknown platform
''';
  }

  final summary =
      '''
App Info
- Name: ${packageInfo.appName}
- Package: ${packageInfo.packageName}
- Version: ${packageInfo.version} (${packageInfo.buildNumber})
- Installer: ${packageInfo.installerStore}

$deviceDetails
''';
  return summary;
}

final class RiverpodLogger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderObserverContext context, Object? previousValue, Object? newValue) {
    final String message =
        '''
Provider updated
- Name: ${context.provider.name}
- Container: ${context.container}

  Change: $previousValue -> $newValue 

- Mutation: ${context.mutation}
''';

    LocalLogger.logInfo(message);
  }

  @override
  void providerDidFail(ProviderObserverContext context, Object error, StackTrace stackTrace) {
    final String message =
        '''
Provider failed
- Name: ${context.provider.name}
- Container: ${context.container}
- Auto dispose: ${context.provider.isAutoDispose}
- Mutation: ${context.mutation}
''';

    LocalLogger.logError(message, error, stackTrace);
  }
}
