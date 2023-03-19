import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../app_secret/app_secret_config.dart';
import '../values/app_constants.dart';
import 'logging_interceptor.dart';

class DioManager {
  static const int _maxLineWidth = 90;
  static final BaseOptions _options = BaseOptions(
      connectTimeout: AppConstants.dioConnectionTimeout,
      receiveTimeout: AppConstants.dioReceiveTimeout,
      sendTimeout: AppConstants.dioSendTimeout);
  static final _prettyDioLogger = PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: _maxLineWidth);
  static final _loggingInterceptor = LoggingInterceptor();
  static Dio? _instance;

  static Dio get httpDio {
    _options.baseUrl = AppSecretConfig.instance.values.baseUrl;
    if (_instance == null) {
      _instance = Dio(_options);
      _instance!.interceptors.add(_prettyDioLogger);
      _instance!.interceptors.add(_loggingInterceptor);
      return _instance!;
    } else {
      _instance!.interceptors.clear();
      _instance!.interceptors.add(_prettyDioLogger);
      _instance!.interceptors.add(_loggingInterceptor);

      return _instance!;
    }
  }
}
