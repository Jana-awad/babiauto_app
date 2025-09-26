import 'dart:convert';
import 'package:babiauto_app/core/api_client.dart';
import 'package:babiauto_app/core/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http; // FIX: Import http

class AuthRepository {
  final ApiClient apiClient = ApiClient();
  final TokenStorage tokenStorage = TokenStorage();

  // LOGIN
  Future<bool> login(String email, String password) async {
    try {
      final response = await apiClient.post('login', {
        'email': email,
        'password': password,
      });

      if (response['token'] != null) {
        await tokenStorage.saveToken(response['token']);
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // REGISTER
  Future<bool> register(
    String name,
    String email,
    String password,
    String passwordConfirm,
  ) async {
    try {
      final response = await apiClient.post('register', {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirm,
      });

      if (response['token'] != null) {
        await tokenStorage.saveToken(response['token']);
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await tokenStorage.clearToken();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('cached_user'); // clear cached profile
  }

  // GET CURRENT TOKEN
  Future<String?> currentToken() async {
    return tokenStorage.getToken();
  }

  // GET CURRENT USER (with offline caching)
  Future<Map<String, dynamic>?> currentUser() async {
    final token = await currentToken();
    if (token == null) return null;

    try {
      final response = await apiClient.get('profile', token: token);

      // Cache locally for offline use
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('cached_user', json.encode(response));

      return response;
    } catch (e) {
      // If API fails, return cached data
      return await currentUserCached();
    }
  }

  // GET CURRENT USER FROM CACHE
  Future<Map<String, dynamic>?> currentUserCached() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString('cached_user');
    if (cached != null) {
      return Map<String, dynamic>.from(json.decode(cached));
    }
    return null;
  }

  // UPDATE PROFILE
  Future<Map<String, dynamic>?> updateProfile({
    String? name,
    String? email,
  }) async {
    final token = await currentToken();
    if (token == null) throw Exception('No token found');

    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (email != null) data['email'] = email;

      final response = await apiClient.put('profile', data, token: token);

      // Update cached profile
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('cached_user', json.encode(response));

      return response;
    } catch (e) {
      throw Exception('Profile update failed: $e');
    }
  }

  // SAVE DEVICE TOKEN (for push notifications)
  Future<void> saveDeviceToken(String fcmToken) async {
    final token = await currentToken(); // get auth token
    if (token == null) throw Exception("Not authenticated");

    final response = await http.post(
      Uri.parse(
        "http://192.168.10.100:8000/api/save-device-token",
      ), // 🔹 Replace with your backend URL
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // 🔹 Pass user token for auth:sanctum
      },
      body: jsonEncode({"token": fcmToken}),
    );

    if (response.statusCode == 200) {
      print("✅ FCM Token saved successfully");
    } else {
      print("❌ Failed to save FCM token: ${response.body}");
    }
  }
}
