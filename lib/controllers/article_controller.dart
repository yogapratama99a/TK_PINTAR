import 'package:get/get.dart';
import 'package:tk_pertiwi/models/article_model.dart';
import 'package:tk_pertiwi/services/api_service.dart';

class ArticleController extends GetxController {
  var articles = <ArticleModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchArticles() async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await ApiService.getArticles();

    if (response['success'] == true) {
      final data = response['data'];
      if (data is List) {
        articles.value = ArticleModel.fromList(data);
      } else {
        errorMessage.value = 'Data artikel tidak valid';
      }
    } else {
      errorMessage.value = response['message'] ?? 'Gagal mengambil artikel';
    }

    isLoading.value = false;
  }
}
