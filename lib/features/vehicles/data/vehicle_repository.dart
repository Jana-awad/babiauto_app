import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:babiauto_app/core/api_client.dart';

class VehicleRepository {
  final ApiClient apiClient;

  VehicleRepository({ApiClient? client}) : apiClient = client ?? ApiClient();

  Future<List<Map<String, dynamic>>> getVehicles() async {
    try {
      final response = await apiClient.get('vehicles');

      if (response is List) {
        final vehicleList = List<Map<String, dynamic>>.from(response);

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('vehicles_cache', jsonEncode(vehicleList));

        return vehicleList;
      } else {
        throw Exception('Unexpected API response format');
      }
    } catch (e) {
      final prefs = await SharedPreferences.getInstance();
      final cached = prefs.getString('vehicles_cache');
      if (cached != null) {
        return List<Map<String, dynamic>>.from(jsonDecode(cached));
      }
      throw Exception('Failed to fetch vehicles: $e');
    }
  }

  Future<Map<String, dynamic>> getVehicleDetails(int id) async {
    try {
      final response = await apiClient.get('vehicles/$id');

      if (response is Map<String, dynamic>) {
        return response;
      } else {
        throw Exception('Unexpected API response format');
      }
    } catch (e) {
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
