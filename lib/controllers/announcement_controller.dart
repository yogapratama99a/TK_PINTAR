import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tk_pertiwi/views/widgets/custom_snackbar.dart';
import '../models/announcement_model.dart';
import '../services/api_service.dart';

class AnnouncementController extends GetxController {
  final RxInt selectedFilter = 0.obs; // 0: Semua, 1: Hari ini, 2: Minggu ini
  var announcements = <Announcement>[].obs;
  final RxBool isLoading = false.obs;
  RxInt selectedIndex = 1.obs;

  // Tambahkan ini untuk simpan role pengguna
  var userRole = ''.obs;

  final box = GetStorage();

  void loadUserRole() {
    final role = box.read('user_role');
    if (role != null) {
      userRole.value = role;
      print('👤 Role pengguna: $role');

      if (role == 'teacher') {
        fetchAllAnnouncements();
      } else {
        fetchAnnouncements();
      }
    } else {
      print('⚠️ Role pengguna tidak ditemukan di storage.');
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadUserRole(); // Role + fetch API langsung
  }

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  // Pengumuman per kelas siswa (atau bisa disesuaikan role kalau mau)
  Future<void> fetchAnnouncements() async {
    isLoading.value = true;

    try {
      final token = await ApiService.getToken();
      print('🔑 Token yang digunakan: $token');

      final result = await ApiService.getAnnouncement();
      print('📥 Response API: $result');

      if (result['success'] == true && result['data'] is List) {
        final List<dynamic> data = result['data'];
        announcements.assignAll(
          data.map((e) => Announcement.fromJson(e)).toList(),
        );
        print('✅ Data pengumuman berhasil dimuat: ${announcements.length}');
      } else {
        final message = result['message']?.toString() ??
            'Gagal memuat pengumuman dari server';
        print('⚠️ Response error: $message');
        CustomSnackbar.error(message);
      }
    } catch (e) {
      print('❌ Exception: $e');
      CustomSnackbar.error('Terjadi kesalahan saat mengambil pengumuman.');
    } finally {
      isLoading.value = false;
    }
  }

  // Pengumuman SEMUA (tanpa filter class)
  Future<void> fetchAllAnnouncements() async {
    isLoading.value = true;

    try {
      final token = await ApiService.getToken();
      print('🔑 Token yang digunakan (All): $token');

      final result = await ApiService.getAllAnnouncement();
      print('📥 Response API (All): $result');

      if (result['success'] == true && result['data'] is List) {
        final List<dynamic> data = result['data'];
        announcements.assignAll(
          data.map((e) => Announcement.fromJson(e)).toList(),
        );
        print(
            '✅ Data semua pengumuman berhasil dimuat: ${announcements.length}');
      } else {
        final message = result['message']?.toString() ??
            'Gagal memuat semua pengumuman dari server';
        print('⚠️ Response error (All): $message');
        CustomSnackbar.error(message);
      }
    } catch (e) {
      print('❌ Exception (All): $e');
      CustomSnackbar.error(
          'Terjadi kesalahan saat mengambil semua pengumuman.');
    } finally {
      isLoading.value = false;
    }
  }

  List<Announcement> get filteredAnnouncements {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekStart = today.subtract(Duration(days: today.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 6));

    switch (selectedFilter.value) {
      case 1: // Hari ini
        return announcements.where((a) => isSameDay(a.date, today)).toList();
      case 2: // Minggu ini
        return announcements.where((a) {
          final announcementDate =
              DateTime(a.date.year, a.date.month, a.date.day);
          return (announcementDate.isAtSameMomentAs(weekStart) ||
              (announcementDate.isAfter(weekStart) &&
                  announcementDate.isBefore(weekEnd)) ||
              announcementDate.isAtSameMomentAs(weekEnd));
        }).toList();
      default:
        return announcements.toList();
    }
  }

  void changeFilter(int index) {
    selectedFilter.value = index;
  }

  String formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final announcementDate = DateTime(date.year, date.month, date.day);

    if (isSameDay(announcementDate, today)) {
      return "Hari ini, ${_getFormattedTime(date)}";
    } else if (isSameDay(announcementDate, yesterday)) {
      return "Kemarin, ${_getFormattedTime(date)}";
    } else {
      return DateFormat('dd MMM yyyy, HH:mm').format(date);
    }
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String _getFormattedTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  List<Announcement> getTodayAnnouncements() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    print("🔍 Hari ini: $today");

    return announcements.where((a) {
      final announcementDate = DateTime(a.date.year, a.date.month, a.date.day);
      print("📌 Cek tanggal pengumuman: $announcementDate");
      return isSameDay(announcementDate, today);
    }).toList();
  }
}
