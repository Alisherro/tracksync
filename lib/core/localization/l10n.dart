import 'package:flutter/material.dart';

class L10n {
  L10n._();

  static final all = [
    const Locale('en'),
    const Locale('kk'),
    const Locale('ru'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'ru':
        return 'Russian';
      case 'kk':
        return 'Kazakh';
      case 'en':
      default:
        return 'English';
    }
  }
}
