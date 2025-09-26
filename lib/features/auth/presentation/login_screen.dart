// // // lib/features/auth/presentation/login_screen.dart
// import 'package:flutter/material.dart';
// import '../data/auth_repository.dart';
// import 'register_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _emailC = TextEditingController();
//   final _passC = TextEditingController();
//   final AuthRepository _authRepo = AuthRepository();
//   bool _loading = false;
//   String? _error;

//   Future<void> _login() async {
//     setState(() => _loading = true);
//     try {
//       final success = await _authRepo.login(_emailC.text, _passC.text);
//       if (!mounted) return;
//       if (success) {
//         Navigator.pushReplacementNamed(context, '/home');
//       } else {
//         setState(() => _error = "Invalid credentials");
//       }
//     } catch (e) {
//       setState(() => _error = e.toString());
//     } finally {
//       setState(() => _loading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.all(24),
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.indigo, Colors.blueAccent],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             elevation: 8,
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Text(
//                     "Login",
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 16),
//                   TextField(
//                     controller: _emailC,
//                     decoration: const InputDecoration(
//                       labelText: 'Email',
//                       prefixIcon: Icon(Icons.email),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   TextField(
//                     controller: _passC,
//                     decoration: const InputDecoration(
//                       labelText: 'Password',
//                       prefixIcon: Icon(Icons.lock),
//                     ),
//                     obscureText: true,
//                   ),
//                   const SizedBox(height: 20),
//                   if (_error != null)
//                     Text(_error!, style: const TextStyle(color: Colors.red)),
//                   _loading
//                       ? const CircularProgressIndicator()
//                       : ElevatedButton(
//                           onPressed: _login,
//                           child: const Text("Login"),
//                         ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const RegisterScreen(),
//                         ),
//                       );
//                     },
//                     child: const Text("Don’t have an account? Register"),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import '../../auth/data/auth_repository.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final AuthRepository _authRepo = AuthRepository();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _loading = false;
//   String? _error;

//   Future<void> _login() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() {
//       _loading = true;
//       _error = null;
//     });

//     final result = await _authRepo.login(
//       _emailController.text,
//       _passwordController.text,
//     );

//     if (result) {
//       if (!mounted) return;
//       Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       setState(() {
//         _error = "Invalid credentials. Please try again.";
//         _loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green.shade50,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Icon(Icons.directions_car, size: 80, color: Colors.green),
//             const SizedBox(height: 20),
//             const Text(
//               "Welcome Back 👋",
//               style: TextStyle(
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 6),
//             const Text(
//               "Login to continue using BabiAuto",
//               style: TextStyle(color: Colors.black54),
//             ),
//             const SizedBox(height: 30),

//             // Error message
//             if (_error != null)
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 margin: const EdgeInsets.only(bottom: 20),
//                 decoration: BoxDecoration(
//                   color: Colors.red.shade100,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(_error!, style: const TextStyle(color: Colors.red)),
//               ),

//             // Form
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   // Email
//                   TextFormField(
//                     controller: _emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       labelText: "Email",
//                       prefixIcon: const Icon(Icons.email, color: Colors.green),
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     validator: (val) =>
//                         val!.isEmpty ? "Please enter your email" : null,
//                   ),
//                   const SizedBox(height: 16),

//                   // Password
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: "Password",
//                       prefixIcon: const Icon(Icons.lock, color: Colors.green),
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     validator: (val) =>
//                         val!.isEmpty ? "Please enter your password" : null,
//                   ),
//                   const SizedBox(height: 24),

//                   // Login Button
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: _loading ? null : _login,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green.shade600,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: _loading
//                           ? const CircularProgressIndicator(color: Colors.white)
//                           : const Text(
//                               "Login",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Navigate to Register
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("Don’t have an account? "),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushReplacementNamed(context, '/register');
//                   },
//                   child: const Text(
//                     "Register",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// // }
// import 'package:flutter/material.dart';
// import '../../auth/data/auth_repository.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final AuthRepository _authRepo = AuthRepository();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _loading = false;
//   String? _error;

//   Future<void> _login() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() {
//       _loading = true;
//       _error = null;
//     });

//     final result = await _authRepo.login(
//       _emailController.text,
//       _passwordController.text,
//     );

//     if (result) {
//       if (!mounted) return;
//       Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       setState(() {
//         _error = "Invalid credentials. Please try again.";
//         _loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green.shade50,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Icon(Icons.directions_car, size: 80, color: Colors.green),
//             const SizedBox(height: 20),
//             const Text(
//               "Welcome Back 👋",
//               style: TextStyle(
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 6),
//             const Text(
//               "Login to continue using BabiAuto",
//               style: TextStyle(color: Colors.black54),
//             ),
//             const SizedBox(height: 30),

//             // Error message
//             if (_error != null)
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 margin: const EdgeInsets.only(bottom: 20),
//                 decoration: BoxDecoration(
//                   color: Colors.red.shade100,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(_error!, style: const TextStyle(color: Colors.red)),
//               ),

//             // Form
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   // Email
//                   TextFormField(
//                     controller: _emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       labelText: "Email",
//                       prefixIcon: const Icon(Icons.email, color: Colors.green),
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     validator: (val) =>
//                         val!.isEmpty ? "Please enter your email" : null,
//                   ),
//                   const SizedBox(height: 16),

//                   // Password
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: "Password",
//                       prefixIcon: const Icon(Icons.lock, color: Colors.green),
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     validator: (val) =>
//                         val!.isEmpty ? "Please enter your password" : null,
//                   ),
//                   const SizedBox(height: 24),

//                   // Login Button
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: _loading ? null : _login,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green.shade600,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: _loading
//                           ? const CircularProgressIndicator(color: Colors.white)
//                           : const Text(
//                               "Login",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Navigate to Register
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("Don’t have an account? "),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushReplacementNamed(context, '/register');
//                   },
//                   child: const Text(
//                     "Register",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import '../../auth/data/auth_repository.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final AuthRepository _authRepo = AuthRepository();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _loading = false;
//   String? _error;

//   Future<void> _login() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() {
//       _loading = true;
//       _error = null;
//     });

//     final result = await _authRepo.login(
//       _emailController.text,
//       _passwordController.text,
//     );

//     if (result) {
//       if (!mounted) return;
//       Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       setState(() {
//         _error = "Invalid credentials. Please try again.";
//         _loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF2F3F4),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Icon(
//               Icons.directions_car,
//               size: 80,
//               color: Color(0xFF5DADE2),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "Welcome Back ",
//               style: TextStyle(
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 6),
//             const Text(
//               "Login to continue using BabiAuto",
//               style: TextStyle(color: Colors.black54),
//             ),
//             const SizedBox(height: 30),
//             if (_error != null)
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 margin: const EdgeInsets.only(bottom: 20),
//                 decoration: BoxDecoration(
//                   color: Colors.red.shade100,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(_error!, style: const TextStyle(color: Colors.red)),
//               ),
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: _emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       labelText: "Email",
//                       prefixIcon: const Icon(
//                         Icons.email,
//                         color: Color(0xFF5DADE2),
//                       ),
//                     ),
//                     validator: (val) =>
//                         val!.isEmpty ? "Please enter your email" : null,
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: "Password",
//                       prefixIcon: const Icon(
//                         Icons.lock,
//                         color: Color(0xFF5DADE2),
//                       ),
//                     ),
//                     validator: (val) =>
//                         val!.isEmpty ? "Please enter your password" : null,
//                   ),
//                   const SizedBox(height: 24),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: _loading ? null : _login,
//                       child: _loading
//                           ? const CircularProgressIndicator(color: Colors.white)
//                           : const Text(
//                               "Login",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("Don’t have an account? "),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushReplacementNamed(context, '/register');
//                   },
//                   child: const Text(
//                     "Register",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF5DADE2),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import '../../auth/data/auth_repository.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _authRepo = AuthRepository();

//   bool _loading = false;
//   String? _error;

//   Future<void> _login() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() {
//       _loading = true;
//       _error = null;
//     });

//     try {
//       final result = await _authRepo.login(
//         _emailController.text.trim(),
//         _passwordController.text.trim(),
//       );

//       if (result) {
//         if (!mounted) return;
//         Navigator.pushReplacementNamed(context, '/home');
//       } else {
//         setState(() {
//           _error = "Invalid credentials. Please try again.";
//           _loading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _error = "Login failed: $e";
//         _loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Card(
//             color: Colors.white,
//             elevation: 5,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(24),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.lock, size: 70, color: Colors.lightBlue),
//                     const SizedBox(height: 16),
//                     Text(
//                       "Login",
//                       style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.lightBlue[800],
//                       ),
//                     ),
//                     const SizedBox(height: 24),

//                     // Email field
//                     TextFormField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                         labelText: "Email",
//                         prefixIcon: Icon(Icons.email, color: Colors.lightBlue),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       validator: (value) => value == null || value.isEmpty
//                           ? "Enter your email"
//                           : null,
//                     ),
//                     const SizedBox(height: 16),

//                     // Password field
//                     TextFormField(
//                       controller: _passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         labelText: "Password",
//                         prefixIcon: Icon(Icons.lock, color: Colors.lightBlue),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       validator: (value) => value == null || value.isEmpty
//                           ? "Enter your password"
//                           : null,
//                     ),
//                     const SizedBox(height: 20),

//                     // Error message
//                     if (_error != null)
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 12),
//                         child: Text(
//                           _error!,
//                           style: TextStyle(color: Colors.red, fontSize: 14),
//                         ),
//                       ),

//                     // Login button
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: _loading ? null : _login,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.lightBlue,
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: _loading
//                             ? CircularProgressIndicator(color: Colors.white)
//                             : const Text(
//                                 "Login",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.white,
//                                 ),
//                               ),

//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
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
