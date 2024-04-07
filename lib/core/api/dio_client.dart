import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracksync/core/core.dart';
import '../../utils/services/services.dart';

class DioClient with SentryCrashLogger {
  DioClient(this.sharedPreferences);
  String? _token;
  final SharedPreferences sharedPreferences;


  Dio get _dio {
    _token = sharedPreferences.getString('token');
    final dio = _createDio();
    dio.interceptors.add(DioInterceptor());

    return dio;
  }

  Dio _createDio() {
    return Dio(
      BaseOptions(
        baseUrl: ListAPI.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (_token != null) ...{
            'Authorization': _token,
          },
        },
        receiveTimeout: const Duration(minutes: 1),
        connectTimeout: const Duration(minutes: 1),
        validateStatus: (int? status) {
          return status! > 0;
        },
      ),
    );
  }

  Future<Either<Failure, T>> getRequest<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic response) converter,
    bool isIsolate = true,
  }) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      if (!isIsolate) {
        return Right(converter(response.data));
      }
      final isolateParse = IsolateParser<T>(
        response.data as Map<String, dynamic>,
        converter,
      );
      final result = await isolateParse.parseInBackground();
      return Right(result);
    } on DioException catch (e, stackTrace) {
      nonFatalError(error: e, stackTrace: stackTrace);
      return Left(
        ServerFailure(
          e.response?.data['error'] as String? ?? e.message,
        ),
      );
    }
  }

  Future<Either<Failure, T>> postRequest<T>(
    String url, {
    Map<String, dynamic>? data,
    required T Function(dynamic response) converter,
    bool isIsolate = true,
  }) async {
    try {
      final response = await _dio.post(url, data: data);
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      if (!isIsolate) {
        return Right(converter(response.data));
      }
      final isolateParse = IsolateParser<T>(
        response.data as Map<String, dynamic>,
        converter,
      );
      final result = await isolateParse.parseInBackground();
      return Right(result);
    } on DioException catch (e, stackTrace) {
      nonFatalError(error: e, stackTrace: stackTrace);

      return Left(
        ServerFailure(
          e.response?.data['error'] as String? ?? e.message,
        ),
      );
    }
  }
}
