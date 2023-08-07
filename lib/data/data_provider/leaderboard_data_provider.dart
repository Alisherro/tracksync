import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tracksync/data/models/user.dart';

abstract class LeaderboardDataProvider {
  Future<List<User>> getUsersList(String filter);
}

class MockUsersDataProvider extends LeaderboardDataProvider {
  @override
  Future<List<User>> getUsersList(String filter) async {
    final String jsonString =
        await rootBundle.loadString('assets/mock_json/mock_users.json');
    List<dynamic> jsonData = jsonDecode(jsonString);
    List<User> users = jsonData.map((json) => User.fromJson(json)).toList();
    return users;
  }
}
