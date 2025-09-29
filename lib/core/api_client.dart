import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_storage.dart';

class ApiClient {
  static const String baseUrl = 'http://192.168.10.100:8000/api/';

  final http.Client httpClient;
  final TokenStorage tokenStorage;

  ApiClient({http.Client? httpClient, TokenStorage? tokenStorage})
    : httpClient = httpClient ?? http.Client(),
      tokenStorage = tokenStorage ?? TokenStorage();

  /// GET
  Future<dynamic> get(String endpoint, {String? token}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final authToken = token ?? await tokenStorage.getToken();

    final headers = {
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
    };

    final response = await httpClient
        .get(url, headers: headers)
        .timeout(const Duration(seconds: 15));
    return _processResponse(response);
  }

  /// POST
  Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final authToken = token ?? await tokenStorage.getToken();

    final headers = {
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
    };

    final response = await httpClient
        .post(url, headers: headers, body: jsonEncode(body))
        .timeout(const Duration(seconds: 15));
    return _processResponse(response);
  }

  /// PUT
  Future<dynamic> put(
    String endpoint,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final authToken = token ?? await tokenStorage.getToken();

    final headers = {
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
    };

    final response = await httpClient
        .put(url, headers: headers, body: jsonEncode(body))
        .timeout(const Duration(seconds: 15));
    return _processResponse(response);
  }

  /// DELETE
  Future<dynamic> delete(String endpoint, {String? token}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final authToken = token ?? await tokenStorage.getToken();

    final headers = {
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
    };

    final response = await httpClient
        .delete(url, headers: headers)
        .timeout(const Duration(seconds: 15));
    return _processResponse(response);
  }

  /// Handle response
  dynamic _processResponse(http.Response response) {
    final statusCode = response.statusCode;
    dynamic body;

    try {
      body = jsonDecode(response.body);
    } catch (_) {
      body = response.body;
    }

    if (statusCode >= 200 && statusCode < 300) {
      return body;
    } else if (statusCode == 401) {
      throw Exception('Unauthorized. Please login again.');
    } else if (statusCode == 422) {
      if (body is Map<String, dynamic>) {
        final errors = body.values.map((e) => e.join(', ')).join('\n');
        throw Exception('Validation failed:\n$errors');
      }
      throw Exception('Validation failed: $body');
    } else {
      throw Exception('Request failed with status: $statusCode.\nBody: $body');
    }
  }
}
