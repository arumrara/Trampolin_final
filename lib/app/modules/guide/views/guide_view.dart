import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../routes/app_pages.dart';
import '../controllers/guide_controller.dart';

class GuideView extends GetView<GuideController> {
  const GuideView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panduan Pemula'),
        automaticallyImplyLeading: false, // ⛔️ Hapus tombol back
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) {
            Get.offAllNamed(Routes.HOME);
          } else if (index == 1) {
            Get.offAllNamed(Routes.ARTICLE);
          } else if (index == 2) {
            Get.offAllNamed(Routes.DETEKSI);
          } else if (index == 4) {
            Get.offAllNamed(Routes.PROFILE);
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
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 20,
            children: const [
              GuideItem(
                image: 'assets/images/Jumping.png',
                title: 'Jumping Drop',
                url: 'https://youtu.be/b45s101imxY',
              ),
              GuideItem(
                image: 'assets/images/Seat_Drop.png',
                title: 'Seat Drop',
                url: 'https://www.youtube.com/watch?v=DV4bL_wax0A&pp=ygUUc2VhdCBkcm9wIHRyYW1wb2xpbmU%3D',
              ),
              GuideItem(
                image: 'assets/images/Tuck_Jump.png',
                title: 'Tuck Jump',
                url: 'https://www.youtube.com/watch?v=LRJcVZ9AYjI&pp=ygUUdHVjayBqdW1wIHRyYW1wb2xpbmU%3D',
              ),
              GuideItem(
                image: 'assets/images/ike_Jump.png',
                title: 'Pike Jump',
                url: 'https://www.youtube.com/watch?v=k8uRTnnzMW8&pp=ygUUcGlrZSBqdW1wIHRyYW1wb2xpbmU%3D',
              ),
              GuideItem(
                image: 'assets/images/Straddle_Jump.png',
                title: 'Straddle Jump',
                url: 'https://www.youtube.com/watch?v=PJ-ZTGltpXY&pp=ygUYc3RydWRsbGUganVtcCB0cmFtcG9saW5l',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GuideItem extends StatelessWidget {
  final String image;
  final String title;
  final String url;

  const GuideItem({
    super.key,
    required this.image,
    required this.title,
    required this.url,
  });

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(url);

    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
          Get.snackbar("Error", "Tidak dapat membuka link");
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan saat membuka link");
      print("Exception saat membuka URL: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchURL,
      borderRadius: BorderRadius.circular(16),
      splashColor: Colors.blue.withOpacity(0.3),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFEFFF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(image, width: 80, height: 80),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
