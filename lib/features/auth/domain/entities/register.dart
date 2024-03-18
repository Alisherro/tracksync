class Register {
  Register(this._token);

  final String _token;

  String get token => _token;
}

class RegisterParams {
  RegisterParams({required this.email, required this.password});

  final String email;
  final String password;

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}
