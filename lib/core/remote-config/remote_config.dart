import 'dart:convert';

import 'package:autojidelna/shared/config/hive.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final Provider<Map<dynamic, dynamic>> remoteConfigValues =
    Provider<Map<dynamic, dynamic>>((ref) => Hive.box(Boxes.appState).get(HiveKeys.appState.remoteConfigValues));

enum RemoteConfigValueType {
  string,
  bool,
  int,
  double,
  json,
  dateTime,
}

class RemoteConfig {
  static final FirebaseRemoteConfig instance = FirebaseRemoteConfig.instance;

  /// Method to get the Remote Config value types. This is grabbed from the default values.
  static Map<String, RemoteConfigValueType> get remoteConfigValueTypes {
    return defaultValues.map((key, value) {
      if (value is String) {
        return MapEntry(key, RemoteConfigValueType.string);
      } else if (value is bool) {
        return MapEntry(key, RemoteConfigValueType.bool);
      } else if (value is Map) {
        return MapEntry(key, RemoteConfigValueType.json);
      } else if (value is int) {
        return MapEntry(key, RemoteConfigValueType.int);
      } else if (value is double) {
        return MapEntry(key, RemoteConfigValueType.double);
      } else if (value is DateTime) {
        return MapEntry(key, RemoteConfigValueType.dateTime);
      } else {
        return MapEntry(key, RemoteConfigValueType.string);
      }
    });
  }

  static Map<String, dynamic> parseRemoteConfigValues(Map<String, RemoteConfigValue> remoteConfigValues) {
    final types = remoteConfigValueTypes;
    return remoteConfigValues.map((key, value) {
      switch (types[key]) {
        case RemoteConfigValueType.string:
          return MapEntry(key, value.asString());
        case RemoteConfigValueType.bool:
          return MapEntry(key, value.asBool());
        case RemoteConfigValueType.int:
          return MapEntry(key, value.asInt());
        case RemoteConfigValueType.double:
          return MapEntry(key, value.asDouble());
        case RemoteConfigValueType.json:
          return MapEntry(key, jsonDecode(value.asString()));
        case RemoteConfigValueType.dateTime:
          return MapEntry(key, DateTime.tryParse(value.asString()));
        default:
          return MapEntry(key, value.asString());
      }
    });
  }

  // static const String string = 'author_message';
  // static const String boolTrue = 'bool_true';
  // static const String json = 'json';
  // static const String integer = 'integer';
  // static const String doubleNum = 'double_num';

  static const String canteenUrls = 'canteen_urls';

  /// Default values for Remote Config
  /// Every value has to be included to be parsed correctly.
  /// If a value isn't included, it will be parsed as a string.
  static const Map<String, dynamic> defaultValues = {
    // EXAMPLES:
    // string: '',
    // boolTrue: true,
    // json: {'key': 'value'},
    // integer: 42,
    // doubleNum: 42.5,

    canteenUrls: {'Střední průmyslová škola a Gymnázium Třebešín': 'jidelna.trebesin.cz'},
  };
}
