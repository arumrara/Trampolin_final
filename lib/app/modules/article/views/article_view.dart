import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/article_controller.dart';
import '../../../routes/app_pages.dart';

class ArticleView extends GetView<ArticleController> {
  const ArticleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Artikel"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.offAllNamed(Routes.HOME), // Tombol kembali ke Home
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Center(
              child: Image.asset(
                'assets/trampoline_jump.png', // Ganti sesuai nama file gambar
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Trampolin merupakan olahraga dengan gerakan akrobatik sambil memantul di atas trampolin. "
              "Olahraga ini mampu membuat tubuh menjadi lebih sehat, melatih keseimbangan, kekuatan otot, "
              "dan juga membuat tubuh menjadi lebih lentur.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              "Trampolin",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Get.offAllNamed(Routes.HOME);
          } else if (index == 1) {
            // Navigasi ke halaman scan (jika ada)
          } else if (index == 2) {
            Get.toNamed(Routes.PROFILE);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: "Scan"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
