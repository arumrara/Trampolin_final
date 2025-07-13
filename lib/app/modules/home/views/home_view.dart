import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Get.toNamed('/deteksi');
          } else if (index == 2) {
            Get.toNamed('/guide');
          } else if (index == 3) {
            Get.toNamed('/profile');
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: "Deteksi"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Panduan"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text(
              "Selamat Datang di Aplikasi Trampolin Cerdas!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              "Temukan informasi, panduan, dan tips seputar dunia trampolin untuk mendukung aktivitas Anda menjadi lebih sehat dan menyenangkan.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            _buildArticleCard(
              context,
              title: "Manfaat Trampolin untuk Kesehatan",
              content:
                  "Trampolin bukan hanya alat permainan, tapi juga alat olahraga yang efektif. Melompat selama 10 menit di atas trampolin bisa membakar kalori setara jogging 30 menit.",
              url: "https://fithub.id/blog/senam-trampolin",
            ),
            _buildArticleCard(
              context,
              title: "Trampolin dan Perkembangan Anak",
              content:
                  "Melompat membantu anak-anak mengembangkan otot, koordinasi, dan keseimbangan. Trampolin adalah sarana belajar yang menyenangkan sekaligus sehat.",
              url: "https://bouncestreetasia.com/bounce-school-membantu-perkembangan-anak/",
            ),
            _buildArticleCard(
              context,
              title: "Tips Keamanan Bermain Trampolin",
              content:
                  "Pastikan anak-anak diawasi, gunakan jaring pelindung, dan hindari melompat lebih dari satu orang pada waktu bersamaan untuk mencegah cedera.",
              url: "https://bisnisplayground.com/tips-aman-bermain-trampolin/",
            ),
            _buildArticleCard(
              context,
              title: "Jenis Trampolin: Mana yang Cocok?",
              content:
                  "Ada mini trampoline, outdoor trampoline, hingga trampolin profesional. Pilih sesuai kebutuhan: olahraga ringan, bermain anak, atau akrobatik.",
              url: "https://www.gramedia.com/literasi/jenis-senam/?srsltid=AfmBOoqTD-d4wykRqSH437jUNq-JIf3QTV4AZf7vtASkG2xI48-SZMa0",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleCard(
    BuildContext context, {
    required String title,
    required String content,
    required String url,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WebViewPage(url: url, title: title),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 20),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(content, style: const TextStyle(fontSize: 14, height: 1.5)),
              const SizedBox(height: 8),
              const Text(
                "Baca Selengkapnya...",
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WebViewPage extends StatelessWidget {
  final String url;
  final String title;

  const WebViewPage({super.key, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
