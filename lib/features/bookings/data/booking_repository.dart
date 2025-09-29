import 'dart:convert';
import 'package:http/http.dart' as http;
import 'booking_model.dart';

class BookingRepository {
  final String baseUrl = 'http://192.168.10.100:8000/api';
  final http.Client httpClient;

  BookingRepository({http.Client? client})
    : httpClient = client ?? http.Client();

  // Fetch bookings by user ID
  Future<List<Booking>> getBookingsByUser(int userId, String token) async {
    final url = Uri.parse('$baseUrl/users/$userId/bookings');
    final response = await httpClient.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Booking.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  // Create booking
  Future<Booking?> createBooking({
    required int userId,
    required int vehicleId,
    required String startDate,
    required String endDate,
    required String totalPrice,
    required String status,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/bookings');
    final response = await httpClient.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'user_id': userId,
        'vehicle_id': vehicleId,
        'start_date': startDate,
        'end_date': endDate,
        'total_price': totalPrice,
        'status': status,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Booking.fromJson(data);
    } else {
      return null;
    }
  }
}
