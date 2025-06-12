import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  var isLoading = false.obs;
  var message = ''.obs;
  var isError = false.obs;

  void sendResetLink() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      message.value = 'Email tidak boleh kosong';
      isError.value = true;
      return;
    }

    isLoading.value = true;
    message.value = '';

    try {
      final response = await http.post(
        Uri.parse('https://backend-trampolin.vercel.app/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        isError.value = false;
        message.value = data['message'] ?? 'Link reset berhasil dikirim';
        emailController.clear();
      } else {
        isError.value = true;
        message.value = data['error'] ?? 'Terjadi kesalahan';
      }
    } catch (e) {
      isError.value = true;
      message.value = 'Gagal terhubung ke server';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
