import '../../domain/entities/register.dart';
import '../../domain/entities/user.dart';

class RegisterResponse {
  const RegisterResponse({
    required this.token,
    required this.user,
  });

  final String token;
  final User user;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      token: json["access_token"],
      user: User.fromJson(json["data"])
    );
  }


  Register toEntity() {
    return Register(token,user);
  }
}
