import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/guide_controller.dart';

class GuideView extends GetView<GuideController> {
  const GuideView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panduan'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.offAllNamed(Routes.HOME);
              break;
            case 1:
              Get.offAllNamed(Routes.DETEKSI);
              break;
            case 2:
              break;
            case 3:
              Get.offAllNamed(Routes.PROFILE);
              break;
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
      backgroundColor: const Color(0xFFF9F9F9),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          GuideItem(
            image: 'assets/images/Jump_Drop.png',
            title: 'Jump Drop',
            route: Routes.JUMP_DROP,
          ),
          GuideItem(
            image: 'assets/images/Seat_Drop.png',
            title: 'Seat Drop',
            route: Routes.SEAT_DROP,
          ),
          GuideItem(
            image: 'assets/images/Tuck_Jump.png',
            title: 'Tuck Jump',
            route: Routes.TUCK_JUMP,
          ),
          GuideItem(
            image: 'assets/images/Pike_Jump.png',
            title: 'Pike Jump',
            route: Routes.PIKE_JUMP,
          ),
          GuideItem(
            image: 'assets/images/Straddle_Jump.png',
            title: 'Straddle Jump',
            route: Routes.STRADDLE_JUMP,
          ),
        ],
      ),
    );
  }
}

class GuideItem extends StatelessWidget {
  final String image;
  final String title;
  final String? route;

  const GuideItem({
    Key? key,
    required this.image,
    required this.title,
    this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (route != null) {
          Get.toNamed(route!);
        } else {
          Get.snackbar("Info", "Halaman untuk \"$title\" belum tersedia.");
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
