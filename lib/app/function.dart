import 'dart:io';

import 'package:clean_architecture_with_mvvm/domain/entities/model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = 'unknown';
  String identifier = 'unknown';
  String version = 'unknown';

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      name = '${build.brand} ${build.model}';
      identifier = build.id.toString();
      version = build.version.toString();
    } else if (Platform.isIOS) {
      var build = await deviceInfoPlugin.iosInfo;
      name = '${build.name} ${build.model}';
      identifier = build.identifierForVendor.toString();
      version = build.systemVersion.toString();
    }
  } on PlatformException {
    return DeviceInfo(name, identifier, version);
  }

  return DeviceInfo(name, identifier, version);
}
