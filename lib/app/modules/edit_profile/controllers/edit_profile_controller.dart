import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProfileController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final isLoading = false.obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    final user = box.read('user');

    if (user != null) {
      usernameController.text = user['username'] ?? '';
      emailController.text = user['email'] ?? '';
    } else {
      Get.snackbar('Error', 'Data user tidak ditemukan');
    }
  }

  void updateProfile() async {
    isLoading.value = true;

    final token = box.read('token');
    final url = Uri.parse('https://backend-trampolin.vercel.app/profile/edit'); // Ganti URL dengan benar

    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': usernameController.text,
        'email': emailController.text,
      }),
    );

     if (response.statusCode == 200) {
    final updatedUser = jsonDecode(response.body)['user'];
    box.write('user', updatedUser);
    Get.snackbar('Sukses', 'Profil berhasil diperbarui');

    // ⬇️ Redirect ke halaman profile
    Get.offNamed('/profile');
    // Get.snackbar('Gagal', 'Terjadi kesalahan saat memperbarui profil');
     }
  }
}
