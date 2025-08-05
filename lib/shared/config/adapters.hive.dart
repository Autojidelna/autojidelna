import 'package:autojidelna/shared/theme/domain/color_style.dart';
import 'package:autojidelna/shared/config/date_format_options.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  final typeId = 0; // Put an ID you didn't use yet.

  @override
  ThemeMode read(BinaryReader reader) => ThemeMode.values[reader.readInt()];

  @override
  void write(BinaryWriter writer, ThemeMode obj) => writer.writeInt(obj.index);
}

class ThemeStyleAdapter extends TypeAdapter<ThemeStyle> {
  @override
  final typeId = 1; // Put an ID you didn't use yet.

  @override
  ThemeStyle read(BinaryReader reader) => ThemeStyle.values[reader.readInt()];

  @override
  void write(BinaryWriter writer, ThemeStyle obj) => writer.writeInt(obj.index);
}

class DateFormatOptionsAdapter extends TypeAdapter<DateFormatOptions> {
  @override
  final typeId = 2; // Put an ID you didn't use yet.

  @override
  DateFormatOptions read(BinaryReader reader) => DateFormatOptions.values[reader.readInt()];

  @override
  void write(BinaryWriter writer, DateFormatOptions obj) => writer.writeInt(obj.index);
}

class LocaleAdapter extends TypeAdapter<Locale> {
  @override
  final int typeId = 3; // Put an ID you didn't use yet.

  @override
  Locale read(BinaryReader reader) {
    List<String> data = reader.readStringList(2);
    return Locale(data.first, data.last);
  }

  @override
  void write(BinaryWriter writer, Locale obj) {
    writer.writeStringList([obj.languageCode, obj.countryCode ?? '']);
  }
}
