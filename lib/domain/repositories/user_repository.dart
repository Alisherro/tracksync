abstract class UserRepository {
  Future<bool> register(String userName, String email, String password);

  Future<String> login(String userName, String password);
}
