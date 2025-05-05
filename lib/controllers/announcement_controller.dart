import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tk_pertiwi/views/widgets/custom_snackbar.dart';
import '../models/announcement_model.dart';
import '../services/api_service.dart';

class AnnouncementController extends GetxController {
  final RxInt selectedFilter = 0.obs; // 0: Semua, 1: Hari ini, 2: Minggu ini
  var announcements = <Announcement>[].obs;
  final RxBool isLoading = false.obs;
  RxInt selectedIndex = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAnnouncements();
  }

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> fetchAnnouncements() async {
    isLoading.value = true;

    try {
      final token = await ApiService.getToken();
      print('Token yang digunakan: $token');
      final result = await ApiService.getAnnouncement();

      if (result['success'] == true && result['data'] is List) {
        announcements.value = (result['data'] as List)
            .map((e) => Announcement.fromJson(e))
            .toList();
        print('✅ Data pengumuman berhasil dimuat: ${announcements.length}');
      } else {
        CustomSnackbar.error(
          result['message'] ?? 'Gagal memuat pengumuman dari server',
        );
      }
    } catch (e) {
      CustomSnackbar.error('Terjadi kesalahan saat mengambil pengumuman.');
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
        return announcements.where((a) {
          final date = DateTime(a.date.year, a.date.month, a.date.day);
          return date == today;
        }).toList();
      case 2: // Minggu ini
        return announcements.where((a) {
          final d = DateTime(a.date.year, a.date.month, a.date.day);
          return d.isAtSameMomentAs(weekStart) ||
              (d.isAfter(weekStart) && d.isBefore(weekEnd)) ||
              d.isAtSameMomentAs(weekEnd);
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

    if (announcementDate == today) {
      return "Hari ini, ${_getFormattedTime(date)}";
    } else if (announcementDate == yesterday) {
      return "Kemarin, ${_getFormattedTime(date)}";
    } else {
      final days = [
        'Senin',
        'Selasa',
        'Rabu',
        'Kamis',
        'Jum\'at',
        'Sabtu',
        'Minggu'
      ];
      final dateFormat = DateFormat('d MMMM yyyy');
      return "${days[date.weekday - 1]}, ${dateFormat.format(date)}";
    }
  }

  String _getFormattedTime(DateTime date) {
    return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  List<Announcement> getTodayAnnouncements() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    print("🔍 Hari ini: $today");

    return announcements.where((a) {
      final aDate = DateTime(a.date.year, a.date.month, a.date.day);
      print("📌 Cek tanggal pengumuman: $aDate");
      return aDate == today;
    }).toList();
  }
}
