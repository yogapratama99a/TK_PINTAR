// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tk_pertiwi/controllers/announcement_controller.dart';
// import 'package:tk_pertiwi/controllers/article_controller.dart';
// import 'package:tk_pertiwi/models/announcement_model.dart';
// import 'package:tk_pertiwi/models/article_model.dart';

// class ParentHomeController extends GetxController {
//   var studentName = ''.obs;
//   var studentImageUrl = ''.obs;
//   var classId = ''.obs;

//   final ArticleController articleController = Get.put(ArticleController());
//   final AnnouncementController announcementController =
//       Get.put(AnnouncementController());

//   @override
//   void onInit() {
//     super.onInit();
//     loadStudentFromProfile();
//     articleController.fetchArticles();
//     fetchAnnouncements();
//   }

//   Future<void> loadStudentFromProfile() async {
//     final prefs = await SharedPreferences.getInstance();
//     final profileString = prefs.getString('profile'); // ✅ disesuaikan

//     if (profileString != null) {
//       final profile = jsonDecode(profileString);
//       final student = profile['student'];

//       if (student != null) {
//         studentName.value = student['name'] ?? 'Nama tidak ditemukan';
//         studentImageUrl.value = student['image']?.toString() ?? '';
//         classId.value = student['class_id']?.toString() ?? '';
//       } else {
//         print('Data student tidak ditemukan di dalam profil');
//       }
//     } else {
//       print('Data profil tidak ditemukan di SharedPreferences');
//     }
//   }

//   List<ArticleModel> get articles => articleController.articles;
//   bool get isLoading => articleController.isLoading.value;
//   String get errorMessage => articleController.errorMessage.value;

//   String truncateDescription(String description, {int maxLength = 50}) {
//     return (description.length > maxLength)
//         ? '${description.substring(0, maxLength)}...'
//         : description;
//   }

//   List<Announcement> get todayAnnouncements =>
//       announcementController.getTodayAnnouncements();

//   Future<void> fetchAnnouncements() async {
//     await announcementController.fetchAnnouncements();
//   }
// }
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tk_pertiwi/controllers/announcement_controller.dart';
import 'package:tk_pertiwi/controllers/article_controller.dart';
import 'package:tk_pertiwi/models/announcement_model.dart';
import 'package:tk_pertiwi/models/article_model.dart';

class ParentHomeController extends GetxController {
  var studentName = ''.obs;
  var studentImageUrl = ''.obs;
  var classId = ''.obs;

  final ArticleController articleController = Get.put(ArticleController());
  final AnnouncementController announcementController = Get.put(AnnouncementController());

  @override
  void onInit() {
    super.onInit();
    loadStudentFromProfile();
    articleController.fetchArticles();
    announcementController.fetchAnnouncements(); // ✅ panggil langsung dari controller
  }

  Future<void> loadStudentFromProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileString = prefs.getString('profile');

    if (profileString != null) {
      final profile = jsonDecode(profileString);
      final student = profile['student'];

      if (student != null) {
        studentName.value = student['name'] ?? 'Nama tidak ditemukan';
        studentImageUrl.value = student['image']?.toString() ?? '';
        classId.value = student['class_id']?.toString() ?? '';
      } else {
        print('❌ Data student tidak ditemukan di dalam profil');
      }
    } else {
      print('❌ Data profil tidak ditemukan di SharedPreferences');
    }
  }

  // Artikel
  List<ArticleModel> get articles => articleController.articles;
  bool get isLoading => articleController.isLoading.value;
  String get errorMessage => articleController.errorMessage.value;

  String truncateDescription(String description, {int maxLength = 50}) {
    return (description.length > maxLength)
        ? '${description.substring(0, maxLength)}...'
        : description;
  }

  // Pengumuman hari ini
  List<Announcement> get todayAnnouncements => announcementController.getTodayAnnouncements();
}
