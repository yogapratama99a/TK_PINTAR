import 'package:get/get.dart';
import '../models/learning_outcome_model.dart';
import '../services/api_service.dart';

class LearningOutcomeController extends GetxController {
  // State management
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  // Data yang akan digunakan di UI
  var learningOutcome = Rxn<LearningOutcomeModel>();

  @override
  void onInit() {
    super.onInit();
    fetchLearningOutcomes();
  }

  Future<void> fetchLearningOutcomes() async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';
    
    try {
      final result = await ApiService.getLearningOutcomes();

      if (result['success'] == true && result['data'] != null) {
        // Mapping JSON ke model
        learningOutcome.value = LearningOutcomeModel.fromJson(result['data']);
      } else {
        hasError.value = true;
        errorMessage.value = result['message'] ?? 'Gagal mengambil data dari server';
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Terjadi kesalahan: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
