// // // lib/main.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'features/auth/presentation/splash_screen.dart';
// import 'features/auth/presentation/login_screen.dart';
// import 'features/auth/presentation/register_screen.dart';
// import 'features/home/presentation/home_screen.dart';

// void main() {
//   runApp(const ProviderScope(child: BabiAutoApp()));
// }

// class BabiAutoApp extends StatelessWidget {
//   const BabiAutoApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'BabiAuto',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
//         inputDecorationTheme: InputDecorationTheme(
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//           filled: true,
//           fillColor: Colors.grey[100],
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             minimumSize: const Size(double.infinity, 48),
//           ),
//         ),
//       ),
//       initialRoute: '/register',
//       routes: {
//         '/splash': (_) => const SplashScreen(),
//         '/login': (_) => const LoginScreen(),
//         '/register': (_) => const RegisterScreen(),
//         '/home': (_) => const HomeScreen(),
//       },
//     );
//   }
// }
import 'package:babiauto_app/features/bookings/presentation/booking_history_screen.dart';
import 'package:babiauto_app/features/profile/data/presentation/profile_screen.dart';
import 'package:babiauto_app/features/vehicles/presentation/vehicle_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/auth/presentation/splash_screen.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/auth/presentation/register_screen.dart';
import 'features/home/presentation/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling background message: ${message.messageId}");
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token = await messaging.getToken();
  print('FCM Token: $token');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const BabiAutoApp());
}

// void main() {
//   runApp(const ProviderScope(child: BabiAutoApp()));
// }

// class BabiAutoApp extends StatelessWidget {
//   const BabiAutoApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'BabiAuto',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         scaffoldBackgroundColor: const Color(0xFFF2F3F4), // light grey
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color(0xFF5DADE2), // light blue
//           brightness: Brightness.light,
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//           filled: true,
//           fillColor: Colors.white,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 14,
//           ),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF5DADE2),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             minimumSize: const Size(double.infinity, 48),
//           ),
//         ),
//         cardTheme: CardThemeData(
//           color: Colors.white,
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//         ),
//       ),
//       initialRoute: '/register',
//       routes: {
//         '/splash': (_) => const SplashScreen(),
//         '/login': (_) => LoginScreen(),
//         '/register': (_) => const RegisterScreen(),
//         '/home': (_) => const HomeScreen(),
//       },
//     );
//   }
// }
class BabiAutoApp extends StatefulWidget {
  const BabiAutoApp({super.key});

  @override
  State<BabiAutoApp> createState() => _BabiAutoAppState();
}

class _BabiAutoAppState extends State<BabiAutoApp> {
  String? _initialScreen;

  @override
  void initState() {
    super.initState();
    _checkInitialMessage();
  }

  Future<void> _checkInitialMessage() async {
    RemoteMessage? message = await FirebaseMessaging.instance
        .getInitialMessage();

    if (message != null && message.data['screen'] != null) {
      setState(() {
        _initialScreen =
            message.data['screen']; // e.g., 'booking', 'vehicles', 'profile'
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget home = const RegisterScreen(); // default screen

    // If launched from notification, navigate immediately
    if (_initialScreen != null) {
      switch (_initialScreen) {
        case 'booking':
          home = const HomeScreen(); // you can push Booking screen after home
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BookingHistoryScreen()),
            );
          });
          break;
        case 'vehicles':
          home = const HomeScreen();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const VehicleListScreen()),
            );
          });
          break;
        case 'profile':
          home = const HomeScreen();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          });
          break;
      }
    }

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'BabiAuto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF2F3F4),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5DADE2),
          brightness: Brightness.light,
        ),
      ),
      home: home,
      initialRoute: '/register',
      routes: {
        '/splash': (_) => const SplashScreen(),
        '/login': (_) => LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/home': (_) => const HomeScreen(),
      },
    );
  }
}
