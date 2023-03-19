import 'dart:convert';

import 'package:dio/dio.dart';

import '../utils/utils.dart';

class DioMethod {
  static Future<Map<String, dynamic>?> dioGet(Dio dioInstance, String url,
      {Map<String, dynamic> queryParams = const {}, String contentType = '', bool retryApiCall = false}) async {
    try {
      if (contentType.isNotEmpty) {
        dioInstance.options.contentType = contentType;
      }
      Response response = await dioInstance.get(url, queryParameters: queryParams);
      return response.data != null? response.data is Map ? response.data : jsonDecode(response.data) : null;
    } on DioError catch (error) {
      appLog("DIO ===> $error");
      if (error.response != null && error.response!.statusCode == 401) {
        return await dioGet(dioInstance, url, queryParams: queryParams, contentType: contentType);
      } else if (error.response != null && error.response!.statusCode == 400) {
        return error.response!.data != null ? error.response!.data is Map ? error.response!.data : jsonDecode(error.response!.data) : null;
      } else {
        if (retryApiCall) {
          appLog('Retrying Api call');
          return await dioGet(dioInstance, url, queryParams: queryParams, contentType: contentType);
        } else {
          return null;
        }
      }
    } catch (e) {
      appLog(e);
      if (retryApiCall) {
        appLog('Retrying Api call');
        return await dioGet(dioInstance, url, queryParams: queryParams, contentType: contentType);
      } else {
        return null;
      }
    }
  }

  static Future<Map<String, dynamic>?> dioPost(
      Dio dioInstance, String url, Map<String, dynamic> data,
      {Map<String, dynamic> queryParams = const {},
      String contentType = '',
      bool retryApiCall = false}) async {
    try {
      if (contentType.isNotEmpty) {
        dioInstance.options.contentType = contentType;
      }
      Response response = await dioInstance.post(url, data: jsonEncode(data), queryParameters: queryParams);
      return response.data != null ? response.data is Map ? response.data : jsonDecode(response.data) : null;
    } on DioError catch (error) {
      appLog(error);
      if (error.response != null && error.response!.statusCode == 401) {
        return await dioPost(dioInstance, url, data, queryParams: queryParams, contentType: contentType);
      } else if (error.response != null && error.response!.statusCode == 400) {
        return error.response!.data != null ? error.response!.data is Map ? error.response!.data : jsonDecode(error.response!.data) : null;
      } else {
        if (retryApiCall) {
          appLog('Retrying Api call');
          return await dioPost(dioInstance, url, data,
              queryParams: queryParams, contentType: contentType);
        } else {
          return null;
        }
      }
    } catch (e) {
      appLog(e);
      if (retryApiCall) {
        appLog('Retrying Api call');
        return await dioPost(dioInstance, url, data,
            queryParams: queryParams, contentType: contentType);
      } else {
        return null;
      }
    }
  }

  static Future<Map<String, dynamic>?> dioPut(
    Dio dioInstance,
    String url, {
    Map<String, dynamic> data = const {},
    Map<String, dynamic> queryParams = const {},
    String contentType = '',
    bool retryApiCall = false,
  }) async {
    try {
      if (contentType.isNotEmpty) {
        dioInstance.options.contentType = contentType;
      }
      Response response =
          await dioInstance.put(url, data: data, queryParameters: queryParams);

      return response.data != null
          ? response.data is Map
              ? response.data
              : jsonDecode(response.data)
          : null;
    } on DioError catch (error) {
      appLog(error);
      if (error.response != null && error.response!.statusCode == 401) {
        return await dioPut(dioInstance, url,
            data: data, queryParams: queryParams, contentType: contentType);
      } else if (error.response != null && error.response!.statusCode == 400) {
        return error.response!.data != null
            ? error.response!.data is Map
                ? error.response!.data
                : jsonDecode(error.response!.data)
            : null;
      } else {
        if (retryApiCall) {
          appLog('Retrying Api call');
          return await dioPut(dioInstance, url,
              data: data, queryParams: queryParams, contentType: contentType);
        } else {
          return null;
        }
      }
    } catch (e) {
      appLog(e);
      if (retryApiCall) {
        appLog('Retrying Api call');
        return await dioPut(dioInstance, url,
            data: data, queryParams: queryParams, contentType: contentType);
      } else {
        return null;
      }
    }
  }
}
