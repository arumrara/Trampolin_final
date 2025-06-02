import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var user = {}.obs;

  final String profileUrl = "http://192.168.71.240:5000/profile"; // Ganti dengan IP backend kamu

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      print("✅ TOKEN: $token");

      if (token.isEmpty) {
        Get.snackbar('Error', 'Token tidak ditemukan. Silakan login ulang.');
        return;
      }

      final response = await http.get(
        Uri.parse(profileUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("⛔ STATUS: ${response.statusCode}");
      print("⛔ BODY: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        user.value = data['user']; // ⬅️ ini penting
      } else if (response.statusCode == 401) {
        Get.snackbar('Unauthorized', 'Token tidak valid atau expired');
      } else {
        Get.snackbar('Error', 'Gagal mengambil profil: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Get.offAllNamed(Routes.LOGIN);
  }
}
