import 'package:get/get.dart';

import '../services/api_service.dart';

class TeacherDetailController extends GetxController {
  var isLoading = false.obs;
  var detail = {}.obs;
  var errorMessage = ''.obs;

  /// Fungsi untuk mengambil detail guru berdasarkan ID
  Future<void> fetchTeacherDetail(int teacherId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      detail.clear();

      final response = await ApiService.getTeacherDetail(teacherId);

      if (response['success']) {
        detail.value = response['data'];
      } else {
        errorMessage.value = response['message'] ?? 'Gagal mengambil detail guru';
      }
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
