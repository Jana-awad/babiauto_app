import 'package:babiauto_app/core/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class VehicleRepository {
  final ApiClient apiClient = ApiClient();

  // Get list of all vehicles
  Future<List<Map<String, dynamic>>> getVehicles() async {
    try {
      final response = await apiClient.get('vehicles');

      // Laravel returns a plain list, so we just cast it
      if (response is List) {
        final vehicleList = List<Map<String, dynamic>>.from(response);

        // Save to cache
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('vehicles_cache', jsonEncode(vehicleList));

        return vehicleList;
      } else {
        throw Exception('Unexpected API response format: $response');
      }
    } catch (e) {
      // If API fails, try to get cached data
      final prefs = await SharedPreferences.getInstance();
      final cached = prefs.getString('vehicles_cache');
      if (cached != null) {
        return List<Map<String, dynamic>>.from(jsonDecode(cached));
      }
      throw Exception('Failed to fetch vehicles: $e');
    }
  }

  // Get details of a single vehicle
  Future<Map<String, dynamic>> getVehicleDetails(int id) async {
    try {
      final response = await apiClient.get('vehicles/$id');

      if (response is Map<String, dynamic>) {
        return response;
      } else {
        throw Exception('Unexpected API response format: $response');
      }
    } catch (e) {
      // Optionally, you can fetch the vehicle from cached list
      final prefs = await SharedPreferences.getInstance();
      final cached = prefs.getString('vehicles_cache');
      if (cached != null) {
        final cachedList = List<Map<String, dynamic>>.from(jsonDecode(cached));
        final vehicle = cachedList.firstWhere(
          (v) => v['id'] == id,
          orElse: () => {},
        );
        if (vehicle.isNotEmpty) return vehicle;
      }
      throw Exception('Failed to fetch vehicle details: $e');
    }
  }
}
