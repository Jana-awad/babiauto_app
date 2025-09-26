// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'token_storage.dart';

// class ApiClient {
//   static const String baseUrl =
//       'http://10.0.2.2:8000/api/'; // replace with your API

//   final TokenStorage _tokenStorage = TokenStorage();

//   /// GET request
//   Future<dynamic> get(String endpoint, {required String TokenStorage, required String token}) async {
//     final url = Uri.parse('$baseUrl$endpoint');
//     final token = await _tokenStorage.getToken();

//     final headers = {
//       'Content-Type': 'application/json',
//       if (token != null) 'Authorization': 'Bearer $token',
//     };

//     final response = await http.get(url, headers: headers);

//     return _processResponse(response);
//   }

//   /// POST request
//   Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
//     final url = Uri.parse('$baseUrl$endpoint');
//     final token = await _tokenStorage.getToken();

//     final headers = {
//       'Content-Type': 'application/json',
//       if (token != null) 'Authorization': 'Bearer $token',
//     };

//     final response = await http.post(
//       url,
//       headers: headers,
//       body: jsonEncode(body),
//     );

//     return _processResponse(response);
//   }

//   /// PUT request
//   Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
//     final url = Uri.parse('$baseUrl$endpoint');
//     final token = await _tokenStorage.getToken();

//     final headers = {
//       'Content-Type': 'application/json',
//       if (token != null) 'Authorization': 'Bearer $token',
//     };

//     final response = await http.put(
//       url,
//       headers: headers,
//       body: jsonEncode(body),
//     );

//     return _processResponse(response);
//   }

//   /// DELETE request
//   Future<dynamic> delete(String endpoint) async {
//     final url = Uri.parse('$baseUrl$endpoint');
//     final token = await _tokenStorage.getToken();

//     final headers = {
//       'Content-Type': 'application/json',
//       if (token != null) 'Authorization': 'Bearer $token',
//     };

//     final response = await http.delete(url, headers: headers);

//     return _processResponse(response);
//   }

//   /// Process response
//   dynamic _processResponse(http.Response response) {
//     final statusCode = response.statusCode;
//     dynamic body;

//     try {
//       body = jsonDecode(response.body);
//     } catch (_) {
//       body = response.body;
//     }

//     if (statusCode >= 200 && statusCode < 300) {
//       return body;
//     } else if (statusCode == 401) {
//       throw Exception('Unauthorized. Please login again.');
//     } else if (statusCode == 422) {
//       if (body is Map<String, dynamic>) {
//         // Laravel validation errors
//         final errors = body.values.map((e) => e.join(', ')).join('\n');
//         throw Exception('Validation failed:\n$errors');
//       }
//       throw Exception('Validation failed: $body');
//     } else {
//       throw Exception('Request failed with status: $statusCode.\nBody: $body');
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_storage.dart';

class ApiClient {
  static const String baseUrl = 'http://192.168.10.100:8000/api/';

  final TokenStorage _tokenStorage = TokenStorage();

  /// GET request
  Future<dynamic> get(String endpoint, {String? token}) async {
    final url = Uri.parse('$baseUrl$endpoint');

    // Use token passed from outside or fallback to stored token
    final authToken = token ?? await _tokenStorage.getToken();

    final headers = {
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
    };

    final response = await http.get(url, headers: headers);

    return _processResponse(response);
  }

  /// POST request
  Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final authToken = token ?? await _tokenStorage.getToken();

    final headers = {
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    return _processResponse(response);
  }

  /// PUT request
  Future<dynamic> put(
    String endpoint,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final authToken = token ?? await _tokenStorage.getToken();

    final headers = {
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
    };

    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    return _processResponse(response);
  }

  /// DELETE request
  Future<dynamic> delete(String endpoint, {String? token}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final authToken = token ?? await _tokenStorage.getToken();

    final headers = {
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
    };

    final response = await http.delete(url, headers: headers);
    return _processResponse(response);
  }

  /// Process response
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
