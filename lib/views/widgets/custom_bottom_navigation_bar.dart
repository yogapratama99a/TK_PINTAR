import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userRole = box.read('user_role'); // ambil role dari GetStorage

    return BottomNavigationBar(
      backgroundColor: Colors.white,
      elevation: 10,
      currentIndex: selectedIndex,
      onTap: (index) {
        if (index != selectedIndex) {
          onItemTapped(index);

          String? homeRoute;
          String announcementRoute = '/announcements'; // default
          String profileRoute = '/profile';

          // Tentukan route home & announcement berdasarkan role
          if (userRole == 'parent') {
            homeRoute = '/home-parent';
          } else if (userRole == 'teacher') {
            homeRoute = '/home-teacher';
          }

          switch (index) {
            case 0:
              if (homeRoute != null) {
                Get.offNamed(homeRoute);
              }
              break;
            case 1:
              Get.offNamed(announcementRoute);
              break;
            case 2:
              Get.offNamed(profileRoute);
              break;
          }
        }
      },
      selectedItemColor: AppColors.green,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Beranda",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.campaign),
          label: "Pengumuman",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profil",
        ),
      ],
    );
  }
}
