import 'package:get/get.dart';
import 'package:tk_pertiwi/models/student_model.dart';
import 'package:tk_pertiwi/services/api_service.dart';

class StudentController extends GetxController {
  var isLoading = true.obs;
  var students = <Student>[].obs;
  var filteredStudents = <Student>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    try {
      isLoading(true);
       final token = await ApiService.getToken();
    print('Token yang digunakan: $token');
      final result = await ApiService.getMyStudent();
      print('Response fetchMyTeacher: $result');

      if (result['success'] == true) {
        students.assignAll((result['data'] as List)
            .map((e) => Student.fromJson(e))
            .toList());
        filteredStudents.assignAll(students);
      } else {
        errorMessage(result['message'] ?? 'Gagal memuat data siswa');
      }
    } catch (e) {
      errorMessage('Terjadi kesalahan: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  void filterStudents(String query) {
    if (query.isEmpty) {
      filteredStudents.assignAll(students);
    } else {
      filteredStudents.assignAll(students
          .where((student) =>
              student.name.toLowerCase().contains(query.toLowerCase()) ||
              student.parentName!.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }
  }
}
