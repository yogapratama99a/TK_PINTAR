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
    fetchMyTeacher(); // pastikan dijalankan setelah fetchTeachers
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

  void fetchMyTeacher() async {
  try {
    isLoading.value = true;

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
    isLoading.value = false;
  }
}


  void showAllTeachers() {
    fetchTeachers(); // Ambil ulang semua guru
  }

  void showHomeroomTeachers() {
    fetchMyTeacher(); // Ambil hanya wali kelas berdasarkan user
    if (myTeacherList.isNotEmpty) {
      filteredTeachers.value = myTeacherList; // Menampilkan hanya wali kelas
    } else {
      Get.snackbar('Error', 'Wali kelas tidak ditemukan');
    }
  }

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
