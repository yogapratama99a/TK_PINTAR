import 'package:get/get.dart';
import '../services/api_service.dart';

class ScheduleController extends GetxController {
  var isLoading = false.obs;
  var scheduleData = <String, List<Map<String, dynamic>>>{}.obs;
  var selectedFilter = 'Semua Hari'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSchedule();
  }

  Future<void> fetchSchedule() async {
    try {
      isLoading.value = true;

      final response = await ApiService.get('schedule');
      print(response); // Cek data respons yang diterima

      final data = response['data']; // Pastikan kita mengakses data dengan benar
      if (data != null && data is Map<String, dynamic>) {
        final result = <String, List<Map<String, dynamic>>>{};
        
        // Mengurutkan hari berdasarkan urutan yang diinginkan
        List<String> urutanHari = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
        
        for (var hari in urutanHari) {
          if (data.containsKey(hari)) {
            // Urutkan jadwal berdasarkan jam mulai
            List<Map<String, dynamic>> activities = List<Map<String, dynamic>>.from(data[hari]);
            activities.sort((a, b) {
              var jamA = a['Jam'].split(' - ')[0]; // Ambil jam mulai
              var jamB = b['Jam'].split(' - ')[0]; // Ambil jam mulai
              return jamA.compareTo(jamB);
            });
            result[hari] = activities;
          }
        }

        scheduleData.value = result;
      }
        } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data jadwal');
    } finally {
      isLoading.value = false;
    }
  }
}
