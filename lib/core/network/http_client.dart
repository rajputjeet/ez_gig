import 'dart:async' as io;
import 'dart:convert';
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import '../errors/app_exception.dart';

class AppHttpClient {
  static const _timeout = Duration(seconds: 15);

  Future<Map<String, dynamic>> get(
    String baseUrl,
    String endpoint, {
    Map<String, String>? queryParams,
    String? token,
  }) async {
    try {
      var uri = Uri.parse('$baseUrl$endpoint');
      if (queryParams != null) {
        uri = uri.replace(queryParameters: queryParams);
      }
      final headers = _buildHeaders(token);
      final response =
          await http.get(uri, headers: headers).timeout(_timeout);
      return _handleResponse(response);
    } on io.SocketException {
      throw const NetworkException();
    } on io.TimeoutException {
      throw const TimeoutException();
    }
  }

  Future<Map<String, dynamic>> post(
    String baseUrl,
    String endpoint, {
    required Map<String, dynamic> body,
    String? token,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final headers = _buildHeaders(token);
      final response = await http
          .post(uri, headers: headers, body: jsonEncode(body))
          .timeout(_timeout);
      return _handleResponse(response);
    } on io.SocketException {
      throw const NetworkException();
    } on io.TimeoutException {
      throw const TimeoutException();
    }
  }

  Map<String, String> _buildHeaders(String? token) {
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode >= 200 && response.statusCode < 300) return body;
    if (response.statusCode == 401) throw const UnauthorizedException();
    throw ServerException(
      message: body['message']?.toString() ?? 'Server error occurred.',
      statusCode: response.statusCode,
    );
  }
}
