// import 'package:flutter/material.dart';
// import '../../auth/data/auth_repository.dart';
// import '../../vehicles/presentation/vehicle_list_screen.dart'; // <-- import the vehicle list screen

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('BabiAuto Home'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () async {
//               await AuthRepository().logout();
//               if (!context.mounted) return;
//               Navigator.pushReplacementNamed(context, '/login');
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Welcome to BabiAuto 🚗',
//               style: TextStyle(fontSize: 24),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const VehicleListScreen()),
//                 );
//               },
//               child: const Text('View Vehicles'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import '../../auth/data/auth_repository.dart';
// import '../../vehicles/presentation/vehicle_list_screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         elevation: 0,
//         title: const Text('BabiAuto'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () async {
//               await AuthRepository().logout();
//               if (!context.mounted) return;
//               Navigator.pushReplacementNamed(context, '/login');
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 40),
//             const Icon(Icons.directions_car, size: 100, color: Colors.indigo),
//             const SizedBox(height: 20),
//             const Text(
//               'Welcome to BabiAuto ',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.indigo,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'Find the best cars for rent at your fingertips',
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.black54, fontSize: 16),
//             ),
//             const SizedBox(height: 40),
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 32,
//                   vertical: 16,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const VehicleListScreen()),
//                 );
//               },
//               icon: const Icon(Icons.directions_car),
//               label: const Text(
//                 'View Vehicles',
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// // }
// import 'package:babiauto_app/features/profile/data/presentation/profile_screen.dart';
// import 'package:flutter/material.dart';
// import '../../auth/data/auth_repository.dart';
// import '../../vehicles/presentation/vehicle_list_screen.dart';
// import '../../bookings/presentation/booking_history_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final AuthRepository _authRepo = AuthRepository();
//   String? _userName;

//   @override
//   void initState() {
//     super.initState();
//     _loadUser();
//   }

//   Future<void> _loadUser() async {
//     final user = await _authRepo.currentUser();
//     setState(() {
//       _userName = user?['name'] ?? "User";
//     });
//   }

//   Future<void> _logout() async {
//     await _authRepo.logout();
//     if (!mounted) return;
//     Navigator.pushReplacementNamed(context, '/login');
//   }

//   Widget _buildMenuCard({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//     Color? color,
//   }) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       elevation: 3,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(16),
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             color: color ?? Colors.white,
//           ),
//           child: Row(
//             children: [
//               Icon(icon, size: 40, color: Colors.green.shade700),
//               const SizedBox(width: 20),
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green.shade50,
//       appBar: AppBar(
//         backgroundColor: Colors.green.shade600,
//         title: Text("Welcome, ${_userName ?? ''}"),
//         actions: [
//           IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
//         ],
//       ),
//       body: ListView(
//         children: [
//           const SizedBox(height: 30),
//           Center(
//             child: Column(
//               children: [
//                 const Icon(
//                   Icons.directions_car,
//                   size: 100,
//                   color: Colors.green,
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "BabiAuto",
//                   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "Your trusted car rental app",
//                   style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 30),

//           // Menu Items
//           _buildMenuCard(
//             icon: Icons.directions_car,
//             title: "Browse Vehicles",
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const VehicleListScreen()),
//               );
//             },
//           ),
//           _buildMenuCard(
//             icon: Icons.book_online,
//             title: "My Bookings",
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const BookingHistoryScreen()),
//               );
//             },
//           ),
//           _buildMenuCard(
//             icon: Icons.person,
//             title: "Profile",
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const ProfileScreen()),
//               );
//             },
//           ),
//           _buildMenuCard(
//             icon: Icons.logout,
//             title: "Logout",
//             onTap: _logout,
//             color: Colors.red.shade50,
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:babiauto_app/features/profile/data/presentation/profile_screen.dart';
// import 'package:flutter/material.dart';
// import '../../auth/data/auth_repository.dart';
// import '../../vehicles/presentation/vehicle_list_screen.dart';
// import '../../bookings/presentation/booking_history_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final AuthRepository _authRepo = AuthRepository();
//   String? _userName;

//   @override
//   void initState() {
//     super.initState();
//     _loadUser();
//   }

//   Future<void> _loadUser() async {
//     final user = await _authRepo.currentUser();
//     setState(() {
//       _userName = user?['name'] ?? "User";
//     });
//   }

//   Future<void> _logout() async {
//     await _authRepo.logout();
//     if (!mounted) return;
//     Navigator.pushReplacementNamed(context, '/login');
//   }

//   Widget _buildMenuCard({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//     Color? color,
//   }) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       elevation: 5,
//       shadowColor: Colors.grey.shade300,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: color ?? Colors.white,
//           ),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.lightBlue.shade100,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(icon, size: 30, color: Colors.lightBlue.shade700),
//               ),
//               const SizedBox(width: 20),
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Icon(
//                 Icons.arrow_forward_ios,
//                 size: 18,
//                 color: Colors.grey.shade500,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       body: Column(
//         children: [
//           // Header
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.lightBlue.shade600, Colors.lightBlue.shade400],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.shade400,
//                   offset: const Offset(0, 3),
//                   blurRadius: 6,
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Welcome,",
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.9),
//                     fontSize: 20,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   _userName ?? '',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   "Your trusted car rental app",
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.8),
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 30),

//           // Menu Items
//           Expanded(
//             child: ListView(
//               children: [
//                 _buildMenuCard(
//                   icon: Icons.directions_car,
//                   title: "Browse Vehicles",
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const VehicleListScreen(),
//                       ),
//                     );
//                   },
//                 ),
//                 _buildMenuCard(
//                   icon: Icons.book_online,
//                   title: "My Bookings",
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const BookingHistoryScreen(),
//                       ),
//                     );
//                   },
//                 ),
//                 _buildMenuCard(
//                   icon: Icons.person,
//                   title: "Profile",
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const ProfileScreen()),
//                     );
//                   },
//                 ),
//                 _buildMenuCard(
//                   icon: Icons.logout,
//                   title: "Logout",
//                   onTap: _logout,
//                   color: Colors.red.shade50,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:babiauto_app/features/profile/data/presentation/profile_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart'; // ✅ import
// import '../../auth/data/auth_repository.dart';
// import '../../vehicles/presentation/vehicle_list_screen.dart';
// import '../../bookings/presentation/booking_history_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final AuthRepository _authRepo = AuthRepository();
//   String? _userName;

//   @override
//   void initState() {
//     super.initState();
//     _loadUser();
//     _initPushNotifications(); // ✅ initialize FCM
//   }

//   Future<void> _loadUser() async {
//     final user = await _authRepo.currentUser();
//     setState(() {
//       _userName = user?['name'] ?? "User";
//     });
//   }

//   Future<void> _initPushNotifications() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;

//     // Request permission (iOS mainly, Android auto-grants)
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('✅ Push notifications allowed');

//       // Get FCM token for this device
//       String? token = await messaging.getToken();
//       print('🔑 Device FCM Token: $token');
//       // Send token to backend
//       if (token != null) {
//         await _authRepo.saveDeviceToken(token);
//       }
//       // TODO: send token to your Laravel backend to store for this user
//     } else {
//       print('❌ Push notifications not allowed');
//     }

//     // Handle foreground messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print(
//         "📩 Message received in foreground: ${message.notification?.title}",
//       );

//       // Show a snackbar for example
//       if (mounted && message.notification != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               "${message.notification!.title}: ${message.notification!.body}",
//             ),
//             duration: const Duration(seconds: 3),
//           ),
//         );
//       }
//     });

//     // Handle notification when the app is opened via tapping
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("🚀 Notification tapped: ${message.notification?.title}");
//       // You can navigate to a specific screen based on message data
//     });
//   }

//   Future<void> _logout() async {
//     await _authRepo.logout();
//     if (!mounted) return;
//     Navigator.pushReplacementNamed(context, '/login');
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }

//   Widget _buildMenuCard({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//     Color? color,
//   }) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       elevation: 5,
//       shadowColor: Colors.grey.shade300,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: color ?? Colors.white,
//           ),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.lightBlue.shade100,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(icon, size: 30, color: Colors.lightBlue.shade700),
//               ),
//               const SizedBox(width: 20),
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Icon(
//                 Icons.arrow_forward_ios,
//                 size: 18,
//                 color: Colors.grey.shade500,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       body: Column(
//         children: [
//           // Header
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.lightBlue.shade600, Colors.lightBlue.shade400],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.shade400,
//                   offset: const Offset(0, 3),
//                   blurRadius: 6,
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Welcome,",
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.9),
//                     fontSize: 20,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   _userName ?? '',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   "Your trusted car rental app",
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.8),
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 30),

//           // Menu Items
//           Expanded(
//             child: ListView(
//               children: [
//                 _buildMenuCard(
//                   icon: Icons.directions_car,
//                   title: "Browse Vehicles",
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const VehicleListScreen(),
//                       ),
//                     );
//                   },
//                 ),
//                 _buildMenuCard(
//                   icon: Icons.book_online,
//                   title: "My Bookings",
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const BookingHistoryScreen(),
//                       ),
//                     );
//                   },
//                 ),
//                 _buildMenuCard(
//                   icon: Icons.person,
//                   title: "Profile",
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const ProfileScreen()),
//                     );
//                   },
//                 ),
//                 _buildMenuCard(
//                   icon: Icons.logout,
//                   title: "Logout",
//                   onTap: _logout,
//                   color: Colors.red.shade50,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:babiauto_app/features/profile/data/presentation/profile_screen.dart';
import 'package:babiauto_app/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../auth/data/auth_repository.dart';
import '../../vehicles/presentation/vehicle_list_screen.dart';
import '../../bookings/presentation/booking_history_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthRepository _authRepo = AuthRepository();
  String? _userName;

  @override
  void initState() {
    super.initState();
    _loadUser();
    _initPushNotifications();
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final screen = message.data['screen'];
        if (!mounted) return;

        switch (screen) {
          case 'booking':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BookingHistoryScreen()),
            );
            break;

          case 'vehicles':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const VehicleListScreen()),
            );
            break;

          case 'profile':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
            break;

          default:
            print("No navigation defined for screen: $screen");
            break;
        }
      }
    });
  }

  Future<void> _loadUser() async {
    final user = await _authRepo.currentUser();
    setState(() {
      _userName = user?['name'] ?? "User";
    });
  }

  // Future<void> _initPushNotifications() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;

  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('✅ Push notifications allowed');
  //     String? token = await messaging.getToken();
  //     print('🔑 Device FCM Token: $token');
  //     if (token != null) {
  //       await _authRepo.saveDeviceToken(token);
  //     }
  //   } else {
  //     print('❌ Push notifications not allowed');
  //   }

  //   // Foreground messages
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print(
  //       "📩 Message received in foreground: ${message.notification?.title}",
  //     );
  //     if (mounted && message.notification != null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //             "${message.notification!.title}: ${message.notification!.body}",
  //           ),
  //           duration: const Duration(seconds: 3),
  //         ),
  //       );
  //     }
  //   });

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     final screen = message.data['screen'];
  //     if (!mounted) return;

  //     switch (screen) {
  //       case 'booking':
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (_) => const BookingHistoryScreen()),
  //         );
  //         break;
  //       case 'vehicles':
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (_) => const VehicleListScreen()),
  //         );
  //         break;
  //       case 'profile':
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (_) => const ProfileScreen()),
  //         );
  //         break;
  //       default:
  //         break;
  //     }
  //   });
  // }
  // Future<void> _initPushNotifications() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;

  //   // Request permissions
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('✅ Push notifications allowed');
  //     String? token = await messaging.getToken();
  //     print('🔑 Device FCM Token: $token');
  //     if (token != null) {
  //       await _authRepo.saveDeviceToken(token);
  //     }
  //   } else {
  //     print('❌ Push notifications not allowed');
  //   }

  //   // Initialize flutter_local_notifications
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin
  //       >()
  //       ?.createNotificationChannel(channel);

  //   const InitializationSettings initializationSettings =
  //       InitializationSettings(
  //         android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  //       );

  //   await flutterLocalNotificationsPlugin.initialize(
  //     initializationSettings,
  //     onDidReceiveNotificationResponse: (NotificationResponse response) {
  //       _handleMessageNavigation(response.payload);
  //     },
  //   );

  //   // Foreground messages
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print(
  //       "📩 Message received in foreground: ${message.notification?.title}",
  //     );

  //     if (message.notification != null) {
  //       flutterLocalNotificationsPlugin.show(
  //         message.hashCode,
  //         message.notification!.title,
  //         message.notification!.body,
  //         NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             channel.id,
  //             channel.name,
  //             channelDescription: channel.description,
  //             icon: '@mipmap/ic_launcher',
  //           ),
  //         ),
  //         payload: message.data['screen'], // pass the screen name
  //       );
  //     }
  //   });

  //   // Background & terminated messages
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     _handleMessageNavigation(message.data['screen']);
  //   });

  //   // Handle terminated state
  //   FirebaseMessaging.instance.getInitialMessage().then((message) {
  //     if (message != null) {
  //       _handleMessageNavigation(message.data['screen']);
  //     }
  //   });
  // }

  // // Centralized navigation handler
  // void _handleMessageNavigation(String? screen) {
  //   if (!mounted || screen == null) return;

  //   switch (screen) {
  //     case 'booking':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (_) => const BookingHistoryScreen()),
  //       );
  //       break;
  //     case 'vehicles':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (_) => const VehicleListScreen()),
  //       );
  //       break;
  //     case 'profile':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (_) => const ProfileScreen()),
  //       );
  //       break;
  //     default:
  //       print("No navigation defined for screen: $screen");
  //       break;
  //   }
  // }
  Future<void> _initPushNotifications() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // 1️⃣ Request permissions
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('✅ Push notifications allowed');
      String? token = await messaging.getToken();
      print('🔑 Device FCM Token: $token');
      if (token != null) {
        await _authRepo.saveDeviceToken(token);
      }
    } else {
      print('❌ Push notifications not allowed');
    }

    // 2️⃣ Initialize flutter_local_notifications
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _handleMessageNavigation(response.payload);
      },
    );

    // 3️⃣ Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
        "📩 Message received in foreground: ${message.notification?.title}",
      );

      if (message.notification != null) {
        flutterLocalNotificationsPlugin.show(
          message.hashCode,
          message.notification!.title,
          message.notification!.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: '@mipmap/ic_launcher',
            ),
          ),
          payload: message.data['screen'], // pass the screen name
        );
      }
    });

    // 4️⃣ Background messages (app opened via notification)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("🚀 Notification tapped (background): ${message.data['screen']}");
      _handleMessageNavigation(message.data['screen']);
    });

    // 5️⃣ Terminated state (app opened via notification)
    // FirebaseMessaging.instance.getInitialMessage().then((
    //   RemoteMessage? message,
    // ) {
    //   if (message != null && message.data['screen'] != null) {
    //     print("🚀 Notification tapped (terminated): ${message.data['screen']}");
    //     // Ensure navigation after widget build
    //     WidgetsBinding.instance.addPostFrameCallback((_) {
    //       _handleMessageNavigation(message.data['screen']);
    //     });
    //   }
    // });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null && message.data['screen'] != null) {
        print("🚀 Notification tapped (terminated): ${message.data['screen']}");
        _handleMessageNavigation(
          message.data['screen'],
        ); // safe via navigatorKey
      }
    });
  }

  // Centralized navigation handler
  // void _handleMessageNavigation(String? screen) {
  //   print('Navigating to screen: $screen'); // Debug
  //   if (!mounted || screen == null) return;

  //   switch (screen) {
  //     case 'booking':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (_) => const BookingHistoryScreen()),
  //       );
  //       break;
  //     case 'vehicles':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (_) => const VehicleListScreen()),
  //       );
  //       break;
  //     case 'profile':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (_) => const ProfileScreen()),
  //       );
  //       break;
  //     default:
  //       print("No navigation defined for screen: $screen");
  //       break;
  //   }
  // }
  void _handleMessageNavigation(String? screen) {
    print('Navigating to screen: $screen'); // Debug
    if (screen == null) return;

    switch (screen) {
      case 'booking':
        navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (_) => const BookingHistoryScreen()),
        );
        break;
      case 'vehicles':
        navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (_) => const VehicleListScreen()),
        );
        break;
      case 'profile':
        navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (_) => const ProfileScreen()),
        );
        break;
      default:
        print("No navigation defined for screen: $screen");
        break;
    }
  }

  Future<void> _logout() async {
    await _authRepo.logout();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      shadowColor: Colors.grey.shade300,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color ?? Colors.white,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 30, color: Colors.lightBlue.shade700),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightBlue.shade600, Colors.lightBlue.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  offset: const Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome,",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _userName ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Your trusted car rental app",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Menu Items
          Expanded(
            child: ListView(
              children: [
                _buildMenuCard(
                  icon: Icons.directions_car,
                  title: "Browse Vehicles",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const VehicleListScreen(),
                      ),
                    );
                  },
                ),
                _buildMenuCard(
                  icon: Icons.book_online,
                  title: "My Bookings",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BookingHistoryScreen(),
                      ),
                    );
                  },
                ),
                _buildMenuCard(
                  icon: Icons.person,
                  title: "Profile",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    );
                  },
                ),
                _buildMenuCard(
                  icon: Icons.logout,
                  title: "Logout",
                  onTap: _logout,
                  color: Colors.red.shade50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // name
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);
