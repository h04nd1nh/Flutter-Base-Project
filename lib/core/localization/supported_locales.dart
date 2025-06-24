import 'package:flutter/material.dart';

class SupportedLocales {
  static const List<Locale> supportedLocales = [
    Locale('vi', 'VN'), // Vietnamese
    Locale('en', 'US'), // English
  ];

  static const List<LanguageModel> languages = [
    LanguageModel(code: 'vi', name: 'Tiếng Việt', flag: '🇻🇳'),
    LanguageModel(code: 'en', name: 'English', flag: '🇺🇸'),
  ];

  static LanguageModel getLanguageByCode(String code) {
    return languages.firstWhere(
      (lang) => lang.code == code,
      orElse: () => languages.first,
    );
  }
}

class LanguageModel {
  final String code;
  final String name;
  final String flag;

  const LanguageModel({
    required this.code,
    required this.name,
    required this.flag,
  });
}
