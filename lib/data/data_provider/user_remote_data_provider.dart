import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataProvider {
  Future<bool> register(String userName, String email, String password);

  Future<String> login(String userName, String password);
}

class UserHttpDataProvider extends UserRemoteDataProvider {
  static const String _baseUrl = 'http://192.168.1.227:8080/';

  @override
  Future<String> login(String userName, String password) async {
    final url = Uri.parse('${_baseUrl}auth');

    final body = {"username": userName, "password": password};

    final json = jsonEncode(body);

    final response = await http.post(url, body: json, headers: {
      'Content-Type': 'application/json',
    }).timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final String token = (jsonDecode(response.body) as Map)["token"];
      return token;
    } else {
      throw ErrorDescription(
          'error occurred, status code= ${response.statusCode}');
    }
  }

  @override
  Future<bool> register(String userName, String email, String password) async {
    final url = Uri.parse('${_baseUrl}registration');
    final body = {"username": userName, "password": password, "email": email};
    final json = jsonEncode(body);
    final response = await http.post(url, body: json, headers: {
      'Content-Type': 'application/json',
    }).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ErrorDescription(
          'error occurred, status code= ${response.statusCode}');
    }
  }
}
