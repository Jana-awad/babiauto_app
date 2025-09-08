import 'auth_service.dart';
// Update the import path if the file exists elsewhere, for example:
import '/core/token_storage.dart';
// Or create the file at lib/features/auth/core/token_storage.dart if it does not exist.

class AuthRepository {
  final AuthService _service = AuthService();
  final TokenStorage _storage = TokenStorage();

  Future<String> loginAndStore(String email, String password) async {
    final token = await _service.login(email, password);
    await _storage.saveToken(token);
    return token;
  }
  Future<bool> register(String name, String email, String password) async {
    final token = await _service.register(name, email, password);
    if (token != null) {
      await _storage.saveToken(token);
      return true;
    }
    return false;
  }


  Future<void> logout() async {
    await _storage.clearToken();
  }

  Future<String?> currentToken() => _storage.getToken();
}
