import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

DeviceData oPDeviceData = DeviceData();

class DeviceData {
  static final DeviceData _oPDeviceData = DeviceData._internal();

  String modelName = '';
  String modelNumber = '';
  String softwareVersion = '';
  String serialNumber = '';
  String? notificationToken = '';
  String? osPlatform = '';
  // static
  // var uuid = const Uuid();

  getDeviceData() async {
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await DeviceInfoPlugin().iosInfo;
      modelName = iosInfo.utsname.machine;
      modelNumber = iosInfo.utsname.machine;
      softwareVersion = iosInfo.systemVersion;
      serialNumber = ''; //!!! NEED
      osPlatform = 'iOS';
      // notificationToken = await FirebaseMessaging.instance.getToken();

      log('iOS NotificationToken : : : :    $notificationToken');
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      osPlatform = 'Android';
      modelName = androidInfo.model;
      modelNumber = androidInfo.device;
      softwareVersion = androidInfo.version.release;
      serialNumber = androidInfo.id;

      log('Android NotificationToken : : : :    $notificationToken');
    }
  }

  factory DeviceData() {
    return _oPDeviceData;
  }
  DeviceData._internal();
}
