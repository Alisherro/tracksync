import 'package:tracksync/domain/repositories/user_repository.dart';

class UserUseCase {
  UserUseCase(UserRepository userRepository) : _userRepository = userRepository;
  final UserRepository _userRepository;

  Future<bool> register(String userName, String email, String password) async {
    return await _userRepository.register(userName, email, password);
  }

  Future<String> login(String userName, String password) async {
    return await _userRepository.login(userName, password);
  }
}
