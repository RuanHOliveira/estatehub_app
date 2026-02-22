import 'dart:convert';
import 'dart:typed_data';

import 'package:estatehub_app/src/utils/app_exception.dart';
import 'package:estatehub_app/src/utils/result.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiService {
  String get _baseUrl => dotenv.env['API_URL'] ?? 'http://localhost:8080/v1';

  static const _headers = {'Content-Type': 'application/json'};

  Future<Result<dynamic>> get(
    String path, {
    required String token,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$path');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 15));

      final decoded = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Result.success(decoded);
      }

      final errorCode =
          (decoded is Map<String, dynamic> ? decoded['error_code'] : null) ??
          'ErrUnknown';

      return Result.error(
        AppException(
          errorCode: errorCode as String,
          statusCode: response.statusCode,
        ),
      );
    } catch (_) {
      return Result.error(AppException.unknown());
    }
  }

  Future<Result<void>> delete(
    String path, {
    required String token,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$path');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http
          .delete(uri, headers: headers)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Result.success(null);
      }

      final decoded =
          response.body.isNotEmpty ? jsonDecode(response.body) : null;
      final errorCode =
          (decoded is Map<String, dynamic> ? decoded['error_code'] : null) ??
          'ErrUnknown';
      return Result.error(
        AppException(
          errorCode: errorCode as String,
          statusCode: response.statusCode,
        ),
      );
    } catch (_) {
      return Result.error(AppException.unknown());
    }
  }

  Future<Result<Map<String, dynamic>>> postMultipart(
    String path, {
    required String token,
    required Map<String, String> fields,
    Uint8List? imageBytes,
    String? imageName,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$path');
      final request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer $token';
      request.fields.addAll(fields);

      if (imageBytes != null && imageName != null) {
        final ext = imageName.split('.').last.toLowerCase();
        final contentType = ext == 'png'
            ? MediaType('image', 'png')
            : MediaType('image', 'jpeg');
        request.files.add(
          http.MultipartFile.fromBytes(
            'image',
            imageBytes,
            filename: imageName,
            contentType: contentType,
          ),
        );
      }

      final streamedResponse = await request
          .send()
          .timeout(const Duration(seconds: 15));
      final response = await http.Response.fromStream(streamedResponse);

      final decoded = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Result.success(decoded as Map<String, dynamic>);
      }

      final errorCode =
          (decoded is Map<String, dynamic> ? decoded['error_code'] : null) ??
          'ErrUnknown';

      return Result.error(
        AppException(
          errorCode: errorCode as String,
          statusCode: response.statusCode,
        ),
      );
    } catch (_) {
      return Result.error(AppException.unknown());
    }
  }

  Future<Result<Map<String, dynamic>>> post(
    String path,
    Map<String, dynamic> body,
  ) async {
    try {
      final uri = Uri.parse('$_baseUrl$path');
      final response = await http
          .post(uri, headers: _headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: 15));

      final decoded = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Result.success(decoded as Map<String, dynamic>);
      }

      final errorCode =
          (decoded is Map<String, dynamic> ? decoded['error_code'] : null) ??
          'ErrUnknown';

      return Result.error(
        AppException(
          errorCode: errorCode as String,
          statusCode: response.statusCode,
        ),
      );
    } catch (_) {
      return Result.error(AppException.unknown());
    }
  }
}
