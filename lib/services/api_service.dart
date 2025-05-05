import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String _baseUrl = 'http://10.0.2.2:8000/api/';
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  /// Mendapatkan token dari SharedPreferences
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  /// GET
  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {
          'success': false,
          'message': 'Token tidak ditemukan',
        };
      }

      final response = await _dio.get(
        endpoint,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return {
        'success': true,
        'data': response.data['data'] ?? response.data,
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'Terjadi kesalahan: ${e.message}',
      };
    }
  }

  /// POST
  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _dio.post(endpoint, data: body);
      return {
        ...response.data,
        'statusCode': response.statusCode,
      };
    } on DioException catch (e) {
      if (e.response != null) {
        return {
          ...?e.response?.data,
          'statusCode': e.response?.statusCode,
        };
      } else {
        return {
          'success': false,
          'message': 'Tidak dapat terhubung ke server',
          'statusCode': 500,
        };
      }
    }
  }

  /// PUT
  static Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {
          'success': false,
          'message': 'Token tidak ditemukan',
        };
      }

      final response = await _dio.put(
        endpoint,
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      return {
        ...response.data,
        'statusCode': response.statusCode,
      };
    } on DioException catch (e) {
      if (e.response != null) {
        return {
          ...?e.response?.data,
          'statusCode': e.response?.statusCode,
        };
      } else {
        return {
          'success': false,
          'message': 'Tidak dapat terhubung ke server',
          'statusCode': 500,
        };
      }
    }
  }

  

  // ==== ENDPOINT SPESIFIK ====

  static Future<Map<String, dynamic>> getMyStudent() async => await get('my-student');
  static Future<Map<String, dynamic>> getMyTeacher() async => await get('my-teacher');
  static Future<Map<String, dynamic>> getTeacherStaff() async => await get('teacher-staff');
  static Future<Map<String, dynamic>> getArticles() async => await get('articles');
  static Future<Map<String, dynamic>> getAnnouncement() async => await get('announcement');
  static Future<Map<String, dynamic>> getSchedule() async => await get('schedule');
  static Future<Map<String, dynamic>> getPayment() async => await get('payment');
  static Future<Map<String, dynamic>> getLearningOutcomes() async => await get('learning-outcomes');
  static Future<Map<String, dynamic>> getTeacherDetail(int teacherId) async => await get('detail-teacher/$teacherId');
  static Future<Map<String, dynamic>> getProfile() async => await get('profile');
  static Future<Map<String, dynamic>> getSupportCenter() async => await get('support-center');
}
