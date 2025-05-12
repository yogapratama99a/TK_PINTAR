import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tk_pertiwi/controllers/announcement_controller.dart';
import 'package:tk_pertiwi/controllers/article_controller.dart';
import 'package:tk_pertiwi/models/announcement_model.dart';
import 'package:tk_pertiwi/models/article_model.dart';
import 'package:tk_pertiwi/services/api_service.dart';

class ParentHomeController extends GetxController {
  var studentName = ''.obs;
  var studentImageUrl = ''.obs;
  var classId = ''.obs;

  var Loading = false.obs;
  RxList<dynamic> teacherList = <dynamic>[].obs;
  RxList<Map<String, dynamic>> myTeacherList = <Map<String, dynamic>>[].obs;

  final ArticleController articleController = Get.put(ArticleController());
  final AnnouncementController announcementController = Get.put(AnnouncementController());

  @override
  void onInit() {
    super.onInit();
    loadStudentFromProfile();
    articleController.fetchArticles();
    announcementController.fetchAnnouncements(); // ✅ panggil langsung dari controller
    fetchMyTeacher();
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

  void fetchMyTeacher() async {
    try {
      Loading.value = true;

      final token = await ApiService.getToken();
      print('Token yang digunakan: $token');

      final result = await ApiService.getMyTeacher();
      print('Response fetchMyTeacher: $result');

      if (result['success'] == true) {
        final data = result['data'];

        if (data != null && data is List) {
          myTeacherList.value = List<Map<String, dynamic>>.from(data);
        } else if (data is Map<String, dynamic>) {
          myTeacherList.value = [data];
        } else {
          Get.snackbar('Error', 'Format data wali kelas tidak dikenali');
          return;
        }

        // ✅ SIMPAN ID WALI KELAS KE SHARED PREFERENCES (ambil id pertama jika ada)
        if (myTeacherList.isNotEmpty) {
          final teacherId = myTeacherList.first['id'];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('my_teacher_id', teacherId);
          print('ID wali kelas yang disimpan: $teacherId');
        } else {
          print('Tidak ada wali kelas ditemukan untuk disimpan');
        }
      } else {
        Get.snackbar('Gagal', result['message'] ?? 'Gagal memuat wali kelas');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan saat mengambil wali kelas');
    } finally {
      Loading.value = false;
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
