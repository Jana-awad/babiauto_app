class Booking {
  final int id;
  final int userId;
  final int vehicleId;
  final String startDate;
  final String endDate;
  final String totalPrice;
  final String status;

  Booking({
    required this.id,
    required this.userId,
    required this.vehicleId,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.status,
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
    };
  }
}
