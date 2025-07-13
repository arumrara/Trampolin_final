import 'dart:io';
import 'package:Trampolin/app/modules/history/controllers/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:Trampolin/app/routes/servis/auth_service.dart';
import '../../../routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordHidden = true.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final box = GetStorage(); // GetStorage instance

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<String> getDeviceName() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return '${androidInfo.manufacturer} ${androidInfo.model}';
    } else {
      return 'unknown device';
    }
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
      final user = result['user'];

      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('email', email);

        box.write('token', token);
        if (user != null) {
          box.write('user', user);
          print("✅ Token & user disimpan.");
        } else {
          print("⚠️ Token disimpan, tapi user null.");
        }
      }

      final historyController = Get.put(HistoriController());
      final deviceName = await getDeviceName();
      historyController.addHistory(LoginHistory(
        email: email,
        provider: 'manual',
        loginTime: DateTime.now(),
        device: deviceName,
      ));

      Get.offAllNamed(Routes.HOME);
    } else {
      errorMessage.value = result['message'] ?? 'Login gagal';
    }
  }

  Future<void> loginWithGoogle() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        errorMessage.value = 'Login dibatalkan';
        isLoading.value = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', googleAuth.accessToken ?? '');
        await prefs.setString('email', user.email ?? '');

        box.write('token', googleAuth.accessToken);
        box.write('user', {
          'email': user.email,
          'username': user.displayName,
          'photo': user.photoURL,
          'uid': user.uid,
        });

        print("✅ Login Google berhasil & data disimpan.");

        final historyController = Get.put(HistoriController());
        final deviceName = await getDeviceName();
        historyController.addHistory(LoginHistory(
          email: user.email ?? '',
          provider: 'google',
          loginTime: DateTime.now(),
          device: deviceName,
        ));

        Get.offAllNamed(Routes.HOME);
      } else {
        errorMessage.value = 'Login gagal: user null';
      }
    } catch (e) {
      print('❌ Error login Google: $e');
      errorMessage.value = 'Terjadi kesalahan saat login Google';
    } finally {
      isLoading.value = false;
    }
  }
}
