import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pike_jump_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class PikeJumpView extends GetView<PikeJumpController> {
  const PikeJumpView({super.key});

  Future<void> _launchYoutube() async {
    final Uri url = Uri.parse('https://youtu.be/9-UZWBkoldU?si=XtK-hpDk6XrA5YK9'); // Ganti dengan video sesuai
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.snackbar('Gagal', 'Tidak dapat membuka link YouTube');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pike Jump'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Pengertian Pike Jump',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pike Jump adalah gerakan lompat di mana kaki diluruskan ke depan sejajar, dan tubuh dilipat ke arah kaki selama berada di udara. '
              'Gerakan ini banyak digunakan dalam senam atau trampolin untuk melatih fleksibilitas, kontrol tubuh, dan kekuatan inti.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '🔹 Persiapan Awal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Lakukan pemanasan menyeluruh terutama bagian kaki dan punggung.\n'
              '• Pastikan posisi berdiri seimbang dan kontrol lompat sudah baik.\n'
              '• Gunakan trampolin dalam kondisi aman dan stabil.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Langkah-langkah Melakukan Pike Jump:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '1. Berdiri tegak dan lakukan beberapa lompatan biasa.\n'
              '2. Lakukan lompatan eksplosif ke atas.\n'
              '3. Saat berada di udara, luruskan kedua kaki ke depan sejajar dengan lantai.\n'
              '4. Jangkau ke arah jari kaki dengan tangan, jaga lutut tetap lurus.\n'
              '5. Lepaskan posisi sebelum mendarat.\n'
              '6. Mendarat dengan lutut sedikit ditekuk dan posisi tubuh seimbang.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _launchYoutube,
              icon: const Icon(Icons.video_library),
              label: const Text('Lihat Video di YouTube'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
