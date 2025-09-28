import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:babiauto_app/core/token_storage.dart';

// Create a Mock for FlutterSecureStorage
class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFlutterSecureStorage mockStorage;
  late TokenStorage tokenStorage;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    tokenStorage = TokenStorage(storage: mockStorage);
  });

  group('TokenStorage', () {
    test('saveToken writes token to secure storage', () async {
      when(
        () => mockStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});

      await tokenStorage.saveToken('abc123');

      verify(
        () => mockStorage.write(key: 'auth_token', value: 'abc123'),
      ).called(1);
    });

    test('getToken reads token from secure storage', () async {
      when(
        () => mockStorage.read(key: any(named: 'key')),
      ).thenAnswer((_) async => 'xyz789');

      final token = await tokenStorage.getToken();

      expect(token, 'xyz789');
      verify(() => mockStorage.read(key: 'auth_token')).called(1);
    });

    test('getToken returns null if no token is stored', () async {
      when(
        () => mockStorage.read(key: any(named: 'key')),
      ).thenAnswer((_) async => null);

      final token = await tokenStorage.getToken();

      expect(token, isNull);
      verify(() => mockStorage.read(key: 'auth_token')).called(1);
    });

    test('clearToken deletes token from secure storage', () async {
      when(
        () => mockStorage.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {});

      await tokenStorage.clearToken();

      verify(() => mockStorage.delete(key: 'auth_token')).called(1);
    });
  });
}
