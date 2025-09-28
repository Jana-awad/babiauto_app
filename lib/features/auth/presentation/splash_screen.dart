import 'package:babiauto_app/core/api_client.dart';
import 'package:babiauto_app/core/token_storage.dart';
import 'package:flutter/material.dart';
import '../../auth/data/auth_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthRepository _authRepo = AuthRepository(
    apiClient: ApiClient(),
    tokenStorage: TokenStorage(),
  );

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    final token = await _authRepo.currentToken();
    if (!mounted) return;
    if (token != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.directions_car, size: 100, color: Color(0xFF5DADE2)),
            SizedBox(height: 20),
            Text(
              "BabiAuto",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5DADE2),
              ),
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(color: Color(0xFF5DADE2)),
          ],
        ),
      ),
    );
  }
}
