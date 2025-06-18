import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/seat_drop_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SeatDropView extends GetView<SeatDropController> {
  const SeatDropView({super.key});

  // Fungsi membuka YouTube
  Future<void> _launchYoutube() async {
    final Uri url = Uri.parse('https://youtu.be/P8_bm48WHuM?si=QSW7fIZNBILa-IhD'); // Ganti jika ada video lain
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.snackbar('Gagal', 'Tidak dapat membuka link YouTube');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Drop'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Pengertian Seat Drop',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Seat Drop adalah salah satu gerakan dasar dalam olahraga trampolin, di mana seseorang melompat dan mendarat dalam posisi duduk di atas trampolin, '
              'kemudian menggunakan pantulan untuk kembali ke posisi berdiri. Gerakan ini melatih kontrol tubuh, koordinasi, dan kekuatan otot inti.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '🔹 Persiapan Awal (Penting untuk Semua Drop)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Pemanasan: Selalu lakukan pemanasan ringan sebelum melompat di trampolin untuk mempersiapkan otot dan sendi, mencegah cedera.\n'
              '• Kontrol Lompatan Dasar: Pastikan Anda bisa melompat lurus ke atas dan ke bawah dengan stabil dan terkontrol.\n'
              '• Kondisi Trampolin: Pastikan trampolin dalam kondisi baik, kokoh, dan aman.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Langkah-langkah Melakukan Seat Drop:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '1. Mulai dengan beberapa lompatan lurus yang terkontrol.\n'
              '2. Saat berada di puncak lompatan, rentangkan kaki ke depan seolah duduk di kursi.\n'
              '3. Jaga punggung lurus dan otot inti tetap aktif.\n'
              '4. Mendaratlah di pantat dengan kaki lurus dan tangan di sisi belakang untuk membantu kontrol.\n'
              '5. Gunakan pantulan trampolin untuk kembali ke posisi berdiri.\n'
              '6. Ulangi untuk membentuk kontrol dan koordinasi yang lebih baik.',
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
