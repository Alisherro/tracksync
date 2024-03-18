import 'package:tracksync/features/auth/auth.dart';

class RegisterResponse {
  const RegisterResponse({
    required this.id,
    required this.token,
    required this.error,
  });

  final String id;
  final String token;
  final String error;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      id: json["id"],
      token: json["token"],
      error: json["error"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "token": this.token,
      "error": this.error,
    };
  }

  Register toEntity() {
    return Register(token);
  }
}
