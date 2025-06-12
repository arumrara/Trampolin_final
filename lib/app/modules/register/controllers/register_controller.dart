import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  void registerUser() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showError("Semua field harus diisi");
      return;
    }

    if (password.length < 0) {
      showError("Password minimal 8 karakter");
      return;
    }

    if (password != confirmPassword) {
      showError("Password dan konfirmasi tidak cocok");
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse("https://backend-trampolin.vercel.app/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": name,
          "email": email,
          "password": password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // Pindah ke halaman OTP
        Get.snackbar(
          "Sukses",
          "Kode OTP telah dikirim ke email",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Kirim data ke halaman OTP jika perlu
        Get.toNamed("/otp", arguments: {"email": email});
      } else {
        showError(data['message'] ?? "Gagal registrasi");
      }
    } catch (e) {
      showError("Terjadi kesalahan koneksi");
    } finally {
      isLoading.value = false;
    }
  }

  void showError(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
