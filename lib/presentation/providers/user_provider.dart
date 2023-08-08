import 'package:flutter/cupertino.dart';
import 'package:tracksync/data/models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  set user(User? value) {
    _user = value;
    notifyListeners();
  }

}
