import 'package:babiauto_app/core/api_client.dart';
import 'package:babiauto_app/core/token_storage.dart';
import 'package:flutter/material.dart';
import '../data/auth_repository.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameC = TextEditingController();
  final _emailC = TextEditingController();
  final _passC = TextEditingController();
  final _confirmC = TextEditingController();
  final AuthRepository _authRepo = AuthRepository(
    apiClient: ApiClient(),
    tokenStorage: TokenStorage(),
  );

  bool _loading = false;
  String? _error;
  bool _obscurePass = true;
  bool _obscureConfirm = true;

  void _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      final success = await _authRepo.register(
        _nameC.text,
        _emailC.text,
        _passC.text,
        _confirmC.text,
      );
      if (!mounted) return;

      if (success) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() => _error = "Registration failed");
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  InputDecoration _inputDecoration(
    String label,
    IconData icon, {
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.lightBlue.shade400),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Welcome header
                Icon(
                  Icons.directions_car,
                  size: 80,
                  color: Colors.lightBlue.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  "Welcome to BabiAuto!",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "Sign up to start your car rental journey",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey.shade400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Card container
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Name
                          TextFormField(
                            controller: _nameC,
                            decoration: _inputDecoration(
                              "Full Name",
                              Icons.person,
                            ),
                            validator: (v) =>
                                v!.isEmpty ? "Please enter your name" : null,
                          ),
                          const SizedBox(height: 16),

                          // Email
                          TextFormField(
                            controller: _emailC,
                            decoration: _inputDecoration(
                              "Email",
                              Icons.email_outlined,
                            ),
                            validator: (v) =>
                                v!.contains("@") ? null : "Enter valid email",
                          ),
                          const SizedBox(height: 16),

                          // Password
                          TextFormField(
                            controller: _passC,
                            obscureText: _obscurePass,
                            decoration: _inputDecoration(
                              "Password",
                              Icons.lock_outline,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePass
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.lightBlue.shade400,
                                ),
                                onPressed: () {
                                  setState(() => _obscurePass = !_obscurePass);
                                },
                              ),
                            ),
                            validator: (v) =>
                                v!.length < 6 ? "At least 6 characters" : null,
                          ),
                          const SizedBox(height: 16),

                          // Confirm Password
                          TextFormField(
                            controller: _confirmC,
                            obscureText: _obscureConfirm,
                            decoration: _inputDecoration(
                              "Confirm Password",
                              Icons.lock_reset,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirm
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.lightBlue.shade400,
                                ),
                                onPressed: () {
                                  setState(
                                    () => _obscureConfirm = !_obscureConfirm,
                                  );
                                },
                              ),
                            ),
                            validator: (v) => v != _passC.text
                                ? "Passwords do not match"
                                : null,
                          ),
                          const SizedBox(height: 20),

                          // Error Message
                          if (_error != null)
                            Text(
                              _error!,
                              style: const TextStyle(color: Colors.red),
                            ),

                          // Register Button
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _loading ? null : _register,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue.shade400,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 6,
                              ),
                              child: _loading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      "Register",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () => Navigator.pushReplacementNamed(
                              context,
                              '/login',
                            ),
                            child: Text(
                              "Already have an account? Login",
                              style: TextStyle(
                                color: Colors.lightBlue.shade400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
