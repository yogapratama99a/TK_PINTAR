import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/controllers/announcement_controller.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:tk_pertiwi/views/widgets/announcement_card.dart';
import 'package:tk_pertiwi/views/widgets/filter_button.dart';

class AnnouncementScreen extends StatelessWidget {
  AnnouncementScreen({super.key});

  final AnnouncementController controller = Get.put(AnnouncementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Pengumuman",
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
      body: Column(
        children: [
          // Filter Pengumuman
          Obx(() => Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilterButton(
                      title: "Semua",
                      isSelected: controller.selectedFilter.value == 0,
                      onTap: () => controller.changeFilter(0),
                    ),
                    FilterButton(
                      title: "Hari ini",
                      isSelected: controller.selectedFilter.value == 1,
                      onTap: () => controller.changeFilter(1),
                    ),
                    FilterButton(
                      title: "Minggu ini",
                      isSelected: controller.selectedFilter.value == 2,
                      onTap: () => controller.changeFilter(2),
                    ),
                  ],
                ),
              )),

          // List Pengumuman
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.green,
                  ),
                );
              }

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      const Color(0xFFB3DAF0).withOpacity(0.8),
                      const Color(0xFFE1F5FE).withOpacity(0.8),
                    ],
                    stops: const [0.1, 0.5, 1.0],
                  ),
                ),
                child: controller.filteredAnnouncements.isEmpty
                    ? const Center(
                        child: Text(
                          "Tidak ada pengumuman",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.filteredAnnouncements.length,
                        itemBuilder: (context, index) {
                          final announcement =
                              controller.filteredAnnouncements[index];
                          return AnnouncementCard(
                            title: announcement.title,
                            date: controller.formatDate(announcement.date),
                            message: announcement.content,
                          );
                        },
                      ),
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() => CustomBottomNavigationBar(
            selectedIndex: controller.selectedIndex.value,
            onItemTapped: controller.changeTabIndex,
          )),
    );
  }
}
