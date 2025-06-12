import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  Widget buildManfaatCard(String title, String desc) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Get.toNamed('/article');
          } else if (index == 2) {
            Get.toNamed('/deteksi');
          } else if (index == 3) {
            Get.toNamed('/guide');
          } else if (index == 4) {
            Get.toNamed('/profile');
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Artikel"),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: "Deteksi"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Panduan"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                "Manfaat\nOLAH RAGA TRAMPOLIN",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                  children: [
                    buildManfaatCard(
                      "Bikin Badan Bugar!",
                      "Melompat di trampolin bantu jantung lebih sehat dan tubuh jadi lebih kuat.",
                    ),
                    Image.asset(
                      'assets/images/women.png',
                      fit: BoxFit.cover,
                    ),
                    buildManfaatCard(
                      "Bye-bye Stres!",
                      "Rasa senang waktu melompat bisa bantu hilangkan stres dan bikin hati jadi ceria.",
                    ),
                    buildManfaatCard(
                      "Bakar Kalori Tanpa Bosan!",
                      "Lebih seru daripada lari, tapi tetap bikin tubuh sehat dan berat badan terjaga.",
                    ),
                    Image.asset(
                      'assets/images/man.png',
                      fit: BoxFit.cover,
                    ),
                    buildManfaatCard(
                      "Tidur Lebih Nyenyak",
                      "Setelah aktif bergerak, tubuh lebih rileks dan tidur pun jadi lebih berkualitas.",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
