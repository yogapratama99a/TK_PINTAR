import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tk_pertiwi/services/api_service.dart';

class TeacherStaffController extends GetxController {
  var isLoading = false.obs;
  var filteredTeachers = [].obs;
  RxList<dynamic> teacherList = <dynamic>[].obs;
  RxList<Map<String, dynamic>> myTeacherList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async {
    fetchTeachers();
  }

  // ✅ Ambil semua data guru/staff
  void fetchTeachers() async {
    try {
      isLoading.value = true;
      final token = await ApiService.getToken();
      print('Token yang digunakan: $token');
      final result = await ApiService.getTeacherStaff();

      if (result['success'] == true) {
        final data = result['data'];

        if (data != null && data is List) {
          teacherList.value = data;
          filteredTeachers.value = data;
        } else {
          Get.snackbar('Error', 'Data guru/staff tidak valid');
        }
      } else {
        Get.snackbar('Gagal', result['message'] ?? 'Gagal memuat data guru');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan saat mengambil data guru');
    } finally {
      isLoading.value = false;
    }
  }



  void showAllTeachers() {
    fetchTeachers(); // Ambil ulang semua guru
  }

  // void showHomeroomTeachers() {
  //   fetchMyTeacher(); // Ambil hanya wali kelas berdasarkan user
  //   if (myTeacherList.isNotEmpty) {
  //     filteredTeachers.value = myTeacherList; // Menampilkan hanya wali kelas
  //   } else {
  //     Get.snackbar('Error', 'Wali kelas tidak ditemukan');
  //   }
  // }

  void filterTeachers(String query) {
    if (query.isEmpty) {
      filteredTeachers.value = teacherList;
    } else {
      final lowerQuery = query.toLowerCase();
      filteredTeachers.value = teacherList.where((teacher) {
        return teacher['name'].toString().toLowerCase().contains(lowerQuery) ||
            teacher['position'].toString().toLowerCase().contains(lowerQuery);
      }).toList();
    }
  }
}
