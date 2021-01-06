import 'dart:io';

import 'package:integration_test/integration_test_driver.dart';
import 'package:path/path.dart' as path;

Future<void> main() async {
  final String androidHome = Platform.environment['ANDROID_SDK_ROOT'];

  if (androidHome == null) {
    throw Exception('The ANDROID_SDK_ROOT environment variable is '
        'missing. The variable must point to the Android '
        'SDK directory containing platform-tools.');
  }

  String adbPath = path.join(androidHome, 'platform-tools/adb');
  adbPath = path.absolute(adbPath);

  await Process.run(adbPath, [
    'shell',
    'pm',
    'grant',
    'com.example.integration_test',
    'android.permission.ACCESS_COARSE_LOCATION'
  ]);

  await Process.run(adbPath, [
    'shell',
    'pm',
    'grant',
    'com.example.integration_test',
    'android.permission.ACCESS_FINE_LOCATION'
  ]);

  integrationDriver();
}
