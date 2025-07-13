import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var user = {}.obs;
  final box = GetStorage();

  final String profileUrl = "https://backend-trampolin.vercel.app/profile"; // Ganti dengan IP backend kamu

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

Future<void> fetchProfile() async {
  isLoading.value = true;

  try {
    // Mengambil data dari SharedPreferences atau GetStorage
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final userData = box.read('user'); // Mengambil data user dari box

    print("✅ TOKEN: $token");

    if (token.isEmpty) {
      Get.snackbar('Error', 'Token tidak ditemukan. Silakan login ulang.');
      return;
    }

    if (userData != null) {
      // Jika data user sudah ada di box, langsung diset ke user
      user.value = userData;
      print("✅ User data ditemukan: $userData");
    } else {
      // Jika data user tidak ada, tampilkan pesan kesalahan
      Get.snackbar('Error', 'Data profil tidak ditemukan.');
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
