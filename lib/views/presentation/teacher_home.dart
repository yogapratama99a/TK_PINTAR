import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/controllers/teacher_home_controller.dart';
import 'package:tk_pertiwi/views/presentation/article_screen.dart';
import 'package:tk_pertiwi/views/presentation/student_screen.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/custom_bottom_navigation_bar.dart';

class TeacherHomeScreen extends StatelessWidget {
  final TeacherHomeController controller = Get.put(TeacherHomeController());

  TeacherHomeScreen({super.key});

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
            child: Obx(() => Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.grey,
                      backgroundImage: controller.teacherImageUrl.isNotEmpty
                          ? NetworkImage(controller.teacherImageUrl.value)
                          : null,
                      child: controller.teacherImageUrl.isEmpty
                          ? const Icon(Icons.person, color: AppColors.white)
                          : null,
                    ),
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
                        Text(
                          controller.teacherName.value,
                          style: const TextStyle(
                            color: AppColors.black,
                            fontFamily: AppFonts.PoppinsBold,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.chat,
                        color: AppColors.blue,
                      ),
                      onPressed: () async {
                        Get.to(() => StudentChatScreen());
                      },
                    ),
                  ],
                )),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.articleController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.articleController.articles.isEmpty) {
          return const Center(child: Text('Tidak ada artikel tersedia'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: controller.articleController.articles.length,
          itemBuilder: (context, index) {
            final article = controller.articleController.articles[index];
            return GestureDetector(
              onTap: () => Get.to(() => ArticleScreen(
                    url: article.url,
                    title: article.title,
                    description: article.content ?? '',
                  )),
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.05),
                      blurRadius: 8,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(10)),
                      child: article.url.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: article.url,
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: AppColors.grey.withOpacity(0.1),
                                child: const Center(
                                  child: Icon(Icons.image,
                                      size: 50, color: Colors.grey),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: AppColors.grey.withOpacity(0.1),
                                child: const Center(
                                  child: Icon(Icons.broken_image,
                                      size: 50, color: Colors.grey),
                                ),
                              ),
                            )
                          : Container(
                              height: 150,
                              color: AppColors.grey.withOpacity(0.1),
                              child: const Center(
                                child: Icon(Icons.article,
                                    size: 50, color: Colors.grey),
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            controller.truncateDescription(article.content),
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.grey,
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
        );
      }),
       bottomNavigationBar: Obx(() => CustomBottomNavigationBar(
            selectedIndex: controller.selectedIndex.value,
            onItemTapped: controller.changeTabIndex,
          )),
    );
  }
}
