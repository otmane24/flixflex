import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../constants/strings/constants_strings.dart';

class HiveBase {
  static HiveBase hiveBase = HiveBase();

  late Box settings;

  static Future init() async {
    Directory directory = await getApplicationDocumentsDirectory();

    Hive.init(directory.path);

    hiveBase.settings = await Hive.openBox(settingsBoxHive);
  }

  Future<void> setLanguage(String language) async =>
      await settings.put(languageHiveKey, language);

  Future<void> setIsLogin(bool isLogin) async =>
      await settings.put(isLoginHiveKey, isLogin);

  String? getLanguage() => settings.get(languageHiveKey, defaultValue: 'En');

  bool? getIsLogin() => settings.get(isLoginHiveKey, defaultValue: false);

  void removeLanguage() => settings.delete(languageHiveKey);

  void removeIsLogin() => settings.delete(isLoginHiveKey);

  static Future removeAllData() async {
    await hiveBase.settings.clear();
  }
}
