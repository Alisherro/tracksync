import 'package:tracksync/features/auth/domain/entities/login.dart';

import '../../domain/entities/user.dart';

class LoginResponse {
  const LoginResponse({required this.token, required this.user});

  final String token;
  final User user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json["access_token"],
      user: User.fromJson(json["data"],
      ),
    );
  }

  Login toEntity() => Login(token, user);

}
