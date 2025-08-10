// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;
import 'package:swipe_up/generated/key_loader.dart';

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> _ar = {
    "welcome": "مرحبا",
    "home": "الصفحة الرئيسية",
    "search": "بحث",
    LocaleKeys.test: "الصفحة الرئيسية"
  };
  static const Map<String, dynamic> _en = {
    "welcome": "Welcome",
    "home": "Home",
    "search": "Search",
    LocaleKeys.test: "Home",
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "ar": _ar,
    "en": _en
  };
}
