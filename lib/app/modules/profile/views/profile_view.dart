import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.user.isEmpty) {
          return Center(child: Text('Data profil tidak ditemukan'));
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Username: ${controller.user['username'] ?? ''}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Email: ${controller.user['email'] ?? ''}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Created at: ${controller.user['created_at'] ?? ''}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  controller.logout();
                },
                child: Text('Logout'),
              )
            ],
          ),
        );
      }),
    );
  }
}
