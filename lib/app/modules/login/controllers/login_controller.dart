import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latihan/app/routes/servis/auth_service.dart';
import '../../../routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordHidden = true.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final box = GetStorage(); // Tambahan: GetStorage instance

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> loginUser() async {
    final email = usernameController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      errorMessage.value = 'Email dan password wajib diisi';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    final result = await AuthService.login(email, password);

    isLoading.value = false;

    if (result['success']) {
      final token = result['token'];
      final user = result['user']; // Ambil user dari respons

      if (token != null) {
        // Simpan token ke SharedPreferences (tidak diubah)
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        // Simpan juga token dan user ke GetStorage
        box.write('token', token);
        if (user != null) {
          box.write('user', user); // Simpan data user
          print("✅ Token & user disimpan.");
        } else {
          print("⚠️ Token disimpan, tapi user null.");
        }
      }

      Get.offAllNamed(Routes.HOME);
    } else {
      errorMessage.value = result['message'] ?? 'Login gagal';
    }
  }
}
