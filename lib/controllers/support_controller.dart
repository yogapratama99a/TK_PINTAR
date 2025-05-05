import 'package:get/get.dart';
import 'package:tk_pertiwi/models/support_model.dart';
import '../services/api_service.dart';

class SupportCenterController extends GetxController {
  var isLoading = false.obs;
  var supportList = <SupportModel>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchSupportCenter();
    super.onInit();
  }

  Future<void> fetchSupportCenter() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await ApiService.getSupportCenter();

      if (response['success'] == true) {
        supportList.value = List<SupportModel>.from(
          response['data'].map((e) => SupportModel.fromJson(e)),
        );
      } else {
        errorMessage.value = response['message'] ?? 'Gagal mengambil data support center';
      }
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
