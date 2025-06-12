import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const baseUrl = 'https://backend-trampolin.vercel.app'; // Ganti jika pakai emulator

  // REGISTER
  static Future<Map<String, dynamic>> register(
      String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': data['message'] ?? 'Registrasi berhasil',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Gagal mendaftar',
          'details': data,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan jaringan: $e',
      };
    }
  }

  // LOGIN
static Future<Map<String, dynamic>> login(
    String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': data['message'] ?? 'Login berhasil',
        'user': data['data'], // ✅ Ambil dari 'data'
        'token': data['access_token'], // ✅ Ambil dari 'access_token'
      };
    } else {
      return {
        'success': false,
        'message': data['message'] ?? data['error'] ?? 'Login gagal',
        'details': data,
      };
    }
  } catch (e) {
    return {
      'success': false,
      'message': 'Terjadi kesalahan jaringan: $e',
    };
  }
}
}