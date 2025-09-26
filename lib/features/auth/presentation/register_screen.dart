// // // lib/features/auth/presentation/register_screen.dart
// import 'package:flutter/material.dart';
// import '../data/auth_repository.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameC = TextEditingController();
//   final _emailC = TextEditingController();
//   final _passC = TextEditingController();
//   final _confirmC = TextEditingController();
//   final AuthRepository _authRepo = AuthRepository();
//   bool _loading = false;
//   String? _error;

//   void _register() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => _loading = true);
//     try {
//       final success = await _authRepo.register(
//         _nameC.text,
//         _emailC.text,
//         _passC.text,
//         _confirmC.text,
//       );
//       if (!mounted) return;
//       if (success) {
//         Navigator.pushReplacementNamed(context, '/home');
//       } else {
//         setState(() => _error = "Registration failed");
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
//             colors: [Colors.blueAccent, Colors.indigo],
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft,
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
//               child: Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       const Text(
//                         "Register",
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       TextFormField(
//                         controller: _nameC,
//                         decoration: const InputDecoration(
//                           labelText: "Name",
//                           prefixIcon: Icon(Icons.person),
//                         ),
//                         validator: (v) => v!.isEmpty ? "Enter name" : null,
//                       ),
//                       const SizedBox(height: 12),
//                       TextFormField(
//                         controller: _emailC,
//                         decoration: const InputDecoration(
//                           labelText: "Email",
//                           prefixIcon: Icon(Icons.email),
//                         ),
//                         validator: (v) =>
//                             v!.contains("@") ? null : "Enter valid email",
//                       ),
//                       const SizedBox(height: 12),
//                       TextFormField(
//                         controller: _passC,
//                         decoration: const InputDecoration(
//                           labelText: "Password",
//                           prefixIcon: Icon(Icons.lock),
//                         ),
//                         obscureText: true,
//                         validator: (v) =>
//                             v!.length < 6 ? "At least 6 chars" : null,
//                       ),
//                       const SizedBox(height: 12),
//                       TextFormField(
//                         controller: _confirmC,
//                         decoration: const InputDecoration(
//                           labelText: "Confirm Password",
//                           prefixIcon: Icon(Icons.lock_outline),
//                         ),
//                         obscureText: true,
//                         validator: (v) =>
//                             v != _passC.text ? "Passwords don’t match" : null,
//                       ),
//                       const SizedBox(height: 20),
//                       if (_error != null)
//                         Text(
//                           _error!,
//                           style: const TextStyle(color: Colors.red),
//                         ),
//                       _loading
//                           ? const CircularProgressIndicator()
//                           : ElevatedButton(
//                               onPressed: _register,
//                               child: const Text("Register"),
//                             ),
//                       TextButton(
//                         onPressed: () =>
//                             Navigator.pushReplacementNamed(context, '/login'),
//                         child: const Text("Already have an account? Login"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// lib/features/auth/presentation/register_screen.dart
// import 'package:flutter/material.dart';
// import '../data/auth_repository.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameC = TextEditingController();
//   final _emailC = TextEditingController();
//   final _passC = TextEditingController();
//   final _confirmC = TextEditingController();
//   final AuthRepository _authRepo = AuthRepository();
//   bool _loading = false;
//   String? _error;

//   void _register() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => _loading = true);

//     try {
//       final success = await _authRepo.register(
//         _nameC.text,
//         _emailC.text,
//         _passC.text,
//         _confirmC.text,
//       );
//       if (!mounted) return;

//       if (success) {
//         Navigator.pushReplacementNamed(context, '/home');
//       } else {
//         setState(() => _error = "Registration failed");
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
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.green.shade600, Colors.yellow.shade600],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               elevation: 10,
//               child: Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Text(
//                         "Create Account",
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.green,
//                         ),
//                       ),
//                       const SizedBox(height: 20),

//                       // Name
//                       TextFormField(
//                         controller: _nameC,
//                         decoration: const InputDecoration(
//                           labelText: "Full Name",
//                           prefixIcon: Icon(Icons.person),
//                         ),
//                         validator: (v) =>
//                             v!.isEmpty ? "Please enter your name" : null,
//                       ),
//                       const SizedBox(height: 12),

//                       // Email
//                       TextFormField(
//                         controller: _emailC,
//                         decoration: const InputDecoration(
//                           labelText: "Email",
//                           prefixIcon: Icon(Icons.email),
//                         ),
//                         validator: (v) =>
//                             v!.contains("@") ? null : "Enter valid email",
//                       ),
//                       const SizedBox(height: 12),

//                       // Password
//                       TextFormField(
//                         controller: _passC,
//                         decoration: const InputDecoration(
//                           labelText: "Password",
//                           prefixIcon: Icon(Icons.lock),
//                         ),
//                         obscureText: true,
//                         validator: (v) =>
//                             v!.length < 6 ? "At least 6 characters" : null,
//                       ),
//                       const SizedBox(height: 12),

//                       // Confirm Password
//                       TextFormField(
//                         controller: _confirmC,
//                         decoration: const InputDecoration(
//                           labelText: "Confirm Password",
//                           prefixIcon: Icon(Icons.lock_outline),
//                         ),
//                         obscureText: true,
//                         validator: (v) =>
//                             v != _passC.text ? "Passwords do not match" : null,
//                       ),
//                       const SizedBox(height: 20),

//                       // Error Message
//                       if (_error != null)
//                         Text(
//                           _error!,
//                           style: const TextStyle(color: Colors.red),
//                         ),

//                       // Register Button
//                       const SizedBox(height: 12),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: _loading ? null : _register,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: _loading
//                               ? const CircularProgressIndicator(
//                                   color: Colors.white,
//                                 )
//                               : const Text(
//                                   "Register",
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                         ),
//                       ),

//                       const SizedBox(height: 12),
//                       TextButton(
//                         onPressed: () =>
//                             Navigator.pushReplacementNamed(context, '/login'),
//                         child: const Text(
//                           "Already have an account? Login",
//                           style: TextStyle(color: Colors.green),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import '../data/auth_repository.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameC = TextEditingController();
//   final _emailC = TextEditingController();
//   final _passC = TextEditingController();
//   final _confirmC = TextEditingController();
//   final AuthRepository _authRepo = AuthRepository();
//   bool _loading = false;
//   String? _error;

//   void _register() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => _loading = true);

//     try {
//       final success = await _authRepo.register(
//         _nameC.text,
//         _emailC.text,
//         _passC.text,
//         _confirmC.text,
//       );
//       if (!mounted) return;

//       if (success) {
//         Navigator.pushReplacementNamed(context, '/home');
//       } else {
//         setState(() => _error = "Registration failed");
//       }
//     } catch (e) {
//       setState(() => _error = e.toString());
//     } finally {
//       setState(() => _loading = false);
//     }
//   }

//   InputDecoration _inputDecoration(String label, IconData icon) {
//     return InputDecoration(
//       labelText: label,
//       prefixIcon: Icon(icon, color: Colors.lightBlue.shade400),
//       filled: true,
//       fillColor: Colors.grey.shade100,
//       contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 // App logo / header
//                 Icon(
//                   Icons.person_add_alt_1,
//                   size: 80,
//                   color: Colors.lightBlue.shade400,
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   "Create Your Account",
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blueGrey.shade700,
//                   ),
//                 ),
//                 const SizedBox(height: 24),

//                 // Card container
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(18),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         children: [
//                           // Name
//                           TextFormField(
//                             controller: _nameC,
//                             decoration: _inputDecoration(
//                               "Full Name",
//                               Icons.person,
//                             ),
//                             validator: (v) =>
//                                 v!.isEmpty ? "Please enter your name" : null,
//                           ),
//                           const SizedBox(height: 16),

//                           // Email
//                           TextFormField(
//                             controller: _emailC,
//                             decoration: _inputDecoration(
//                               "Email",
//                               Icons.email_outlined,
//                             ),
//                             validator: (v) =>
//                                 v!.contains("@") ? null : "Enter valid email",
//                           ),
//                           const SizedBox(height: 16),

//                           // Password
//                           TextFormField(
//                             controller: _passC,
//                             obscureText: true,
//                             decoration: _inputDecoration(
//                               "Password",
//                               Icons.lock_outline,
//                             ),
//                             validator: (v) =>
//                                 v!.length < 6 ? "At least 6 characters" : null,
//                           ),
//                           const SizedBox(height: 16),

//                           // Confirm Password
//                           TextFormField(
//                             controller: _confirmC,
//                             obscureText: true,
//                             decoration: _inputDecoration(
//                               "Confirm Password",
//                               Icons.lock_reset,
//                             ),
//                             validator: (v) => v != _passC.text
//                                 ? "Passwords do not match"
//                                 : null,
//                           ),
//                           const SizedBox(height: 20),

//                           // Error Message
//                           if (_error != null)
//                             Text(
//                               _error!,
//                               style: const TextStyle(color: Colors.red),
//                             ),

//                           // Register Button
//                           const SizedBox(height: 16),
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: _loading ? null : _register,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.lightBlue.shade400,
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 16,
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(14),
//                                 ),
//                                 elevation: 6,
//                               ),
//                               child: _loading
//                                   ? const CircularProgressIndicator(
//                                       color: Colors.white,
//                                     )
//                                   : const Text(
//                                       "Register",
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                             ),
//                           ),

//                           const SizedBox(height: 16),
//                           TextButton(
//                             onPressed: () => Navigator.pushReplacementNamed(
//                               context,
//                               '/login',
//                             ),
//                             child: Text(
//                               "Already have an account? Login",
//                               style: TextStyle(
//                                 color: Colors.lightBlue.shade400,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
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
  final AuthRepository _authRepo = AuthRepository();

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
