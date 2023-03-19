import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../app_secret/app_secret_config.dart';
import '../utils/utils.dart';

class LoggingInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.queryParameters['language'] = 'en-US';
    options.queryParameters['api_key'] = AppSecretConfig.instance.values.apiKey;
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    appLog('-----------New Api Call Start--------------');
    appLog('-------------REQUEST-----------------');
    appLog('<-Method->   ${response.requestOptions.method}');
    appLog('<-BaseUrl->  ${response.requestOptions.baseUrl}');
    appLog('<-Params->   ${response.requestOptions.queryParameters}');
    // appLog('<-Data-> Use Flipper to View Response');
    appLog('<-Path->     ${response.requestOptions.path}');
    appLog('<-Headers->  ${response.requestOptions.headers}');
    if (!kReleaseMode) {
      log('<-Headers Full-> <-${response.requestOptions.path}-> ${response.requestOptions.headers}');
    }
    appLog('<-Req Body->     ${response.requestOptions.data}');
    appLog('-------------RESPONSE----------------');
    if (!kReleaseMode) {
      log('<-Res Full Body-> <-${response.requestOptions.path}-> ${response.data.toString()}');
    }
    appLog('<-Res Body-> ${response.data.toString()}');
    appLog('-----------New Api Call End--------------');
    handler.next(response);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    appLog('<-Method-> ${err.requestOptions.method}');
    appLog('<-BaseUrl-> ${err.requestOptions.baseUrl}');
    appLog('<-Params-> ${err.requestOptions.queryParameters}');
    appLog('<-Req Body-> ${err.requestOptions.data}');
    appLog('<-Path-> ${err.requestOptions.path}');
    appLog('<-Headers-> ${err.requestOptions.headers}');
    if (!kReleaseMode) {
      log('<-Headers Full-> <-${err.requestOptions.path}-> ${err.requestOptions.headers}');
    }
    if (err.response != null && err.response!.statusCode != null) {
      // Due to EBP-151
      appLog("<-StatusCode-> ${err.response!.statusCode}");
      if (err.response!.statusCode == 422) {
        appLog("<-StatusCode-> ${err.response!.statusCode}");
        return null;
      }
    }
    handler.next(err);
  }
}
