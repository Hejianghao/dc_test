import 'package:flutter/material.dart';
import 'package:dc_test/utils/local_storage.dart';

class CommonParams {
  static String token = '';
  static Locale? languageCode;

  static initial() async {
    await LocalStorage.initial();

    CommonParams.token = LocalStorage.getString(PreferencesKey.token) ?? '';
  }
}
