import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:tk_pertiwi/views/widgets/announcement_card.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  _AnnouncementScreenState createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  int _selectedFilter = 0; // 0: Semua, 1: Hari ini, 2: Minggu ini
  final List<Announcement> _announcements = [
    Announcement(
      name: "Imam Wahyu S.Pd",
      position: "Guru Agama",
      date: DateTime.now(),
      message: "Pengumuman hari ini: Jangan lupa bawa buku gambar besok.",
    ),
    Announcement(
      name: "Budi Santoso S.Pd",
      position: "Wali Kelas",
      date: DateTime.now().subtract(const Duration(days: 1)),
      message: "Pengumuman kemarin: Pembayaran SPP bulan ini sudah dibuka.",
    ),
    Announcement(
      name: "Anita Rahayu S.Pd",
      position: "Guru Olahraga",
      date: DateTime.now().subtract(const Duration(days: 3)),
      message: "Pengumuman 3 hari lalu: Persiapan untuk lomba senam minggu depan.",
    ),
    Announcement(
      name: "Dewi Kurnia S.Pd",
      position: "Kepala Sekolah",
      date: DateTime.now().subtract(const Duration(days: 6)),
      message: "Pengumuman minggu ini: Rapat orang tua murid akan dilaksanakan Sabtu depan.",
    ),
    Announcement(
      name: "Rudi Hermawan S.Pd",
      position: "Guru Matematika",
      date: DateTime.now().subtract(const Duration(days: 10)),
      message: "Pengumuman lama: Hasil ujian sudah bisa diambil di ruang guru.",
    ),
  ];

  List<Announcement> get _filteredAnnouncements {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekStart = today.subtract(Duration(days: today.weekday - 1));

    switch (_selectedFilter) {
      case 1: // Hari ini
        return _announcements.where((a) {
          final announcementDate = DateTime(a.date.year, a.date.month, a.date.day);
          return announcementDate == today;
        }).toList();
      case 2: // Minggu ini
        return _announcements.where((a) {
          final announcementDate = DateTime(a.date.year, a.date.month, a.date.day);
          return announcementDate.isAfter(weekStart.subtract(const Duration(days: 1))) && 
                 announcementDate.isBefore(today.add(const Duration(days: 1)));
        }).toList();
      default: // Semua
        return _announcements;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Pengumuman",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: AppFonts.PoppinsBold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Filter Pengumuman
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _filterButton("Semua", _selectedFilter == 0),
                _filterButton("Hari ini", _selectedFilter == 1),
                _filterButton("Minggu ini", _selectedFilter == 2),
              ],
            ),
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Color(0xFFB3DAF0).withOpacity(0.8),
                    Color(0xFFE1F5FE).withOpacity(0.8),
                  ],
                  stops: [0.1, 0.5, 1.0],
                ),
              ),
              child: _filteredAnnouncements.isEmpty
                  ? const Center(
                      child: Text(
                        "Tidak ada pengumuman",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredAnnouncements.length,
                      itemBuilder: (context, index) {
                        final announcement = _filteredAnnouncements[index];
                        return AnnouncementCard(
                          name: announcement.name,
                          position: announcement.position,
                          date: _formatDate(announcement.date),
                          message: announcement.message,
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 1,
        onItemTapped: (index) {
          // Handle navigation here
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
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
        'Minggu',
      ];
      return "${days[date.weekday - 1]}, ${date.day} ${_getMonthName(date.month)} ${date.year}";
    }
  }

  String _getFormattedTime(DateTime date) {
    return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  String _getMonthName(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return months[month - 1];
  }

  Widget _filterButton(String title, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = title == "Semua" ? 0 : title == "Hari ini" ? 1 : 2;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.green : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.green),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.green,
            fontFamily: AppFonts.PoppinsRegular,
          ),
        ),
      ),
    );
  }
}

class Announcement {
  final String name;
  final String position;
  final DateTime date;
  final String message;

  Announcement({
    required this.name,
    required this.position,
    required this.date,
    required this.message,
  });
}