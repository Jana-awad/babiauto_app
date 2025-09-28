import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:babiauto_app/core/api_client.dart';
import 'package:babiauto_app/core/token_storage.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockTokenStorage extends Mock implements TokenStorage {}

void main() {
  late MockHttpClient mockHttp;
  late MockTokenStorage mockTokenStorage;
  late ApiClient apiClient;

  setUp(() {
    mockHttp = MockHttpClient();
    mockTokenStorage = MockTokenStorage();
    apiClient = ApiClient(httpClient: mockHttp, tokenStorage: mockTokenStorage);
  });

  test('GET returns decoded JSON when status 200', () async {
    when(() => mockTokenStorage.getToken()).thenAnswer((_) async => 'abc123');
    when(
      () => mockHttp.get(
        Uri.parse('${ApiClient.baseUrl}cars'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((_) async => http.Response(jsonEncode({'data': 'car'}), 200));

    final result = await apiClient.get('cars');
    expect(result, {'data': 'car'});
  });

  test('POST throws exception when unauthorized', () async {
    when(() => mockTokenStorage.getToken()).thenAnswer((_) async => null);
    when(
      () => mockHttp.post(
        Uri.parse('${ApiClient.baseUrl}login'),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async => http.Response('Unauthorized', 401));

    expect(() => apiClient.post('login', {'email': 'x'}), throwsException);
  });

  test('PUT returns decoded JSON on success', () async {
    when(() => mockTokenStorage.getToken()).thenAnswer((_) async => 'tok');
    when(
      () => mockHttp.put(
        Uri.parse('${ApiClient.baseUrl}cars/1'),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer(
      (_) async => http.Response(jsonEncode({'updated': true}), 200),
    );

    final result = await apiClient.put('cars/1', {'name': 'Tesla'});
    expect(result, {'updated': true});
  });

  test('DELETE throws exception on server error', () async {
    when(() => mockTokenStorage.getToken()).thenAnswer((_) async => 'tok');
    when(
      () => mockHttp.delete(
        Uri.parse('${ApiClient.baseUrl}cars/1'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((_) async => http.Response('Internal error', 500));

    expect(() => apiClient.delete('cars/1'), throwsException);
  });
}
