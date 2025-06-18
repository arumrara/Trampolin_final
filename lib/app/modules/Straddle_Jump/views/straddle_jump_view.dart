import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/straddle_jump_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class StraddleJumpView extends GetView<StraddleJumpController> {
  const StraddleJumpView({super.key});

  Future<void> _launchYoutube() async {
    final Uri url = Uri.parse('https://youtu.be/PJ-ZTGltpXY?si=S5pK5zw45zfY6BAV'); // Ganti jika ada link lebih cocok
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.snackbar('Gagal', 'Tidak dapat membuka link YouTube');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Straddle Jump'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Pengertian Straddle Jump',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Straddle Jump adalah jenis lompatan di mana kaki dibuka lebar ke samping selama berada di udara, '
              'sementara tangan diarahkan ke arah masing-masing kaki. Gerakan ini melatih fleksibilitas, kekuatan otot paha, dan koordinasi.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '🔹 Persiapan Awal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Lakukan pemanasan menyeluruh, khususnya otot paha dalam dan hamstring.\n'
              '• Gunakan trampolin atau permukaan datar yang aman dan stabil.\n'
              '• Pastikan posisi tubuh seimbang dan siap melompat.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Langkah-langkah Melakukan Straddle Jump:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '1. Berdiri tegak, kaki selebar bahu.\n'
              '2. Lakukan lompatan vertikal sekuat mungkin.\n'
              '3. Saat berada di udara, buka kedua kaki ke samping selebar mungkin.\n'
              '4. Arahkan kedua tangan ke masing-masing kaki (gerakan menyentuh atau mendekati kaki).\n'
              '5. Kembali ke posisi lurus sebelum mendarat.\n'
              '6. Mendarat dengan kedua kaki sejajar dan lutut sedikit ditekuk untuk meredam benturan.',
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
