import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tracksync/core/core.dart';
import '../../utils/services/services.dart';

class DioClient with SentryCrashLogger {
  DioClient();

  String? _token;

  Dio get _dio {
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
      Failure? failure;

      if (e.response?.statusCode == 401) {
        failure = const UnauthenticatedFailure();
      }

      String? errorMessage = e.message;
      if (e.response?.data['error'] != null) {
        errorMessage = e.response?.data['error'] as String? ?? e.message;
      }
      else if (e.response?.data['errors'] != null) {
        var errors = e.response?.data['errors'] as Map<String, dynamic>;
        var errorMessages = <String>[];
        errors.forEach((key, value) {
          value.forEach((msg) {
            errorMessages.add(msg as String);
          });
        });
        errorMessage = errorMessages.join('\n');
      }

      return Left(
        failure ??
            ServerFailure(
              errorMessage,
            ),
      );
    }
  }

  Future<Either<Failure, T>> postRequest<T>(
    String url, {
    Object? data,
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
      String? errorMessage = e.message;
      if (e.response?.data['error'] != null) {
        errorMessage = e.response?.data['error'] as String? ?? e.message;
      }
      else if (e.response?.data['errors'] != null) {
        var errors = e.response?.data['errors'] as Map<String, dynamic>;
        var errorMessages = <String>[];
        errors.forEach((key, value) {
          value.forEach((msg) {
            errorMessages.add(msg as String);
          });
        });
        errorMessage = errorMessages.join('\n');
      }
      return Left(
            ServerFailure(
              errorMessage,
            ),
      );
    }
  }

  Future<Either<Failure, T>> patchRequest<T>(
    String url, {
    Object? data,
    required T Function(dynamic response) converter,
    bool isIsolate = true,
  }) async {
    try {
      final response = await _dio.patch(url, data: data);
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
      String? errorMessage = e.message;
      if (e.response?.data['error'] != null) {
        errorMessage = e.response?.data['error'] as String? ?? e.message;
      }
      else if (e.response?.data['errors'] != null) {
        var errors = e.response?.data['errors'] as Map<String, dynamic>;
        var errorMessages = <String>[];
        errors.forEach((key, value) {
          value.forEach((msg) {
            errorMessages.add(msg as String);
          });
        });
        errorMessage = errorMessages.join('\n');
      }
      return Left(
        ServerFailure(
          errorMessage,
        ),
      );
    } on FormatException catch(e, stackTrace){
      return  Left(FormatFailure(e.toString()));
    }
  }



  Future<Either<Failure, T>> deleteRequest<T>(
      String url, {
        Object? data,
        required T Function(dynamic response) converter,
        bool isIsolate = true,
      }) async {
    try {
      final response = await _dio.delete(url, data: data);
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
      String? errorMessage = e.message;
      if (e.response?.data['error'] != null) {
        errorMessage = e.response?.data['error'] as String? ?? e.message;
      }
      else if (e.response?.data['errors'] != null) {
        var errors = e.response?.data['errors'] as Map<String, dynamic>;
        var errorMessages = <String>[];
        errors.forEach((key, value) {
          value.forEach((msg) {
            errorMessages.add(msg as String);
          });
        });
        errorMessage = errorMessages.join('\n');
      }
      return Left(
        ServerFailure(
          errorMessage,
        ),
      );
    }
  }
}
