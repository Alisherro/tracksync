import 'package:tracksync/features/auth/domain/entities/user.dart';

class Register {
  Register(this._token, this._user);

  final String _token;
  final User _user;

  String get token => _token;

  User get user =>_user;

}

class RegisterParams {
  RegisterParams({required this.email, required this.password, required this.name});

  final String name;
  final String email;
  final String password;

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
    };
  }
}
