import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracksync/utils/utils.dart';

import '../../dependencies_injection.dart';

class DioInterceptor extends Interceptor with SentryCrashLogger {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    StringBuffer headerMessage = StringBuffer();
    SharedPreferences preferences = sl<SharedPreferences>();
    final String? token = preferences.getString('token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }


    try {
      String bodyMessage = '';
      if (options.data is FormData) {
        options.headers["Content-Type"]="multipart/form-data";
        FormData formData = options.data as FormData;
        StringBuffer formDataFields = StringBuffer();
        formData.fields.forEach((element) => formDataFields.writeln('Field: ${element.key} Value: ${element.value}'));
        formData.files.forEach((element) => formDataFields.writeln('File: ${element.key} Filename: ${element.value.filename}'));
        bodyMessage = 'FormData with fields: \n$formDataFields';
      } else {
        const JsonEncoder encoder = JsonEncoder.withIndent('  ');
        bodyMessage = encoder.convert(options.data);
      }
      options.headers.forEach((k, v) => headerMessage.writeln('► $k: $v'));
      StringBuffer queryParamsMessage = StringBuffer();
      options.queryParameters.forEach((k, v) => queryParamsMessage.writeln('► $k: $v'));

      log.d(
          "REQUEST ► ︎ ${options.method.toUpperCase()} ${options.baseUrl}${options.path}\n\n"
              "Headers:\n$headerMessage\n"
              "QueryParameters:\n$queryParamsMessage\n"
              "Body:\n$bodyMessage"
      );
    } catch (e, stackTrace) {
      log.e("Failed to extract json request $e");
      nonFatalError(error: e, stackTrace: stackTrace);
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException dioException, ErrorInterceptorHandler handler) {
    log.e(
      "<-- ${dioException.message} ${dioException.response?.requestOptions != null ? (dioException.response!.requestOptions.baseUrl + dioException.response!.requestOptions.path) : 'URL'}\n\n"
      "${dioException.response != null ? dioException.response!.data : 'Unknown Error'}",
    );

    nonFatalError(error: dioException, stackTrace: dioException.stackTrace);
    super.onError(dioException, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String headerMessage = "";
    response.headers.forEach((k, v) => headerMessage += '► $k: $v\n');

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final String prettyJson = encoder.convert(response.data);
    log.d(
      // ignore: unnecessary_null_comparison
      "◀ ︎RESPONSE ${response.statusCode} ${response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL'}\n\n"
      "Headers:\n"
      "$headerMessage\n"
      "❖ Results : \n"
      "Response: $prettyJson",
    );
    super.onResponse(response, handler);
  }
}
