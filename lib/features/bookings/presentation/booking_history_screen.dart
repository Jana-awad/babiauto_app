// import 'package:flutter/material.dart';
// import '../../auth/data/auth_repository.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class BookingHistoryScreen extends StatefulWidget {
//   const BookingHistoryScreen({super.key});

//   @override
//   State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
// }

// class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
//   final AuthRepository _authRepo = AuthRepository();
//   bool _loading = true;
//   List<dynamic> _bookings = [];
//   String? _error;

//   @override
//   void initState() {
//     super.initState();
//     _fetchBookings();
//   }

//   Future<void> _fetchBookings() async {
//     setState(() => _loading = true);
//     final user = await _authRepo.currentUser();
//     if (user == null) {
//       setState(() {
//         _error = 'You must be logged in';
//         _loading = false;
//       });
//       return;
//     }

//     final url = Uri.parse(
//       'http://10.0.2.2:8000/api/users/${user['id']}/bookings',
//     );

//     try {
//       final response = await http.get(
//         url,
//         headers: {'Authorization': 'Bearer ${await _authRepo.currentToken()}'},
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           _bookings = json.decode(response.body);
//           _loading = false;
//         });
//       } else {
//         setState(() {
//           _error = 'Failed to load bookings';
//           _loading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _error = e.toString();
//         _loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('My Bookings')),
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : _error != null
//           ? Center(child: Text('Error: $_error'))
//           : _bookings.isEmpty
//           ? const Center(child: Text('No bookings yet'))
//           : ListView.builder(
//               itemCount: _bookings.length,
//               itemBuilder: (context, index) {
//                 final booking = _bookings[index];
//                 return Card(
//                   margin: const EdgeInsets.all(8),
//                   child: ListTile(
//                     title: Text(booking['vehicle_name']),
//                     subtitle: Text(
//                       '${booking['start_date']} → ${booking['end_date']}\nTotal: \$${booking['total_price']}',
//                     ),
//                     trailing: Text(booking['status']),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../auth/data/auth_repository.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class BookingHistoryScreen extends StatefulWidget {
//   const BookingHistoryScreen({super.key});

//   @override
//   State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
// }

// class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
//   final AuthRepository _authRepo = AuthRepository();
//   bool _loading = true;
//   List<dynamic> _bookings = [];
//   String? _error;

//   @override
//   void initState() {
//     super.initState();
//     _fetchBookings();
//   }

//   Future<void> _fetchBookings() async {
//     setState(() => _loading = true);
//     final user = await _authRepo.currentUser();
//     if (user == null) {
//       setState(() {
//         _error = 'You must be logged in';
//         _loading = false;
//       });
//       return;
//     }

//     final url = Uri.parse(
//       'http://10.0.2.2:8000/api/users/${user['id']}/bookings',
//     );

//     try {
//       final response = await http.get(
//         url,
//         headers: {'Authorization': 'Bearer ${await _authRepo.currentToken()}'},
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         setState(() {
//           _bookings = data;
//           _loading = false;
//         });
//       } else {
//         setState(() {
//           _error = 'Failed to load bookings';
//           _loading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _error = e.toString();
//         _loading = false;
//       });
//     }
//   }

//   String _getVehicleName(Map<String, dynamic> booking) {
//     final vehicle = booking['vehicle'];
//     if (vehicle == null) return 'Unknown Vehicle';
//     final make = vehicle['make'] ?? '';
//     final model = vehicle['model'] ?? '';
//     return '$make $model'.trim();
//   }

//   String _formatDate(String? date) {
//     if (date == null) return 'N/A';
//     try {
//       final parsed = DateTime.parse(date);
//       return DateFormat('MMM d, yyyy').format(parsed);
//     } catch (_) {
//       return date;
//     }
//   }

//   Color _statusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'pending':
//         return Colors.orange;
//       case 'confirmed':
//         return Colors.green;
//       case 'cancelled':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('My Bookings')),
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : _error != null
//           ? Center(child: Text('Error: $_error'))
//           : _bookings.isEmpty
//           ? const Center(child: Text('No bookings yet'))
//           : ListView.builder(
//               padding: const EdgeInsets.all(12),
//               itemCount: _bookings.length,
//               itemBuilder: (context, index) {
//                 final booking = _bookings[index];
//                 final vehicleName = _getVehicleName(booking);
//                 final start = _formatDate(booking['start_date']);
//                 final end = _formatDate(booking['end_date']);
//                 final status = booking['status'] ?? 'unknown';
//                 final price = booking['total_price'] ?? '0.00';

//                 return Card(
//                   elevation: 3,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   margin: const EdgeInsets.symmetric(vertical: 8),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               vehicleName,
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.indigo,
//                               ),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 8,
//                                 vertical: 4,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: _statusColor(status).withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Text(
//                                 status.toUpperCase(),
//                                 style: TextStyle(
//                                   color: _statusColor(status),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 12),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'From:',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(start),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'To:',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(end),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Total',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text('\$$price'),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
// lib/features/bookings/presentation/booking_history_screen.dart
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../auth/data/auth_repository.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class BookingHistoryScreen extends StatefulWidget {
//   const BookingHistoryScreen({super.key});

//   @override
//   State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
// }

// class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
//   final AuthRepository _authRepo = AuthRepository();
//   bool _loading = true;
//   List<dynamic> _bookings = [];
//   String? _error;

//   @override
//   void initState() {
//     super.initState();
//     _fetchBookings();
//   }

//   Future<void> _fetchBookings() async {
//     setState(() => _loading = true);
//     final user = await _authRepo.currentUser();
//     if (user == null) {
//       setState(() {
//         _error = 'You must be logged in';
//         _loading = false;
//       });
//       return;
//     }

//     final url = Uri.parse(
//       'http://192.168.10.100:8000/api/users/${user['id']}/bookings',
//     );

//     try {
//       final response = await http.get(
//         url,
//         headers: {'Authorization': 'Bearer ${await _authRepo.currentToken()}'},
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         setState(() {
//           _bookings = data;
//           _loading = false;
//         });
//       } else {
//         setState(() {
//           _error = 'Failed to load bookings';
//           _loading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _error = e.toString();
//         _loading = false;
//       });
//     }
//   }

//   String _getVehicleName(Map<String, dynamic> booking) {
//     final vehicle = booking['vehicle'];
//     if (vehicle == null) return 'Unknown Vehicle';
//     final make = vehicle['make'] ?? '';
//     final model = vehicle['model'] ?? '';
//     return '$make $model'.trim();
//   }

//   String _formatDate(String? date) {
//     if (date == null) return 'N/A';
//     try {
//       final parsed = DateTime.parse(date);
//       return DateFormat('MMM d, yyyy').format(parsed);
//     } catch (_) {
//       return date;
//     }
//   }

//   Color _statusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'pending':
//         return Colors.orange.shade700;
//       case 'confirmed':
//         return Colors.green.shade700;
//       case 'cancelled':
//         return Colors.red.shade700;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Bookings'),
//         backgroundColor: Colors.green.shade700,
//       ),
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : _error != null
//           ? Center(child: Text('Error: $_error'))
//           : _bookings.isEmpty
//           ? const Center(child: Text('No bookings yet'))
//           : ListView.builder(
//               padding: const EdgeInsets.all(12),
//               itemCount: _bookings.length,
//               itemBuilder: (context, index) {
//                 final booking = _bookings[index];
//                 final vehicleName = _getVehicleName(booking);
//                 final start = _formatDate(booking['start_date']);
//                 final end = _formatDate(booking['end_date']);
//                 final status = booking['status'] ?? 'unknown';
//                 final price = booking['total_price'] ?? '0.00';

//                 return Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   elevation: 4,
//                   margin: const EdgeInsets.symmetric(vertical: 8),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               vehicleName,
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.green.shade700,
//                               ),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 8,
//                                 vertical: 4,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: _statusColor(status).withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Text(
//                                 status.toUpperCase(),
//                                 style: TextStyle(
//                                   color: _statusColor(status),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 12),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'From:',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(start),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'To:',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(end),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Total',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text('\$$price'),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../auth/data/auth_repository.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class BookingHistoryScreen extends StatefulWidget {
//   const BookingHistoryScreen({super.key});

//   @override
//   State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
// }

// class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
//   final AuthRepository _authRepo = AuthRepository();
//   bool _loading = true;
//   List<dynamic> _bookings = [];
//   String? _error;

//   @override
//   void initState() {
//     super.initState();
//     _fetchBookings();
//   }

//   Future<void> _fetchBookings() async {
//     setState(() => _loading = true);
//     final user = await _authRepo.currentUser();
//     if (user == null) {
//       setState(() {
//         _error = 'You must be logged in';
//         _loading = false;
//       });
//       return;
//     }

//     final url = Uri.parse(
//       'http://192.168.10.100:8000/api/users/${user['id']}/bookings',
//     );

//     try {
//       final response = await http.get(
//         url,
//         headers: {'Authorization': 'Bearer ${await _authRepo.currentToken()}'},
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         setState(() {
//           _bookings = data;
//           _loading = false;
//         });
//       } else {
//         setState(() {
//           _error = 'Failed to load bookings';
//           _loading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _error = e.toString();
//         _loading = false;
//       });
//     }
//   }

//   String _getVehicleName(Map<String, dynamic> booking) {
//     final vehicle = booking['vehicle'];
//     if (vehicle == null) return 'Unknown Vehicle';
//     final make = vehicle['make'] ?? '';
//     final model = vehicle['model'] ?? '';
//     return '$make $model'.trim();
//   }

//   String _formatDate(String? date) {
//     if (date == null) return 'N/A';
//     try {
//       final parsed = DateTime.parse(date);
//       return DateFormat('MMM d, yyyy').format(parsed);
//     } catch (_) {
//       return date;
//     }
//   }

//   Color _statusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'pending':
//         return Colors.orange.shade700;
//       case 'confirmed':
//         return Colors.lightBlue.shade700;
//       case 'cancelled':
//         return Colors.red.shade700;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         title: const Text(
//           'My Bookings',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         backgroundColor: Colors.lightBlue.shade700,
//         iconTheme: const IconThemeData(color: Colors.white),
//         elevation: 4,
//       ),
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : _error != null
//           ? Center(
//               child: Text(
//                 'Error: $_error',
//                 style: const TextStyle(fontSize: 16, color: Colors.red),
//               ),
//             )
//           : _bookings.isEmpty
//           ? const Center(
//               child: Text('No bookings yet', style: TextStyle(fontSize: 16)),
//             )
//           : ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: _bookings.length,
//               itemBuilder: (context, index) {
//                 final booking = _bookings[index];
//                 final vehicleName = _getVehicleName(booking);
//                 final start = _formatDate(booking['start_date']);
//                 final end = _formatDate(booking['end_date']);
//                 final status = booking['status'] ?? 'unknown';
//                 final price = booking['total_price'] ?? '0.00';

//                 return Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   elevation: 6,
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               vehicleName,
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.lightBlue.shade700,
//                               ),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 10,
//                                 vertical: 5,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: _statusColor(status).withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Text(
//                                 status.toUpperCase(),
//                                 style: TextStyle(
//                                   color: _statusColor(status),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'From:',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(start),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'To:',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(end),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Total',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                   '\$$price',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.lightBlue.shade700,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../auth/data/auth_repository.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class BookingHistoryScreen extends StatefulWidget {
//   const BookingHistoryScreen({super.key});

//   @override
//   State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
// }

// class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
//   final AuthRepository _authRepo = AuthRepository();
//   bool _loading = true;
//   List<dynamic> _bookings = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchBookings();
//   }

//   Future<void> _fetchBookings() async {
//     setState(() => _loading = true);
//     final user = await _authRepo.currentUser();
//     if (user == null) {
//       // No user logged in, treat as no bookings
//       setState(() {
//         _bookings = [];
//         _loading = false;
//       });
//       return;
//     }

//     final url = Uri.parse(
//       'http://192.168.10.100:8000/api/users/${user['id']}/bookings',
//     );

//     try {
//       final response = await http.get(
//         url,
//         headers: {'Authorization': 'Bearer ${await _authRepo.currentToken()}'},
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         setState(() {
//           _bookings = data;
//           _loading = false;
//         });
//       } else {
//         // Non-200 response, treat as no bookings
//         setState(() {
//           _bookings = [];
//           _loading = false;
//         });
//       }
//     } catch (_) {
//       // Any error, treat as no bookings
//       setState(() {
//         _bookings = [];
//         _loading = false;
//       });
//     }
//   }

//   String _getVehicleName(Map<String, dynamic> booking) {
//     final vehicle = booking['vehicle'];
//     if (vehicle == null) return 'Unknown Vehicle';
//     final make = vehicle['make'] ?? '';
//     final model = vehicle['model'] ?? '';
//     return '$make $model'.trim();
//   }

//   String _formatDate(String? date) {
//     if (date == null) return 'N/A';
//     try {
//       final parsed = DateTime.parse(date);
//       return DateFormat('MMM d, yyyy').format(parsed);
//     } catch (_) {
//       return date;
//     }
//   }

//   Color _statusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'pending':
//         return Colors.orange.shade700;
//       case 'confirmed':
//         return Colors.lightBlue.shade700;
//       case 'cancelled':
//         return Colors.red.shade700;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         title: const Text(
//           'My Bookings',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         backgroundColor: Colors.lightBlue.shade700,
//         iconTheme: const IconThemeData(color: Colors.white),
//         elevation: 4,
//       ),
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : _bookings.isEmpty
//           ? const Center(
//               child: Text('No bookings yet', style: TextStyle(fontSize: 16)),
//             )
//           : ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: _bookings.length,
//               itemBuilder: (context, index) {
//                 final booking = _bookings[index];
//                 final vehicleName = _getVehicleName(booking);
//                 final start = _formatDate(booking['start_date']);
//                 final end = _formatDate(booking['end_date']);
//                 final status = booking['status'] ?? 'unknown';
//                 final price = booking['total_price'] ?? '0.00';

//                 return Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   elevation: 6,
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               vehicleName,
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.lightBlue.shade700,
//                               ),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 10,
//                                 vertical: 5,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: _statusColor(status).withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Text(
//                                 status.toUpperCase(),
//                                 style: TextStyle(
//                                   color: _statusColor(status),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'From:',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(start),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'To:',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(end),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Total',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                   '\$$price',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.lightBlue.shade700,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth/data/auth_repository.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  final AuthRepository _authRepo = AuthRepository();
  bool _loading = true;
  List<dynamic> _bookings = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  Future<void> _fetchBookings() async {
    setState(() => _loading = true);
    final user = await _authRepo.currentUser();

    if (user == null) {
      setState(() {
        _error = 'You must be logged in';
        _loading = false;
      });
      return;
    }

    final url = Uri.parse(
      'http://192.168.10.100:8000/api/users/${user['id']}/bookings',
    );

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${await _authRepo.currentToken()}'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _bookings = data;
          _loading = false;
          _error = null;
        });

        // Save bookings for offline use
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('cached_bookings', json.encode(data));
      } else {
        // Load from cache if API fails
        await _loadCachedBookings();
      }
    } catch (_) {
      // Offline scenario: load cached bookings
      await _loadCachedBookings();
    }
  }

  Future<void> _loadCachedBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString('cached_bookings');

    if (cached != null) {
      setState(() {
        _bookings = json.decode(cached);
        _loading = false;
        _error = null;
      });
    } else {
      setState(() {
        _bookings = [];
        _loading = false;
        _error = null;
      });
    }
  }

  String _getVehicleName(Map<String, dynamic> booking) {
    final vehicle = booking['vehicle'];
    if (vehicle == null) return 'Unknown Vehicle';
    final make = vehicle['make'] ?? '';
    final model = vehicle['model'] ?? '';
    return '$make $model'.trim();
  }

  String _formatDate(String? date) {
    if (date == null) return 'N/A';
    try {
      final parsed = DateTime.parse(date);
      return DateFormat('MMM d, yyyy').format(parsed);
    } catch (_) {
      return date;
    }
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange.shade700;
      case 'confirmed':
        return Colors.lightBlue.shade700;
      case 'cancelled':
        return Colors.red.shade700;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'My Bookings',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue.shade700,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 4,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _bookings.isEmpty
          ? const Center(
              child: Text('No bookings yet', style: TextStyle(fontSize: 16)),
            )
          : RefreshIndicator(
              onRefresh: _fetchBookings,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _bookings.length,
                itemBuilder: (context, index) {
                  final booking = _bookings[index];
                  final vehicleName = _getVehicleName(booking);
                  final start = _formatDate(booking['start_date']);
                  final end = _formatDate(booking['end_date']);
                  final status = booking['status'] ?? 'unknown';
                  final price = booking['total_price'] ?? '0.00';

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 6,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                vehicleName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlue.shade700,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: _statusColor(status).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  status.toUpperCase(),
                                  style: TextStyle(
                                    color: _statusColor(status),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'From:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(start),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'To:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(end),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Total',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '\$$price',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightBlue.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
