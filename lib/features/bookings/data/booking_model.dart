import 'dart:convert';

class Booking {
  final int id;
  final int userId;
  final int vehicleId;
  final String startDate;
  final String endDate;
  final String totalPrice;
  final String status;
  final Map<String, dynamic>? vehicle;

  Booking({
    required this.id,
    required this.userId,
    required this.vehicleId,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.status,
    this.vehicle,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      userId: json['user_id'],
      vehicleId: json['vehicle_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      totalPrice: json['total_price'].toString(),
      status: json['status'],
      vehicle: json['vehicle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'vehicle_id': vehicleId,
      'start_date': startDate,
      'end_date': endDate,
      'total_price': totalPrice,
      'status': status,
      'vehicle': vehicle,
    };
  }

  String get vehicleName {
    if (vehicle == null) return 'Unknown Vehicle';
    final make = vehicle?['make'] ?? '';
    final model = vehicle?['model'] ?? '';
    return '$make $model'.trim();
  }

  /// Helpers to convert lists to/from JSON
  static List<Booking> listFromJson(String jsonString) {
    final List data = json.decode(jsonString);
    return data.map((e) => Booking.fromJson(e)).toList();
  }

  static String listToJson(List<Booking> bookings) {
    final List data = bookings.map((b) => b.toJson()).toList();
    return json.encode(data);
  }
}
