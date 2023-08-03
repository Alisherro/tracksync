import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:smerse/data/models/user.dart';

abstract class UsersDataProvider {
  Future<List<User>> getUsersList(String filter);
}

class MockUsersDataProvider extends UsersDataProvider {
  @override
  Future<List<User>> getUsersList(String filter) async {
    final String jsonString =
        await rootBundle.loadString('assets/mock_json/mock_users.json');
    List<dynamic> jsonData = jsonDecode(jsonString);
    List<User> users = jsonData.map((json) => User.fromJson(json)).toList();
    return users;
  }
}
