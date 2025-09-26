// // lib/features/auth/presentation/splash_screen.dart
// import 'package:flutter/material.dart';
// import '../data/auth_repository.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   final AuthRepository _authRepo = AuthRepository();

//   @override
//   void initState() {
//     super.initState();
//     _checkLogin();
//   }

//   Future<void> _checkLogin() async {
//     try {
//       final token = await _authRepo.currentToken();
//       await Future.delayed(const Duration(milliseconds: 600));
//       if (!mounted) return;

//       if (token != null) {
//         Navigator.pushReplacementNamed(context, '/home');
//       } else {
//         Navigator.pushReplacementNamed(context, '/login');
//       }
//     } catch (e) {
//       // fallback to login if any error occurs
//       if (!mounted) return;
//       Navigator.pushReplacementNamed(context, '/login');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(body: Center(child: CircularProgressIndicator()));
//   }
// }
// import 'package:flutter/material.dart';
// import '../data/auth_repository.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   final AuthRepository _authRepo = AuthRepository();

//   @override
//   void initState() {
//     super.initState();
//     _checkLogin();
//   }

//   Future<void> _checkLogin() async {
//     try {
//       final token = await _authRepo.currentToken();
//       await Future.delayed(const Duration(seconds: 2)); // for animation
//       if (!mounted) return;

//       if (token != null) {
//         Navigator.pushReplacementNamed(context, '/home');
//       } else {
//         Navigator.pushReplacementNamed(context, '/login');
//       }
//     } catch (e) {
//       if (!mounted) return;
//       Navigator.pushReplacementNamed(context, '/login');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.indigo,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Icon(Icons.directions_car, size: 100, color: Colors.white),
//             SizedBox(height: 20),
//             Text(
//               "BabiAuto",
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 30),
//             CircularProgressIndicator(color: Colors.white),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import '../data/auth_repository.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   final AuthRepository _authRepo = AuthRepository();

//   @override
//   void initState() {
//     super.initState();
//     _checkLogin();
//   }

//   Future<void> _checkLogin() async {
//     try {
//       final token = await _authRepo.currentToken();
//       await Future.delayed(const Duration(seconds: 2)); // splash delay
//       if (!mounted) return;

//       if (token != null) {
//         Navigator.pushReplacementNamed(context, '/home');
//       } else {
//         Navigator.pushReplacementNamed(context, '/register');
//       }
//     } catch (e) {
//       if (!mounted) return;
//       Navigator.pushReplacementNamed(context, '/register');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF4CAF50), Color(0xFF81C784)], // green gradient
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Icon(Icons.directions_car_filled, size: 110, color: Colors.white),
//               SizedBox(height: 20),
//               Text(
//                 "BabiAuto",
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   letterSpacing: 1.5,
//                 ),
//               ),
//               SizedBox(height: 30),
//               CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// lib/features/auth/presentation/splash_screen.dart

// import 'package:flutter/material.dart';
// import '../data/auth_repository.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   final AuthRepository _authRepo = AuthRepository();

//   @override
//   void initState() {
//     super.initState();
//     _checkLogin();
//   }

//   Future<void> _checkLogin() async {
//     await Future.delayed(const Duration(seconds: 2)); // Animation time
//     final token = await _authRepo.currentToken();
//     if (!mounted) return;
//     if (token != null) {
//       Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       Navigator.pushReplacementNamed(context, '/login');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.directions_car, size: 100, color: Colors.lightBlue[300]),
//             const SizedBox(height: 20),
//             Text(
//               "BabiAuto",
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.lightBlue[300],
//               ),
//             ),
//             const SizedBox(height: 30),
//             const CircularProgressIndicator(color: Colors.lightBlue),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../auth/data/auth_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthRepository _authRepo = AuthRepository();

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
