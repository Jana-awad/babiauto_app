import 'package:flutter/material.dart';
import '../../vehicles/data/vehicle_repository.dart';
import 'vehicle_details_screen.dart';

class VehicleListScreen extends StatefulWidget {
  const VehicleListScreen({super.key});

  @override
  State<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  final VehicleRepository repo = VehicleRepository();
  bool _loading = true;
  List<Map<String, dynamic>> _vehicles = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchVehicles();
  }

  Future<void> _fetchVehicles() async {
    try {
      final vehicles = await repo.getVehicles();
      setState(() {
        _vehicles = vehicles;
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
        title: const Text(
          'Available Vehicles',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlue.shade600,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text('Error: $_error'))
          // : ListView.builder(
          //     padding: const EdgeInsets.all(12),
          //     itemCount: _vehicles.length,
          //     itemBuilder: (context, index) {
          //       final vehicle = _vehicles[index];
          : RefreshIndicator(
              onRefresh: _fetchVehicles,
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: _vehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = _vehicles[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              VehicleDetailsScreen(vehicleId: vehicle['id']),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 8,
                      ),
                      shadowColor: Colors.grey.shade300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Vehicle Image
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: vehicle['image_url'] != null
                                ? Image.network(
                                    vehicle['image_url'],
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                              height: 180,
                                              color: Colors.lightBlue.shade100,
                                              child: const Icon(
                                                Icons.directions_car,
                                                size: 60,
                                                color: Colors.lightBlue,
                                              ),
                                            ),
                                  )
                                : Container(
                                    height: 180,
                                    color: Colors.lightBlue.shade100,
                                    child: const Icon(
                                      Icons.directions_car,
                                      size: 60,
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                          ),

                          // Vehicle Info
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${vehicle['make']} ${vehicle['model']}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Year: ${vehicle['year']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\$${vehicle['price_per_day'] ?? '0.00'} / day',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.lightBlue.shade700,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
