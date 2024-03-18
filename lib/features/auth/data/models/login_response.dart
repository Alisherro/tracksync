import 'package:tracksync/features/auth/domain/entities/login.dart';

import '../../domain/entities/user.dart';

class LoginResponse {
  const LoginResponse(
      {required this.id,
      required this.token,
      required this.error,
      required this.user});

  final String id;
  final String token;
  final String error;
  final User user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        id: json["id"],
        token: json["token"],
        error: json["error"],
        user: json["user"]);
  }

  Login toEntity() => Login(token, user);

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "token": this.token,
      "error": this.error,
      "user": this.user,
    };
  }
}
