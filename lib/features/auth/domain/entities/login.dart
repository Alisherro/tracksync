import 'user.dart';

class Login {
  Login(this._token, this._user);

  final String _token;
  final User _user;

  String get token => _token;

  User get user => _user;
}

class LoginParams {
  LoginParams({required this.email, required this.password});

  final String email;
  final String password;

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}
