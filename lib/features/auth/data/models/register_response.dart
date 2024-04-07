import '../../domain/entities/register.dart';

class RegisterResponse {
  const RegisterResponse({
    required this.token,
  });

  final String token;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "token": token,
    };
  }

  Register toEntity() {
    return Register(token);
  }
}
