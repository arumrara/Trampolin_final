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
        title: const Text('Panduan Pemula'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.offAllNamed(Routes.HOME), // Kembali ke Home
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 20,
            children: const [
              GuideItem(image: 'assets/Jumping.png', title: 'Jumping Drop'),
              GuideItem(image: 'assets/Seat Drop.png', title: 'Seat Drop'),
              GuideItem(image: 'assets/Tuck Jump.png', title: 'Tuck Jump'),
              GuideItem(image: 'assets/Pike Jump.png', title: 'Pike Jump'),
              GuideItem(image: 'assets/Straddle Jump.png', title: 'Straddle Jump'),
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

  const GuideItem({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Text(title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
