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
