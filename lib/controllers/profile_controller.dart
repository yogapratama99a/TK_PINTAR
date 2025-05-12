import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ProfileController extends GetxController {
  var displayName = ''.obs;
  var displayImageUrl = ''.obs;

  RxInt selectedIndex = 2.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserFromProfile();
  }

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> loadUserFromProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileString = prefs.getString('profile');

    if (profileString != null) {
      final profile = jsonDecode(profileString);

      final student = profile['student'];
      final teacher = profile['teacher'];

      if (student != null) {
        displayName.value = student['name'] ?? 'Nama tidak ditemukan';
        displayImageUrl.value = student['image'] ?? '';
      } else if (teacher != null) {
        displayName.value = teacher['name'] ?? 'Nama tidak ditemukan';
        displayImageUrl.value = teacher['image'] ?? '';
      } else {
        // fallback: pakai data parent (root)
        displayName.value = profile['name'] ?? 'Nama tidak ditemukan';
        displayImageUrl.value = profile['image'] ?? '';
      }

      print('Nama tampil: ${displayName.value}');
      print('Image URL: ${displayImageUrl.value}');
    } else {
      print('Data profil tidak ditemukan di SharedPreferences');
    }
  }

  Future<void> updateUserImage(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    final profileString = prefs.getString('profile');

    if (profileString != null) {
      final profile = jsonDecode(profileString);

      if (profile['student'] != null) {
        profile['student']['image'] = imageUrl;
      } else if (profile['teacher'] != null) {
        profile['teacher']['image'] = imageUrl;
      } else {
        profile['image'] = imageUrl;
      }

      await prefs.setString('profile', jsonEncode(profile));
      displayImageUrl.value = imageUrl;
    }
  }

  Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile');

    displayName.value = '';
    displayImageUrl.value = '';
  }
}
