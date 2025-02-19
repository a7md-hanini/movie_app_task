import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/services.dart';

class DioClient {
  static final DioClient _dioClient = DioClient._internal();

  String password = 'changeit';
  String? deviceId = "noID";
  late ByteData rootCACertificate;
  late ByteData clientCertificate;
  late ByteData privateKey;
  late Dio dio;
  String? userName;

  factory DioClient() {
    return _dioClient;
  }

  DioClient._internal();

  Future<bool> initcert() async {
    password = 'changeit';
    deviceId = await getDeviceId();
    rootCACertificate = await rootBundle.load("assets/client.p12");
    clientCertificate = await rootBundle.load("assets/client.p12");
    privateKey = await rootBundle.load("assets/client.p12");
    dio = Dio();
    // dio.interceptors.add(PrettyDioLogger());

    // ignore: deprecated_member_use
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      SecurityContext context = SecurityContext(withTrustedRoots: true);

      context.useCertificateChainBytes(clientCertificate.buffer.asUint8List(),
          password: password);

      context.usePrivateKeyBytes(privateKey.buffer.asUint8List(),
          password: password);
      HttpClient httpClient = HttpClient(context: context);

      return httpClient;
    };
    return true;
  }

  static Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }
}

final dioClient = DioClient();
