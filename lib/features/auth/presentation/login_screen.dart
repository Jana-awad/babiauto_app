import 'package:flutter/material.dart';
import '../data/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authRepo = AuthRepository();

  bool _loading = false;
  String? _error;
  bool _obscurePassword = true;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final result = await _authRepo.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (result) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _error = "Invalid credentials. Please try again.";
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = "Login failed: $e";
        _loading = false;
      });
    }
  }

  InputDecoration _inputDecoration(
    String label,
    IconData icon, {
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.lightBlue),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            color: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock, size: 70, color: Colors.lightBlue),
                    const SizedBox(height: 16),
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Login to continue to BabiAuto",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey.shade400,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Email field
                    TextFormField(
                      controller: _emailController,
                      decoration: _inputDecoration("Email", Icons.email),
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter your email"
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // Password field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: _inputDecoration(
                        "Password",
                        Icons.lock,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.lightBlue,
                          ),
                          onPressed: () {
                            setState(
                              () => _obscurePassword = !_obscurePassword,
                            );
                          },
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter your password"
                          : null,
                    ),
                    const SizedBox(height: 20),

                    // Error message
                    if (_error != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          _error!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Register link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(
                            context,
                            '/register',
                          ),
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.lightBlue.shade400,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
