class Register {
  Register(this._token);

  final String _token;

  String get token => _token;
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
