import 'package:dio/dio.dart' as dio;
import 'package:flutter_bloc_boilerplate/core/service/app_service.dart';
import 'package:flutter_bloc_boilerplate/core/service/app_setting_service.dart';
import 'package:flutter_bloc_boilerplate/core/service/init_app_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../exceptions/app_http_exceptions.dart';

class AppApiService extends AppService {
  late dio.Dio _dio;
  AppSettingService appSettingService = getIt<AppSettingService>();

  AppApiService() {
    _dio = dio.Dio(dio.BaseOptions(baseUrl: appSettingService.config.baseURL));
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  Future<Map<String, dynamic>?> post(String path,
      {required Map<String, dynamic> data,
      Map<String, dynamic>? queryParameters,
      dio.Options? options}) async {
    dio.Response<Map> response = await _dio.post<Map>(path,
        data: data, queryParameters: queryParameters, options: options);
    if (response.data == null) return null;
    return Map<String, dynamic>.from(response.data!);
  }

  Future<Map<String, dynamic>?> get(String path,
      {required Map<String, dynamic> data,
      Map<String, dynamic>? queryParameters,
      dio.Options? options}) async {
    try {
      dio.Response<Map> response = await _dio.get<Map>(path,
          data: data, queryParameters: queryParameters, options: options);
      if (response.data == null) return null;
      return Map<String, dynamic>.from(response.data!);
    } on dio.DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  HttpException _handleDioError(dio.DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        return BadRequestException(null, e.response?.data);
      case 401:
        return UnauthorizedException(null, e.response?.data);
      case 403:
        return ForbiddenException(null, e.response?.data);
      case 404:
        return NotFoundException(null, e.response?.data);
      case 500:
        return InternalServerError(null, e.response?.data);
      case 502:
        return BadGatewayError(null, e.response?.data);
      case 503:
        return ServiceUnavailableError(null, e.response?.data);
      case 504:
        return GatewayTimeoutError(null, e.response?.data);

      default:
        return UnknownHttpException(
            'Unknown error: ${e.response?.statusCode}', e.response?.data);
    }
  }
}
