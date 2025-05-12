import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tk_pertiwi/services/api_service.dart';

class AccountController extends GetxController {
  // Role user (student / teacher / parent)
  var userRole = ''.obs;
  final box = GetStorage();

  // Student
  var studentName = ''.obs;
  var studentImageUrl = ''.obs;
  var studentBorn = ''.obs;
  RxString studentGender = "Laki-laki".obs;
  RxString studentReligion = "Islam".obs;

  // Teacher
  var teacherName = ''.obs;
  var teacherImageUrl = ''.obs;
  var teacherBorn = ''.obs;
  var teacherAddress = ''.obs;
  var teacherPhone = ''.obs;
  var teacherNip = ''.obs;
  var teacherAboutMe = ''.obs;

  // Parent
  var parentName = ''.obs;
  var parentAddress = ''.obs;
  var parentPhone = ''.obs;

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileString = prefs.getString('profile');

    if (profileString != null) {
      final profile = jsonDecode(profileString);

      final role = box.read('user_role');
      userRole.value = role;

      // Ambil data student
      final student = profile['student'];
      if (role == 'parent') {
        studentName.value = student['name'] ?? '';
        studentImageUrl.value = student['image'] ?? '';
        studentBorn.value = student['ttl'] ?? '';
        studentGender.value = student['gender'] ?? 'Laki-laki';
        studentReligion.value = student['religion'] ?? 'Islam';
      }

      // Ambil data teacher
      final teacher = profile['teacher'];
      if (role == 'teacher') {
        teacherName.value = teacher['name'] ?? '';
        teacherImageUrl.value = teacher['image'] ?? '';
        teacherBorn.value = teacher['ttl'] ?? '';
        teacherAddress.value = teacher['address'] ?? '';
        teacherPhone.value = teacher['phone_number'] ?? '';
        teacherNip.value = teacher['nip'] ?? '';
        teacherAboutMe.value = teacher['about_me'] ?? '';
      }

      // Jika student image kosong, ambil dari teacher atau parent
      if (studentImageUrl.value.isEmpty) {
        if (teacher != null) {
          studentImageUrl.value = teacher['image'] ?? '';
        } else if (profile['parent'] != null) {
          studentImageUrl.value = profile['parent']['image'] ?? '';
        }
      }

      // Ambil data orang tua (profile utama)
      parentName.value = profile['name'] ?? '';
      parentAddress.value = profile['address'] ?? '';
      parentPhone.value = profile['phone_number'] ?? '';
    }
  }

  // === CEK ROLE ===
  bool get isStudent => userRole.value == 'student';
  bool get isTeacher => userRole.value == 'teacher';
  bool get isParent => userRole.value == 'parent';

  // === GETTER NAMA YANG AKTIF ===
  String get displayName {
    if (isTeacher) {
      return teacherName.value.isNotEmpty ? teacherName.value : 'Pengguna';
    } else {
      return studentName.value.isNotEmpty ? studentName.value : 'Pengguna';
    }
  }

  // === UPDATE PROFILE ===
  static Future<Map<String, dynamic>> updateStudentParentProfile({
    required String studentName,
    required String ttl,
    required String gender,
    required String religion,
    required String parentPhoneNumber,
    required String parentAddress,
  }) async {
    final body = {
      'name': studentName,
      'ttl': ttl,
      'gender': gender,
      'religion': religion,
      'phone_number': parentPhoneNumber,
      'address': parentAddress,
    };

    print('Data yang dikirim ke API student/profile:');
    body.forEach((key, value) {
      print('$key: $value');
    });

    return await ApiService.put('student/profile', body);
  }

  static Future<Map<String, dynamic>> updateTeacherProfile({
    required String teacherName,
    required String teacherTTL,
    required String teacherPhone,
    required String teacherAddress,
    required String teacherNip,
    required String teacherAboutMe,
  }) async {
    final body = {
      'name': teacherName,
      'ttl': teacherTTL,
      'phone_number': teacherPhone,
      'address': teacherAddress,
      'nip': teacherNip,
      'about_me': teacherAboutMe,
    };

    print('Data yang dikirim ke API teacher/profile:');
    body.forEach((key, value) {
      print('$key: $value');
    });

    return await ApiService.put('teacher/profile', body);
  }
}
