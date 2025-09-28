import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:babiauto_app/core/api_client.dart';
import 'package:babiauto_app/features/vehicles/data/vehicle_repository.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late VehicleRepository repo;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    repo = VehicleRepository(client: mockApiClient);

    // Initialize SharedPreferences with empty values
    SharedPreferences.setMockInitialValues({});
  });

  group('VehicleRepository.getVehicles', () {
    test('returns list of vehicles', () async {
      final mockList = [
        {'id': 1, 'name': 'Car A'},
        {'id': 2, 'name': 'Car B'},
      ];

      when(
        () => mockApiClient.get('vehicles'),
      ).thenAnswer((_) async => mockList);

      final vehicles = await repo.getVehicles();

      expect(vehicles, isA<List<Map<String, dynamic>>>());
      expect(vehicles.length, 2);

      // Verify caching
      final prefs = await SharedPreferences.getInstance();
      final cached = prefs.getString('vehicles_cache');
      expect(cached, isNotNull);
      expect(jsonDecode(cached!), mockList);
    });

    test('throws exception when API fails and no cache', () async {
      when(
        () => mockApiClient.get('vehicles'),
      ).thenThrow(Exception('API error'));

      // No cache set, should throw
      expect(() => repo.getVehicles(), throwsException);
    });
  });

  group('VehicleRepository.getVehicleDetails', () {
    test('returns vehicle details', () async {
      final vehicle = {'id': 1, 'name': 'Car A'};

      when(
        () => mockApiClient.get('vehicles/1'),
      ).thenAnswer((_) async => vehicle);

      final result = await repo.getVehicleDetails(1);

      expect(result['id'], 1);
      expect(result['name'], 'Car A');
    });

    test('returns cached vehicle if API fails', () async {
      // Save cache first
      final cachedList = [
        {'id': 1, 'name': 'Cached Car'},
      ];
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('vehicles_cache', jsonEncode(cachedList));

      // Throw API error
      when(
        () => mockApiClient.get('vehicles/1'),
      ).thenThrow(Exception('API error'));

      final result = await repo.getVehicleDetails(1);
      expect(result['name'], 'Cached Car');
    });

    test('throws exception when vehicle not found and no cache', () async {
      when(
        () => mockApiClient.get('vehicles/1'),
      ).thenThrow(Exception('API error'));

      expect(() => repo.getVehicleDetails(1), throwsException);
    });
  });
}
