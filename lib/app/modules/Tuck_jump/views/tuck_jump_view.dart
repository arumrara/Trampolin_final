import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/tuck_jump_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class TuckJumpView extends GetView<TuckJumpController> {
  const TuckJumpView({super.key});

  // Fungsi membuka YouTube
  Future<void> _launchYoutube() async {
    final Uri url = Uri.parse('https://youtu.be/qGk0MTjwLPo?si=QhDHZJJQbvhe9AHO'); // Ganti jika ada video lain
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.snackbar('Gagal', 'Tidak dapat membuka link YouTube');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tuck Jump'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Pengertian Tuck Jump',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tuck Jump adalah lompatan eksplosif yang dilakukan dengan menarik lutut ke arah dada saat berada di udara. '
              'Gerakan ini biasa digunakan dalam latihan plyometric atau trampolin, bertujuan untuk melatih kekuatan kaki, koordinasi tubuh, dan keseimbangan.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '🔹 Persiapan Awal (Penting untuk Semua Drop)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Pemanasan: Lakukan pemanasan otot kaki, pinggul, dan punggung untuk menghindari cedera.\n'
              '• Posisi Siap: Berdiri dengan kaki selebar bahu, punggung tegak.\n'
              '• Gunakan trampolin atau permukaan datar dengan aman dan stabil.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Langkah-langkah Melakukan Tuck Jump:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '1. Berdirilah dengan posisi siap, lutut sedikit ditekuk.\n'
              '2. Lakukan lompatan vertikal sekuat mungkin.\n'
              '3. Saat berada di udara, tarik kedua lutut ke arah dada.\n'
              '4. Rapatkan tangan di depan tulang kering untuk menjaga keseimbangan.\n'
              '5. Lepaskan posisi tuck sebelum mendarat.\n'
              '6. Mendaratlah dengan lembut, lutut sedikit menekuk untuk menyerap benturan.',
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
