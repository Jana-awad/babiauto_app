import 'package:babiauto_app/core/api_client.dart';
import 'package:babiauto_app/core/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../auth/data/auth_repository.dart';
import 'booking_history_screen.dart';

class BookingScreen extends StatefulWidget {
  final int vehicleId;
  final String vehicleName;
  final double pricePerDay;

  const BookingScreen({
    super.key,
    required this.vehicleId,
    required this.vehicleName,
    required this.pricePerDay,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  bool _loading = false;
  String? _error;

  final AuthRepository _authRepo = AuthRepository(
    apiClient: ApiClient(),
    tokenStorage: TokenStorage(),
  );

  int get totalDays => (_startDate != null && _endDate != null)
      ? _endDate!.difference(_startDate!).inDays
      : 0;

  double get totalPrice => totalDays * widget.pricePerDay;

  Future<void> _pickStartDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) setState(() => _startDate = date);
  }

  Future<void> _pickEndDate() async {
    if (_startDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Pick start date first')));
      return;
    }
    final date = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate!.add(const Duration(days: 1)),
      firstDate: _startDate!.add(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );
    if (date != null) setState(() => _endDate = date);
  }

  Future<void> _bookVehicle() async {
    if (_startDate == null || _endDate == null) {
      setState(() => _error = 'Please select both start and end dates');
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });

    final user = await _authRepo.currentUser();
    if (user == null) {
      setState(() {
        _loading = false;
        _error = 'You must be logged in to book';
      });
      return;
    }

    try {
      final response = await _authRepo.apiClient.post('bookings', {
        'vehicle_id': widget.vehicleId,
        'user_id': user['id'],
        'start_date': DateFormat('yyyy-MM-dd').format(_startDate!),
        'end_date': DateFormat('yyyy-MM-dd').format(_endDate!),
        'total_price': totalPrice.toStringAsFixed(2),
        'status': 'pending',
      });

      setState(() => _loading = false);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Booking successful!')));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BookingHistoryScreen()),
      );
    } catch (e) {
      setState(() {
        _loading = false;
        _error = 'Booking failed: ${e.toString()}';
      });
    }
  }

  Widget _bookingSummaryCard() {
    if (_startDate == null || _endDate == null) return const SizedBox.shrink();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue.shade800,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Start Date:', style: TextStyle(fontSize: 16)),
                Text(
                  DateFormat('yyyy-MM-dd').format(_startDate!),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('End Date:', style: TextStyle(fontSize: 16)),
                Text(
                  DateFormat('yyyy-MM-dd').format(_endDate!),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Divider(height: 24, thickness: 1, color: Colors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Days:', style: TextStyle(fontSize: 16)),
                Text(
                  '$totalDays',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Price:', style: TextStyle(fontSize: 16)),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue.shade700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _styledButton(
    String text,
    VoidCallback onPressed, {
    bool enabled = true,
  }) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: enabled
            ? LinearGradient(
                colors: [Colors.lightBlue.shade500, Colors.lightBlue.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: enabled ? null : Colors.grey.shade400,
        boxShadow: enabled
            ? [
                BoxShadow(
                  color: Colors.lightBlue.shade200.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: enabled ? onPressed : null,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          'Book ${widget.vehicleName}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightBlue.shade700,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _styledButton(
              _startDate == null
                  ? 'Select Start Date'
                  : 'Start: ${DateFormat('yyyy-MM-dd').format(_startDate!)}',
              _pickStartDate,
            ),
            const SizedBox(height: 16),
            _styledButton(
              _endDate == null
                  ? 'Select End Date'
                  : 'End: ${DateFormat('yyyy-MM-dd').format(_endDate!)}',
              _pickEndDate,
            ),
            _bookingSummaryCard(),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  _error!,
                  style: const TextStyle(color: Colors.red, fontSize: 15),
                ),
              ),
            const Spacer(),
            _styledButton(
              'Confirm Booking',
              _bookVehicle,
              enabled: !_loading && _startDate != null && _endDate != null,
            ),
          ],
        ),
      ),
    );
  }
}
