import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan/app/routes/servis/auth_service.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordHidden = true.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> loginUser() async {
    final email = usernameController.text.trim(); // dianggap email
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
      Get.offAllNamed(Routes.HOME);
    } else {
      errorMessage.value = result['message'] ?? 'Login gagal';
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
