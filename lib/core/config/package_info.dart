import 'dart:developer';
import 'package:package_info_plus/package_info_plus.dart';

class MyPackage {
  static String appName = '';
  static String packageName = '';
  static String version = '';
  static String buildNumber = '';

  static Future<PackageInfo> getInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    log('-----Start Flavors-----');
    log('appName   : $appName');
    log('packageName : $packageName');
    log('version   : $version');
    log('buildNumber : $buildNumber');
    log('-----End Flavors-----');

    return packageInfo;
  }
}
