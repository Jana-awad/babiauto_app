import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:babiauto_app/features/auth/data/auth_repository.dart';
import 'package:babiauto_app/core/api_client.dart';
import 'package:babiauto_app/core/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// --- Mock classes ---
class MockApiClient extends Mock implements ApiClient {}

class MockTokenStorage extends Mock implements TokenStorage {}

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockApiClient mockApiClient;
  late MockTokenStorage mockTokenStorage;
  late AuthRepository authRepo;

  setUp(() {
    mockApiClient = MockApiClient();
    mockTokenStorage = MockTokenStorage();

    authRepo = AuthRepository(
      apiClient: mockApiClient,
      tokenStorage: mockTokenStorage,
    );
  });

  group('AuthRepository.login', () {
    test('returns true and saves token when API returns token', () async {
      when(
        () => mockApiClient.post('login', any()),
      ).thenAnswer((_) async => {'token': 'abc123'});
      when(
        () => mockTokenStorage.saveToken('abc123'),
      ).thenAnswer((_) async => {});

      final result = await authRepo.login('test@example.com', 'password');

      expect(result, true);
      verify(() => mockTokenStorage.saveToken('abc123')).called(1);
    });

    test('returns false when API does not return token', () async {
      when(
        () => mockApiClient.post('login', any()),
      ).thenAnswer((_) async => {});

      final result = await authRepo.login('test@example.com', 'password');

      expect(result, false);
      verifyNever(() => mockTokenStorage.saveToken(any()));
    });

    test('throws exception when API throws', () async {
      when(
        () => mockApiClient.post('login', any()),
      ).thenThrow(Exception('Server error'));

      expect(
        () => authRepo.login('test@example.com', 'password'),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('AuthRepository.register', () {
    test('returns true and saves token when API returns token', () async {
      when(
        () => mockApiClient.post('register', any()),
      ).thenAnswer((_) async => {'token': 'xyz789'});
      when(
        () => mockTokenStorage.saveToken('xyz789'),
      ).thenAnswer((_) async => {});

      final result = await authRepo.register(
        'John Doe',
        'john@example.com',
        'password123',
        'password123',
      );

      expect(result, true);
      verify(() => mockTokenStorage.saveToken('xyz789')).called(1);
    });

    test('returns false when API does not return token', () async {
      when(
        () => mockApiClient.post('register', any()),
      ).thenAnswer((_) async => {});

      final result = await authRepo.register(
        'Jane Doe',
        'jane@example.com',
        'pass123',
        'pass123',
      );

      expect(result, false);
      verifyNever(() => mockTokenStorage.saveToken(any()));
    });

    test('throws exception when API throws', () async {
      when(
        () => mockApiClient.post('register', any()),
      ).thenThrow(Exception('Server error'));

      expect(
        () =>
            authRepo.register('Jake', 'jake@example.com', 'pass123', 'pass123'),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('AuthRepository.logout', () {
    test('clears token and cached user', () async {
      SharedPreferences.setMockInitialValues({
        'cached_user': '{"name":"Test"}',
      });

      when(() => mockTokenStorage.clearToken()).thenAnswer((_) async => {});

      await authRepo.logout();

      verify(() => mockTokenStorage.clearToken()).called(1);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('cached_user'), null);
    });
  });

  group('AuthRepository.currentUserCached', () {
    test('returns cached user if exists', () async {
      SharedPreferences.setMockInitialValues({
        'cached_user': '{"name":"Cached"}',
      });

      final cached = await authRepo.currentUserCached();
      expect(cached, isNotNull);
      expect(cached!['name'], 'Cached');
    });

    test('returns null if no cached user', () async {
      SharedPreferences.setMockInitialValues({});
      final cached = await authRepo.currentUserCached();
      expect(cached, null);
    });
  });

  group('AuthRepository.updateProfile', () {
    test('updates profile and cache', () async {
      SharedPreferences.setMockInitialValues({});
      when(
        () => mockTokenStorage.getToken(),
      ).thenAnswer((_) async => 'token123');
      when(
        () => mockApiClient.put('profile', any(), token: any(named: 'token')),
      ).thenAnswer((_) async => {'name': 'Updated'});

      final result = await authRepo.updateProfile(name: 'Updated');
      expect(result, isNotNull);
      expect(result!['name'], 'Updated');

      final prefs = await SharedPreferences.getInstance();
      final cachedUser = prefs.getString('cached_user');
      expect(cachedUser, isNotNull);
      expect(json.decode(cachedUser!)['name'], 'Updated');
    });

    test('throws exception if no token', () async {
      when(() => mockTokenStorage.getToken()).thenAnswer((_) async => null);

      expect(() => authRepo.updateProfile(name: 'X'), throwsException);
    });
  });

  group('AuthRepository.saveDeviceToken', () {
    test('throws exception if not authenticated', () async {
      when(() => mockTokenStorage.getToken()).thenAnswer((_) async => null);

      expect(() => authRepo.saveDeviceToken('fcm123'), throwsException);
    });
  });
}
