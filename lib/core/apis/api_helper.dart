import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:movie_app_task/core/apis/api_base.dart';
import 'package:movie_app_task/core/apis/dio_client.dart';
import 'package:movie_app_task/core/apis/api_logger.dart';

enum HttpMethod { get, post, delete }

class ApiHelper {
  ///--------------------///
  ///----Validate URL----///
  ///--------------------///
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);

      // Ensure scheme, authority, and valid host or IP
      return uri.isAbsolute &&
          (uri.scheme == 'http' || uri.scheme == 'https') &&
          uri.host.isNotEmpty &&
          (RegExp(r'^(\d{1,3}\.){3}\d{1,3}$').hasMatch(uri.host) ||
              uri.host.contains('.')) &&
          (uri.hasPort ? uri.port > 0 && uri.port <= 65535 : true);
    } catch (e) {
      return false;
    }
  }

  ///----------------------///
  ///----Handle Request----///
  ///----------------------///
  static Future<void> request({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? body,
    required Function(Response) onSuccess,
    required Function(String) onFailure,
  }) async {
    String fullUrl = '${Environment.baseUrl()}$url';

    if (!isValidUrl(fullUrl)) {
      onFailure("Invalid URL : $fullUrl");
      return;
    }

    try {
      Response response;
      final options = Options(
        headers: {
          'Accept': 'application/json; charset=UTF-8',
          'Content-type': 'application/json',
          "Authorization":
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3OTU3YjkxZmJiZjkzOTEwZmY0MDA2ZTY5Y2M0NWQyMCIsIm5iZiI6MTczOTcwMDAxNi4yMzEsInN1YiI6IjY3YjFiNzMwYmUxMTM1YzFkODZkYjRhYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.12rCVmL_Ftniw39QTlJqu6hCYxzaWmkBwrQjfB2dbAU',
          'Accept-Language': 'en',
        },
      );

      switch (method) {
        case HttpMethod.get:
          response = await dioClient.dio.get(fullUrl, options: options);
          break;
        case HttpMethod.post:
          response = await dioClient.dio
              .post(fullUrl, data: jsonEncode(body), options: options);
          break;
        case HttpMethod.delete:
          response = await dioClient.dio.delete(fullUrl, options: options);
          break;
        default:
          throw Exception("Unsupported HTTP method");
      }

      ApiLogger.log(
        response: response,
        apiName: "${method.name.toUpperCase()}: $fullUrl",
        requestBody: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess(response);
      } else {
        onFailure("Error: ${response.statusMessage ?? "Unknown error"}");
      }
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        ApiLogger.log(
            response: dioError.response!, apiName: "${method.name}: $fullUrl");
        onFailure(dioError.response!.statusMessage ?? "Request failed");
      } else {
        onFailure(dioError.message ?? "Unexpected error");
      }
    } catch (error) {
      onFailure("An error occurred: ${error.toString()}");
    }
  }
}
