import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioService {
  static Future<Dio> setupDio() async {

    Dio dio = Dio();

    BaseOptions options = await _createBaseOption();

    dio = Dio(options);

    // debugPrint('============= onRequest ============= ${dio.options.baseUrl}');

    DateTime responseTime = DateTime.now();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions? option, handler) async {
          responseTime = DateTime.now();
          debugPrint('============= onRequest =============');
          handler.next(option!);
        },
        onResponse: (Response response, handler) async {
          // debugPrint('DateTime ${DateTime.now().toString()}');
          // debugPrint(
          //     'responseTime ${DateTime.now().difference(responseTime).inMilliseconds}ms');
          // debugPrint('method ${response.requestOptions.method}');
          // debugPrint(
          //     'API ${response.requestOptions.uri.origin}${response.requestOptions.uri.path}');
          // debugPrint('responseData ${response.data}');
          debugPrint('============= onResponse =============');
          debugPrint('${response.headers['link']?.first}');
          handler.next(response);
        },
        onError: (DioError e, handler) async {
          // debugPrint('DateTime ${DateTime.now().toString()}');
          // debugPrint(
          //     'responseTime ${DateTime.now().difference(responseTime).inMilliseconds}ms');
          // debugPrint('method ${e.requestOptions.method}');
          // debugPrint(
          //     'API ${e.requestOptions.uri.origin}${e.requestOptions.uri.path}');
          // debugPrint('responseData ${e.response}');
          debugPrint('============= onError =============');

          handler.next(e);
        },
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        compact: true,
        maxWidth: 500,
      ),
    );

    return dio;
  }

  static Future<BaseOptions> _createBaseOption() async {
    String baseUrl = r'https://api.github.com/';

    var options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 90).inMilliseconds,
        receiveTimeout: const Duration(seconds: 90).inMilliseconds,
        sendTimeout: const Duration(seconds: 90).inMilliseconds,
        headers: {}
    );
    return options;
  }
}