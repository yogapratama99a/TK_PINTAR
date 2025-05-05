import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';

class NavbarTeacher extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const NavbarTeacher({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      elevation: 10,
      currentIndex: selectedIndex,
      onTap: (index) {
        if (index != selectedIndex) {
          onItemTapped(index);
          switch (index) {
            case 0:
              Get.offNamed('/home-teacher');
              break;
            case 1:
              Get.offNamed('/student');
              break;
            case 2:
              Get.offNamed('/profile');
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
          icon: Icon(Icons.chat),
          label: "Pesan",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profil",
        ),
      ]
    );
  }
}
