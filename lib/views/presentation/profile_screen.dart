import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/controllers/profile_controller.dart';
import 'package:tk_pertiwi/views/presentation/notification_screen.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/presentation/account_screen.dart';
import 'package:tk_pertiwi/views/presentation/login_screen.dart';
import 'package:tk_pertiwi/views/presentation/support_center_screen.dart';
import 'package:tk_pertiwi/views/presentation/change_password_screen.dart';
import 'package:tk_pertiwi/views/widgets/custom_bottom_navigation_bar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key}) {
    // Inisialisasi controller
    Get.put(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();


    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              const Color(0xFFE1F5FE).withOpacity(0.5),
              const Color(0xFFB3E5FC).withOpacity(0.3),
            ],
            stops: const [0.1, 0.5, 1.0],
          ),
        ),
        child: Column(
          children: [
            // App Bar
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.9),
                    Colors.white.withOpacity(0.7),
                  ],
                ),
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  "Profil",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: AppFonts.PoppinsBold,
                  ),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Profile Section with Card
                      Obx(() => Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF1E88E5),
                                  Color(0xFF0D47A1),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                )
                              ],
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: buildStudentAvatar(profileController
                                        .studentImageUrl.value),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "Halo, ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: AppFonts.PoppinsRegular,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    profileController.studentName.value,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AppFonts.PoppinsBold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),

                      const SizedBox(height: 32),

                      // Menu Items
                      _profileMenuItem(Icons.account_circle, "Akun", context),
                      _profileMenuItem(
                          Icons.notifications, "Notifikasi", context),
                      _profileMenuItem(Icons.help, "Pusat Bantuan", context),
                      _profileMenuItem(Icons.lock, "Ubah Kata Sandi", context),
                      _profileMenuItem(Icons.logout, "Keluar", context,
                          isLogout: true),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => CustomBottomNavigationBar(
            selectedIndex: profileController.selectedIndex.value,
            onItemTapped: profileController.changeTabIndex,
          )),
    );
  }

  Widget _profileMenuItem(IconData icon, String title, BuildContext context,
      {bool isLogout = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: isLogout
              ? [
                  Colors.red.withOpacity(0.1),
                  Colors.red.withOpacity(0.05),
                ]
              : [
                  Colors.white.withOpacity(0.9),
                  Colors.white.withOpacity(0.7),
                ],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            spreadRadius: 2,
          )
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isLogout
                  ? [Colors.red.shade400, Colors.red.shade600]
                  : [const Color(0xFF1E88E5), AppColors.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isLogout ? Colors.red.shade700 : Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.PoppinsBold,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey.shade200, Colors.grey.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child:
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ),
        onTap: () {
          if (title == "Akun") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AccountScreen()),
            );
          } else if (title == "Notifikasi") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationScreen()),
            );
          } else if (title == "Pusat Bantuan") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SupportCenterScreen()),
            );
          } else if (title == "Ubah Kata Sandi") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangePasswordScreen()),
            );
          } else if (title == "Keluar") {
            _showLogoutConfirmation(context);
          }
        },
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.95),
                  Colors.white.withOpacity(0.9),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Keluar",
                  style: TextStyle(
                    fontFamily: AppFonts.PoppinsBold,
                    fontSize: 18,
                    color: Colors.red.shade700,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Apakah Anda yakin ingin keluar?",
                  style: TextStyle(
                    fontFamily: AppFonts.PoppinsRegular,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade200,
                              Colors.grey.shade100
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Batal",
                          style: TextStyle(
                            fontFamily: AppFonts.PoppinsRegular,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await profileController.clearProfile();
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.red.shade400, Colors.red.shade600],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Keluar",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppFonts.PoppinsBold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildStudentAvatar(String imageUrl) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.transparent,
      child: imageUrl.isEmpty
          ? const Icon(
              Icons.person,
              size: 50,
              color: AppColors.blue, // Pastikan warna tersedia
            )
          : CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
    );
  }
}
