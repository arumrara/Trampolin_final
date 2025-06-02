import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

void registerUser() async {
  final name = nameController.text.trim();
  final email = emailController.text.trim();
  final password = passwordController.text;

  if (name.isEmpty || email.isEmpty || password.length < 8) {
    Get.snackbar(
      "Error",
      "Semua field harus diisi dengan benar, dan password minimal 8 karakter",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return;
  }

  try {
    final response = await http.post(
      Uri.parse("http://192.168.229.125:5000/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": name,
        "email": email,
        "password": password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      Get.snackbar(
        "Sukses",
        data['message'] ?? "Registrasi berhasil. Silakan login.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      nameController.clear();
      emailController.clear();
      passwordController.clear();

      await Future.delayed(const Duration(seconds: 1));

      Get.offNamed('/login');
    } else {
      Get.snackbar(
        "Error",
        data['message'] ?? data['error'] ?? "Gagal registrasi",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  } catch (e) {
    Get.snackbar(
      "Error",
      "Terjadi kesalahan koneksi",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}


  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
