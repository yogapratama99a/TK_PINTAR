import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tk_pertiwi/controllers/article_controller.dart';
import 'package:tk_pertiwi/controllers/parent_home_controller.dart';
import 'package:tk_pertiwi/views/presentation/article_screen.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:tk_pertiwi/views/widgets/announcement_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(ParentHomeController());
  final articleController = Get.find<ArticleController>();

  final PageController pageController = PageController();
  final RxInt selectedIndex = 0.obs;
  final RxBool isNotificationActive = false.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  void toggleNotification() {
    isNotificationActive.value = !isNotificationActive.value;
  }

  String truncateDescription(String? text, {int maxLength = 60}) {
    if (text == null || text.length <= maxLength) return text ?? '';
    return '${text.substring(0, maxLength)}...';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Row(
              children: [
                Obx(() {
                  return buildStudentAvatar(controller.studentImageUrl.value);
                }),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Selamat Datang,",
                      style: TextStyle(
                        color: AppColors.black,
                        fontFamily: AppFonts.PoppinsRegular,
                        fontSize: 12,
                      ),
                    ),
                    Obx(() => Text(
                          controller.studentName.value.isNotEmpty
                              ? controller.studentName.value
                              : 'Nama Pengguna',
                          style: const TextStyle(
                            color: AppColors.black,
                            fontFamily: AppFonts.PoppinsBold,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ))
                  ],
                ),
                const Spacer(),
                Obx(() => IconButton(
                      icon: Icon(
                        isNotificationActive.value
                            ? Icons.notifications_active
                            : Icons.notifications_off,
                        color: AppColors.blue,
                      ),
                      onPressed: toggleNotification,
                    )),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            _buildFacilitySlider(),
            const SizedBox(height: 32),
            _buildFeatures(),
            const SizedBox(height: 24),
            _buildAnnouncements(controller),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => CustomBottomNavigationBar(
            selectedIndex: selectedIndex.value,
            onItemTapped: changeTabIndex,
          )),
    );
  }

// Di dalam widget _buildFacilitySlider:
  Widget _buildFacilitySlider() {
    return Obx(() {
      if (articleController.articles.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: PageView.builder(
                controller: pageController,
                itemCount: articleController.articles.length,
                itemBuilder: (context, index) {
                  final article = articleController.articles[index];
                  return GestureDetector(
                    onTap: () => Get.to(() => ArticleScreen(
                          url: article.url,
                          title: article.title,
                          description: article.content ?? '',
                        )),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: AppColors.darkBlue,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.05),
                            blurRadius: 8,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: article.url,
                              width: 120,
                              height: 100,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  article.title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                                ),
                                const Divider(color: Colors.white),
                                Text(
                                  truncateDescription(article.content),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            SmoothPageIndicator(
              controller: pageController,
              count: articleController.articles.length,
              effect: const ExpandingDotsEffect(
                activeDotColor: AppColors.black,
                dotColor: AppColors.grey,
                dotHeight: 8,
                dotWidth: 8,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildFeatures() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.lightBlue,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 6,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Fitur yang tersedia",
            style: TextStyle(
              fontSize: 16,
              fontFamily: AppFonts.PoppinsBold,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCircleFeature(Icons.schedule, "Jadwal",
                  [AppColors.schedule, AppColors.schedule1], () {
                Get.toNamed('/schedule');
              }),
              _buildCircleFeature(Icons.school, "Guru & Staff",
                  [AppColors.gurustaff, AppColors.gurustaff1], () {
                Get.toNamed('/teacherstaff');
              }),
              _buildCircleFeature(Icons.assessment, "Hasil Belajar",
                  [AppColors.learning, AppColors.learning1], () {
                Get.toNamed('/learningoutcomes');
              }),
              _buildCircleFeature(Icons.payment, "Pembayaran",
                  [AppColors.payment, AppColors.payment1], () {
                Get.toNamed('/payment');
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleFeature(
    IconData icon,
    String label,
    List<Color> gradientColors,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  blurRadius: 4,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncements(ParentHomeController controller) {
    return Obx(() {
      final announcementsToday = controller.todayAnnouncements;

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.mediumBlue.withOpacity(0.8),
              AppColors.lightBlue.withOpacity(0.8),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.05),
              blurRadius: 6,
              spreadRadius: 2,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Informasi Terbaru",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 12),
            if (announcementsToday.isEmpty)
              const Text(
                "Tidak ada pengumuman hari ini.",
                style: TextStyle(color: AppColors.black),
              )
            else
              ...announcementsToday.map((data) => AnnouncementCard(
                    title: data.title,
                    position: data.teacherPoisition,
                    message: data.content,
                    imageUrl: data.teacherImageUrl,
                    name: data.teacherName,
                    date: DateFormat('dd MMM yyyy').format(data.date),
                  )),
          ],
        ),
      );
    });
  }

  Widget buildStudentAvatar(String imageUrl) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.transparent,
      backgroundImage:
          imageUrl.isEmpty ? null : CachedNetworkImageProvider(imageUrl),
      child: imageUrl.isEmpty
          ? const Icon(
              Icons.person,
              color: AppColors.blue,
            )
          : null,
    );
  }
}
