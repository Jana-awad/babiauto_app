import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:babiauto_app/features/bookings/data/booking_repository.dart';
import 'package:babiauto_app/features/bookings/data/booking_model.dart';

// Mock classes
class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  // Ensure bindings are initialized for Flutter
  TestWidgetsFlutterBinding.ensureInitialized();

  // Register fallback values for mocktail
  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  late BookingRepository repo;
  late MockHttpClient client;

  setUp(() {
    client = MockHttpClient();
    repo = BookingRepository(client: client);
  });

  group('BookingRepository.getBookingsByUser', () {
    test('returns list of bookings on 200 response', () async {
      final mockResponse = [
        {
          'id': 1,
          'user_id': 5,
          'vehicle_id': 10,
          'status': 'pending',
          'start_date': '2025-09-28',
          'end_date': '2025-09-30',
          'total_price': '100',
        },
      ];

      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

      final bookings = await repo.getBookingsByUser(5, 'token123');

      expect(bookings, isA<List<Booking>>());
      expect(bookings.length, 1);
      expect(bookings.first.id, 1);
      expect(bookings.first.startDate, '2025-09-28');
    });

    test('returns empty list on non-200 response', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('Error', 404));

      final bookings = await repo.getBookingsByUser(5, 'token123');

      expect(bookings, []);
    });
  });

  group('BookingRepository.createBooking', () {
    test('returns Booking object on 201 response', () async {
      final mockBooking = {
        'id': 1,
        'user_id': 5,
        'vehicle_id': 10,
        'status': 'pending',
        'start_date': '2025-09-28',
        'end_date': '2025-09-30',
        'total_price': '100',
      };

      when(
        () => client.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(mockBooking), 201));

      final booking = await repo.createBooking(
        userId: 5,
        vehicleId: 10,
        startDate: '2025-09-28',
        endDate: '2025-09-30',
        totalPrice: '100',
        status: 'pending',
        token: 'token123',
      );

      expect(booking, isA<Booking>());
      expect(booking!.id, 1);
      expect(booking.totalPrice, '100');
    });

    test('returns null on failed creation', () async {
      when(
        () => client.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 400));

      final booking = await repo.createBooking(
        userId: 5,
        vehicleId: 10,
        startDate: '2025-09-28',
        endDate: '2025-09-30',
        totalPrice: '100',
        status: 'pending',
        token: 'token123',
      );

      expect(booking, null);
    });
  });
}
