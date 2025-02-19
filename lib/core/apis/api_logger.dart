import 'dart:convert';
import 'dart:developer' as dev;
import 'package:dio/dio.dart';

class ApiLogger {
  ///-----------///
  ///----Log----///
  ///-----------///
  static log({
    required Response response,
    required String apiName,
    Object? requestBody,
  }) {
    ///----Format request
    final indentedRequest = requestBody != null
        ? const JsonEncoder.withIndent('  ')
            .convert(requestBody)
            .split('\n')
            .map((line) => '  ║  $line')
            .join('\n')
        : '  ║  {}';

    ///----Format response
    final indentedResponse = const JsonEncoder.withIndent('  ')
        .convert(response.data)
        .split('\n')
        .map((line) => '  ║  $line')
        .join('\n');

    final statusMessage = _getStatusMessage(response.statusCode);

    ///----Log formatted message
    dev.log('''
  ╔══════════════════════════════════════════════════════════════════════════════════════════
  ║  Status: ${response.statusCode} - $statusMessage
  ║══════════════════════════════════════════════════════════════════════════════════════════
  ║  $apiName
  ║══════════════════════════════════════════════════════════════════════════════════════════
  ║  Request: 
$indentedRequest
  ║══════════════════════════════════════════════════════════════════════════════════════════
  ║  Response:
$indentedResponse
  ╚══════════════════════════════════════════════════════════════════════════════════════════
  ''');
  }

  ///----Helper method to map status codes to messages
  static String _getStatusMessage(int? statusCode) {
    switch (statusCode) {
      case 200:
        return "OK";
      case 201:
        return "Created";
      case 400:
        return "Bad Request";
      case 401:
        return "Unauthorized";
      case 403:
        return "Forbidden";
      case 404:
        return "Not Found";
      case 405:
        return "Method Not Allowed";
      case 429:
        return "Too Many Requests";
      case 500:
        return "Internal Server Error";
      case 502:
        return "Bad Gateway";
      case 503:
        return "Service Unavailable";
      case 504:
        return "Gateway Timeout";
      default:
        return "Unknown Status";
    }
  }
}
