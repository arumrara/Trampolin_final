import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/jump_drop_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class JumpDropView extends GetView<JumpDropController> {
  const JumpDropView({super.key});

  // Fungsi membuka YouTube
  Future<void> _launchYoutube() async {
    final Uri url = Uri.parse('https://youtu.be/LrZuW-sJPBo?si=9j_6iJU_AVU-_lWH');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.snackbar('Gagal', 'Tidak dapat membuka link YouTube');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jumping Drop'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Pengertian Jumping Drop',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Gerakan "jumping drop" dalam olahraga trampolin adalah aksi melompat ke atas dari permukaan trampolin, lalu secara sengaja mendarat kembali di permukaan trampolin tersebut dengan bagian tubuh selain kaki '
              '(misalnya pantat, perut, atau punggung), kemudian menggunakan pantulan trampolin untuk kembali ke posisi berdiri atau transisi ke gerakan selanjutnya. '
              'Gerakan ini bertujuan untuk melatih kekuatan otot kaki dan kontrol pendaratan.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Persiapan Awal (Penting untuk Semua Drop)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Pemanasan: Selalu lakukan pemanasan ringan sebelum melompat di trampolin untuk mempersiapkan otot dan sendi, mencegah cedera.\n'
              '• Kontrol Lompatan Dasar: Pastikan Anda bisa melompat lurus ke atas dan ke bawah dengan stabil dan terkontrol. Ini adalah fondasi dari semua gerakan trampolin.\n'
              '• Kondisi Trampolin: Pastikan trampolin dalam kondisi baik, kokoh, dan aman. Hindari melompat lebih dari satu orang di satu area trampolin.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Langkah-langkah Melakukan Jumping Drop:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '1. Berdiri Tegak: Mulailah dengan posisi berdiri tegak di tengah trampolin.\n'
              '2. Tangan di Samping: Letakkan tangan di samping tubuh untuk menjaga keseimbangan.\n'
              '3. Tekuk Lutut: Tekuk lutut sedikit untuk mempersiapkan lonpatan.\n'
              '4. Loncatan ke Atas: Dorong kaki ke bawah dan loncat ke atas dengan kuat. Pastikan untuk menjaga tubuh tetap lurus.\n'
              '5. Arahkan Kaki ke Bawah: Saat mencapai puncak lonjakan, arahkan kaki ke bawah dan bersiap untuk mendarat.\n'
              '6. Posisi Tubuh: Jaga tubuh tetap tegak dan sedikit condong ke depan untuk membantu mendarat dengan baik.\n',
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
