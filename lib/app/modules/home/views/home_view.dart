import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  Widget buildCard(String title, String description, String imageAsset, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Image.asset(imageAsset, width: 60, height: 60),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(description, style: const TextStyle(fontSize: 13)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            // Tambahkan navigasi ke fitur scan jika tersedia
          } else if (index == 2) {
            Get.toNamed(Routes.PROFILE); // Navigasi ke halaman profile
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: "Deteksi"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            buildCard(
              "Artikel",
              "Temukan berbagai artikel informatif seputar trampolin—mulai dari manfaat kesehatan, teknik melompat yang aman, hingga tips memilih trampolin terbaik.",
              "assets/trampolin.png",
              onTap: () => Get.toNamed(Routes.ARTICLE), // Navigasi ke halaman Artikel
            ),
            buildCard(
              "Panduan Lengkap untuk Pemula",
              "Pelajari dasar-dasar trampolin mulai dari posisi tubuh yang benar hingga teknik lompatan pertama secara bertahap.",
              "assets/trampolin.png",
              onTap: () => Get.toNamed(Routes.GUIDE), // Navigasi ke halaman Panduan
            ),
            buildCard(
              "Deteksi Gerakan Pintar",
              "Lacak setiap gerakan saat berlatih trampolin secara langsung menggunakan kamera perangkatmu.",
              "assets/trampolin.png",
              onTap: () {
                // Tambahkan navigasi jika ada halaman deteksi
              },
            ),
          ],
        ),
      ),
    );
  }
}
