import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tk_pertiwi/controllers/article_controller.dart';

class TeacherHomeController extends GetxController {
  var teacherName = ''.obs;
  var teacherImageUrl = ''.obs;
  var isNotificationActive = false.obs;
  var selectedIndex = 0.obs;

  final ArticleController articleController = Get.put(ArticleController());

  @override
  void onInit() {
    super.onInit();
    loadTeacherFromProfile();
    articleController.fetchArticles();
  }

  Future<void> loadTeacherFromProfile() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final profileString = prefs.getString('profile');

    if (profileString != null) {
      final profile = jsonDecode(profileString);

      // Karena profile sudah langsung berisi data guru (tidak ada profile['profile'])
      teacherName.value = profile['name'] ?? 'Guru TK Pertiwi';
      teacherImageUrl.value = profile['image']?.toString() ?? '';
    }
  } catch (e) {
    print('❌ Error loading teacher profile: $e');
  }
}


  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  void toggleNotification() {
    isNotificationActive.value = !isNotificationActive.value;
  }

  String truncateDescription(String? text, {int maxLength = 100}) {
    if (text == null || text.length <= maxLength) return text ?? '';
    return '${text.substring(0, maxLength)}...';
  }
}