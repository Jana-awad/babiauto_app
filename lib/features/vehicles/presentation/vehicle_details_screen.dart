// import 'package:flutter/material.dart';
// import '../../vehicles/data/vehicle_repository.dart';

// class VehicleDetailsScreen extends StatefulWidget {
//   final int vehicleId;
//   const VehicleDetailsScreen({super.key, required this.vehicleId});

//   @override
//   State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
// }

// class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
//   final VehicleRepository repo = VehicleRepository();
//   bool _loading = true;
//   Map<String, dynamic>? _vehicle;
//   String? _error;

//   @override
//   void initState() {
//     super.initState();
//     _fetchVehicle();
//   }

//   Future<void> _fetchVehicle() async {
//     try {
//       final data = await repo.getVehicleDetails(widget.vehicleId);
//       setState(() {
//         _vehicle = data;
//         _loading = false;
//       });
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
//       appBar: AppBar(
//         title: Text(_vehicle?['make'] ?? _vehicle?['name'] ?? 'Vehicle'),
//       ),
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : _error != null
//           ? Center(child: Text('Error: $_error'))
//           : Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Model: ${_vehicle?['model'] ?? ''}'),
//                   Text('Year: ${_vehicle?['year'] ?? ''}'),
//                   Text('Price: \$${_vehicle?['price_per_day'] ?? ''} per day'),
//                   Text('Type: ${_vehicle?['type'] ?? ''}'),
//                   Text(
//                     'Description: ${_vehicle?['description'] ?? 'No description'}',
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import '../../vehicles/data/vehicle_repository.dart';
// import '../../bookings/presentation/booking_screen.dart';

// class VehicleDetailsScreen extends StatefulWidget {
//   final int vehicleId;
//   const VehicleDetailsScreen({super.key, required this.vehicleId});

//   @override
//   State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
// }

// class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
//   final VehicleRepository repo = VehicleRepository();
//   bool _loading = true;
//   Map<String, dynamic>? _vehicle;
//   String? _error;

//   @override
//   void initState() {
//     super.initState();
//     _fetchVehicle();
//   }

//   Future<void> _fetchVehicle() async {
//     try {
//       final data = await repo.getVehicleDetails(widget.vehicleId);
//       setState(() {
//         _vehicle = data;
//         _loading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _error = e.toString();
//         _loading = false;
//       });
//     }
//   }

//   Widget _infoRow(String label, String value, IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.indigo),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text('$label: $value', style: const TextStyle(fontSize: 16)),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(_vehicle?['make'] ?? 'Vehicle')),
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : _error != null
//           ? Center(child: Text('Error: $_error'))
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(20),
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 elevation: 4,
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: _vehicle?['image_url'] != null
//                             ? ClipRRect(
//                                 borderRadius: BorderRadius.circular(16),
//                                 child: Image.network(
//                                   _vehicle!['image_url'],
//                                   height: 200,
//                                   width: double.infinity,
//                                   fit: BoxFit.cover,
//                                   loadingBuilder: (context, child, progress) {
//                                     if (progress == null) return child;
//                                     return const Center(
//                                       child: CircularProgressIndicator(),
//                                     );
//                                   },
//                                   errorBuilder: (context, error, stackTrace) =>
//                                       Icon(
//                                         Icons.directions_car,
//                                         size: 100,
//                                         color: Colors.indigo.shade400,
//                                       ),
//                                 ),
//                               )
//                             : Icon(
//                                 Icons.directions_car,
//                                 size: 100,
//                                 color: Colors.indigo.shade400,
//                               ),
//                       ),
//                       const SizedBox(height: 20),
//                       Text(
//                         '${_vehicle?['make']} ${_vehicle?['model']}',
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.indigo,
//                         ),
//                       ),
//                       const Divider(height: 30),
//                       _infoRow(
//                         'Year',
//                         '${_vehicle?['year']}',
//                         Icons.calendar_today,
//                       ),
//                       _infoRow('Type', '${_vehicle?['type']}', Icons.category),
//                       _infoRow(
//                         'Price/Day',
//                         '\$${_vehicle?['price_per_day']}',
//                         Icons.attach_money,
//                       ),
//                       _infoRow('Status', '${_vehicle?['status']}', Icons.info),
//                       const SizedBox(height: 30),
//                       SizedBox(
//                         width: double.infinity,
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => BookingScreen(
//                                   vehicleId: _vehicle!['id'],
//                                   vehicleName:
//                                       '${_vehicle!['make']} ${_vehicle!['model']}',
//                                   pricePerDay:
//                                       double.tryParse(
//                                         _vehicle!['price_per_day'].toString(),
//                                       ) ??
//                                       0,
//                                 ),
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.indigo,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: const Text(
//                             'Book Vehicle',

//                             style: TextStyle(fontSize: 18, color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }
// lib/features/vehicles/presentation/vehicle_details_screen.dart
// import 'package:flutter/material.dart';
// import '../../bookings/presentation/booking_screen.dart';
// import '../../vehicles/data/vehicle_repository.dart';

// class VehicleDetailsScreen extends StatefulWidget {
//   final int vehicleId;
//   const VehicleDetailsScreen({super.key, required this.vehicleId});

//   @override
//   State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
// }

// class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
//   final VehicleRepository repo = VehicleRepository();
//   bool _loading = true;
//   Map<String, dynamic>? _vehicle;
//   String? _error;

//   @override
//   void initState() {
//     super.initState();
//     _fetchVehicle();
//   }

//   Future<void> _fetchVehicle() async {
//     try {
//       final data = await repo.getVehicleDetails(widget.vehicleId);
//       setState(() {
//         _vehicle = data;
//         _loading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _error = e.toString();
//         _loading = false;
//       });
//     }
//   }

//   Widget _infoRow(String label, String value, IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.green.shade700),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text('$label: $value', style: const TextStyle(fontSize: 16)),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_vehicle?['make'] ?? 'Vehicle Details'),
//         backgroundColor: Colors.green.shade700,
//       ),
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : _error != null
//           ? Center(child: Text('Error: $_error'))
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(20),
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 elevation: 6,
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: _vehicle?['image_url'] != null
//                             ? ClipRRect(
//                                 borderRadius: BorderRadius.circular(16),
//                                 child: Image.network(
//                                   _vehicle!['image_url'],
//                                   height: 220,
//                                   width: double.infinity,
//                                   fit: BoxFit.cover,
//                                   loadingBuilder: (context, child, progress) {
//                                     if (progress == null) return child;
//                                     return const Center(
//                                       child: CircularProgressIndicator(),
//                                     );
//                                   },
//                                   errorBuilder: (context, error, stackTrace) =>
//                                       Icon(
//                                         Icons.directions_car,
//                                         size: 100,
//                                         color: Colors.green.shade400,
//                                       ),
//                                 ),
//                               )
//                             : Icon(
//                                 Icons.directions_car,
//                                 size: 100,
//                                 color: Colors.green.shade400,
//                               ),
//                       ),
//                       const SizedBox(height: 20),
//                       Text(
//                         '${_vehicle?['make']} ${_vehicle?['model']}',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.green.shade700,
//                         ),
//                       ),
//                       const Divider(height: 30),
//                       _infoRow(
//                         'Year',
//                         '${_vehicle?['year']}',
//                         Icons.calendar_today,
//                       ),
//                       _infoRow('Type', '${_vehicle?['type']}', Icons.category),
//                       _infoRow(
//                         'Price/Day',
//                         '\$${_vehicle?['price_per_day']}',
//                         Icons.attach_money,
//                       ),
//                       _infoRow('Status', '${_vehicle?['status']}', Icons.info),
//                       const SizedBox(height: 30),
//                       SizedBox(
//                         width: double.infinity,
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => BookingScreen(
//                                   vehicleId: _vehicle!['id'],
//                                   vehicleName:
//                                       '${_vehicle!['make']} ${_vehicle!['model']}',
//                                   pricePerDay:
//                                       double.tryParse(
//                                         _vehicle!['price_per_day'].toString(),
//                                       ) ??
//                                       0,
//                                 ),
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green.shade700,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: const Text(
//                             'Book Vehicle',
//                             style: TextStyle(fontSize: 18, color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import '../../bookings/presentation/booking_screen.dart';
// import '../../vehicles/data/vehicle_repository.dart';
// import '../../../widgets/info_row.dart';

// class VehicleDetailsScreen extends StatefulWidget {
//   final int vehicleId;
//   const VehicleDetailsScreen({super.key, required this.vehicleId});

//   @override
//   State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
// }

// class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
//   final VehicleRepository repo = VehicleRepository();
//   bool _loading = true;
//   Map<String, dynamic>? _vehicle;
//   String? _error;

//   @override
//   void initState() {
//     super.initState();
//     _fetchVehicle();
//   }

//   Future<void> _fetchVehicle() async {
//     try {
//       final data = await repo.getVehicleDetails(widget.vehicleId);
//       setState(() {
//         _vehicle = data;
//         _loading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _error = e.toString();
//         _loading = false;
//       });
//     }
//   }

//   Widget _infoRow(String label, String value, IconData icon) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.lightBlue.shade50,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.lightBlue.shade700),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               '$label: $value',
//               style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         title: Text(
//           _vehicle?['make'] ?? 'Vehicle Details',
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.lightBlue.shade600,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : _error != null
//           ? Center(child: Text('Error: $_error'))
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 elevation: 6,
//                 shadowColor: Colors.grey.shade300,
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Vehicle Image
//                       Center(
//                         child: _vehicle?['image_url'] != null
//                             ? ClipRRect(
//                                 borderRadius: BorderRadius.circular(16),
//                                 child: Image.network(
//                                   _vehicle!['image_url'],
//                                   height: 220,
//                                   width: double.infinity,
//                                   fit: BoxFit.cover,
//                                   loadingBuilder: (context, child, progress) {
//                                     if (progress == null) return child;
//                                     return const Center(
//                                       child: CircularProgressIndicator(),
//                                     );
//                                   },
//                                   errorBuilder: (context, error, stackTrace) =>
//                                       Icon(
//                                         Icons.directions_car,
//                                         size: 100,
//                                         color: Colors.lightBlue.shade400,
//                                       ),
//                                 ),
//                               )
//                             : Icon(
//                                 Icons.directions_car,
//                                 size: 100,
//                                 color: Colors.lightBlue.shade400,
//                               ),
//                       ),
//                       const SizedBox(height: 20),
//                       // Vehicle Title
//                       Text(
//                         '${_vehicle?['make']} ${_vehicle?['model']}',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.lightBlue.shade700,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       // Vehicle Info
//                       // _infoRow(
//                       //   'Year',
//                       //   '${_vehicle?['year']}',
//                       //   Icons.calendar_today,
//                       // ),
//                       // _infoRow('Type', '${_vehicle?['type']}', Icons.category),
//                       // _infoRow(
//                       //   'Price/Day',
//                       //   '\$${_vehicle?['price_per_day']}',
//                       //   Icons.attach_money,
//                       // ),
//                       // _infoRow('Status', '${_vehicle?['status']}', Icons.info),
//                       InfoRow(
//                         label: 'Year',
//                         value: '${_vehicle?['year']}',
//                         icon: Icons.calendar_today,
//                       ),
//                       InfoRow(
//                         label: 'Type',
//                         value: '${_vehicle?['type']}',
//                         icon: Icons.category,
//                       ),
//                       InfoRow(
//                         label: 'Price/Day',
//                         value: '\$${_vehicle?['price_per_day']}',
//                         icon: Icons.attach_money,
//                       ),
//                       InfoRow(
//                         label: 'Status',
//                         value: '${_vehicle?['status']}',
//                         icon: Icons.info,
//                       ),

//                       const SizedBox(height: 30),
//                       // Book Button
//                       SizedBox(
//                         width: double.infinity,
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => BookingScreen(
//                                   vehicleId: _vehicle!['id'],
//                                   vehicleName:
//                                       '${_vehicle!['make']} ${_vehicle!['model']}',
//                                   pricePerDay:
//                                       double.tryParse(
//                                         _vehicle!['price_per_day'].toString(),
//                                       ) ??
//                                       0,
//                                 ),
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.lightBlue.shade700,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             elevation: 5,
//                           ),
//                           child: const Text(
//                             'Book Vehicle',
//                             style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../bookings/presentation/booking_screen.dart';
import '../../vehicles/data/vehicle_repository.dart';
import '../../../widgets/info_row.dart';

class VehicleDetailsScreen extends StatefulWidget {
  final int vehicleId;
  const VehicleDetailsScreen({super.key, required this.vehicleId});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  final VehicleRepository repo = VehicleRepository();
  bool _loading = true;
  Map<String, dynamic>? _vehicle;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchVehicle();
  }

  Future<void> _fetchVehicle() async {
    try {
      final data = await repo.getVehicleDetails(widget.vehicleId);
      setState(() {
        _vehicle = data;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: _loading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                '${_vehicle!['make']} ${_vehicle!['model']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
        backgroundColor: Colors.lightBlue.shade600,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(
              child: Text(
                'Error: $_error',
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 6,
                shadowColor: Colors.grey.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Vehicle Image
                      Center(
                        child: _vehicle?['image_url'] != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  _vehicle!['image_url'],
                                  height: 220,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(
                                        Icons.directions_car,
                                        size: 100,
                                        color: Colors.lightBlue.shade400,
                                      ),
                                ),
                              )
                            : Icon(
                                Icons.directions_car,
                                size: 100,
                                color: Colors.lightBlue.shade400,
                              ),
                      ),
                      const SizedBox(height: 20),
                      // Vehicle Title
                      Text(
                        '${_vehicle!['make']} ${_vehicle!['model']}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue.shade700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Vehicle Info
                      InfoRow(
                        label: 'Year',
                        value: '${_vehicle?['year']}',
                        icon: Icons.calendar_today,
                      ),
                      InfoRow(
                        label: 'Type',
                        value: '${_vehicle?['type']}',
                        icon: Icons.category,
                      ),
                      InfoRow(
                        label: 'Price/Day',
                        value: '\$${_vehicle?['price_per_day']}',
                        icon: Icons.attach_money,
                      ),
                      InfoRow(
                        label: 'Status',
                        value: '${_vehicle?['status']}',
                        icon: Icons.info,
                      ),
                      const SizedBox(height: 30),
                      // Book Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BookingScreen(
                                  vehicleId: _vehicle!['id'],
                                  vehicleName:
                                      '${_vehicle!['make']} ${_vehicle!['model']}',
                                  pricePerDay:
                                      double.tryParse(
                                        _vehicle!['price_per_day'].toString(),
                                      ) ??
                                      0,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            'Book Vehicle',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
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
