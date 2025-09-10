import 'package:babiauto_app/core/api_client.dart';
import 'package:babiauto_app/core/token_storage.dart';


class AuthRepository {
  final ApiClient apiClient = ApiClient();
  final TokenStorage tokenStorage = TokenStorage();

  Future<bool> login(String email, String password) async {
    try {
      final response = await apiClient.post('login', {'email': email, 'password': password});
      if (response['token'] != null) {
        await tokenStorage.saveToken(response['token']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      final response = await apiClient.post('register', {'name': name, 'email': email, 'password': password});
      if (response['token'] != null) {
        await tokenStorage.saveToken(response['token']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Register failed: $e');
    }
  }

  Future<void> logout() async {
    await tokenStorage.clearToken();
  }

  Future<String?> currentToken() async {
    return tokenStorage.getToken();
  }
}
