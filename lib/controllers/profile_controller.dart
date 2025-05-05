import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var studentName = ''.obs;
  var studentImageUrl = ''.obs;
  RxInt selectedIndex = 2.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserFromProfile();
  }

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  /// Load data pengguna dari SharedPreferences (bisa student, teacher, atau parent)
  Future<void> loadUserFromProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileString = prefs.getString('profile'); // Gunakan key yang benar

    if (profileString != null) {
      final profile = jsonDecode(profileString);

      // Ambil student jika ada, jika tidak coba teacher atau parent
      final student = profile['student'];
      final teacher = profile['teacher'];
      final parent = profile['parent'];

      if (student != null) {
        studentName.value = student['name'] ?? 'Nama tidak ditemukan';
        studentImageUrl.value = student['image'] ?? '';
      } else if (teacher != null) {
        studentName.value = teacher['name'] ?? 'Nama tidak ditemukan';
        studentImageUrl.value = teacher['image'] ?? '';
      } else if (parent != null) {
        studentName.value = parent['name'] ?? 'Nama tidak ditemukan';
        studentImageUrl.value = parent['image'] ?? '';
      } else {
        print('Tidak ada data pengguna yang dikenali di dalam profil');
      }

      print('Image URL: ${studentImageUrl.value}');
    } else {
      print('Data profil tidak ditemukan di SharedPreferences');
    }
  }

  /// Simpan data pengguna sebagian (tidak menimpa seluruh `profile`)
  Future<void> updateUserImage(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    final profileString = prefs.getString('profile');

    if (profileString != null) {
      final profile = jsonDecode(profileString);

      // Perbarui gambar (asumsi data student)
      if (profile['student'] != null) {
        profile['student']['image'] = imageUrl;
      }

      await prefs.setString('profile', jsonEncode(profile));
      studentImageUrl.value = imageUrl;
    }
  }

  Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile');

    studentName.value = '';
    studentImageUrl.value = '';
  }
}
