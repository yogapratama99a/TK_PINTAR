import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tk_pertiwi/services/api_service.dart';

class AccountController extends GetxController {
  var studentName = ''.obs;
  var studentImageUrl = ''.obs;
  var studentBorn = ''.obs;
  RxString studentGender = "Laki-laki".obs;
  RxString studentReligion = "Islam".obs;

  var parentName = ''.obs;
  var parentAddress = ''.obs;
  var parentPhone = ''.obs;

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileString = prefs.getString('profile');

    if (profileString != null) {
      final profile = jsonDecode(profileString);

      // Ambil data dari role yang sesuai (student, teacher, atau parent)
      final student = profile['student'];
      final teacher = profile['teacher'];
      final parent = profile['parent'];

      if (student != null) {
        studentName.value = student['name'] ?? '';
        studentImageUrl.value = student?['image'] ?? '';
        studentBorn.value = student['ttl'] ?? '';
        studentGender.value = student['gender'] ?? 'Laki-laki';
        studentReligion.value = student['religion'] ?? 'Islam';
      }

      // Jika teacher atau parent, ambil gambar dari sana jika student tidak punya
      if (studentImageUrl.value.isEmpty) {
        if (teacher != null) {
          studentImageUrl.value = teacher['image'] ?? '';
        } else if (parent != null) {
          studentImageUrl.value = parent['image'] ?? '';
        }
      }

      // Data orang tua (profile utama)
      parentName.value = profile['name'] ?? '';
      parentAddress.value = profile['address'] ?? '';
      parentPhone.value = profile['phone_number'] ?? '';

      print('PROFILE DATA: $profileString');
      print('PHONE: ${profile['phone_number']}');
      print('ADDRESS: ${profile['address']}');
    }
  }
static Future<Map<String, dynamic>> updateStudentParentProfile({
  required String studentName,
  required String ttl,
  required String gender,
  required String religion,
  required String parentPhoneNumber,
  required String parentAddress,
}) async {
  final body = {
    'name': studentName,  // Ganti 'student.name' dengan 'name'
    'ttl': ttl,           // Ganti 'student.ttl' dengan 'ttl'
    'gender': gender,
    'religion': religion,
    'phone_number': parentPhoneNumber,  // Untuk data orang tua, biarkan tetap dengan 'parent.'
    'address': parentAddress,
  };

  // Tambahkan print untuk debug
  print('Data yang dikirim ke API student/profile:');
  body.forEach((key, value) {
    print('$key: $value');
  });

  return await ApiService.put('student/profile', body);
}


}
