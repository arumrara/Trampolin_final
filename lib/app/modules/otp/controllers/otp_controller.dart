import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../routes/app_pages.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();
  final isLoading = false.obs;

  late final String email;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'] ?? '';
    if (email.isEmpty) {
      Get.snackbar('Error', 'Email tidak ditemukan');
      Get.offAllNamed(Routes.REGISTER);
    }
  }

  void verifyOtp() async {
    final otp = otpController.text.trim();

    if (otp.isEmpty) {
      Get.snackbar("Error", "Kode OTP tidak boleh kosong",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse("https://backend-trampolin.vercel.app/verify-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "otp": otp,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar("Sukses", data['message'] ?? "OTP berhasil diverifikasi",
            backgroundColor: Colors.green, colorText: Colors.white);

        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.snackbar("Gagal", data['message'] ?? "OTP tidak valid",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan koneksi",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
