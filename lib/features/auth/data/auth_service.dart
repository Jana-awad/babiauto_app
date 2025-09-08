import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthService {
  final bool mock;
  AuthService({this.mock = true});

  Future<String> login(String email, String password) async {
    if (mock) {
      await Future.delayed(const Duration(seconds: 1));
      if (email == 'test@example.com' && password == 'password') {
        return 'mock-jwt-token';
      } else {
        throw Exception('Invalid credentials');
      }
    }
    // Later, replace with real API call
    return '';
  }

  Future<String?> register(String name, String email, String password) async {
    // Mocked register
    await Future.delayed(const Duration(seconds: 1));
    if (email.contains("@")) {
      return "new_user_token"; // pretend success
    }
    return null; // fail if email is invalid
  }


}

