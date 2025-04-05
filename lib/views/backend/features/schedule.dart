import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final Map<String, List<Map<String, String>>> tkSchedule = {
    "Senin": [
      {
        "Jam": "08.00 - 08.30",
        "Kegiatan": "Pembukaan & Doa Pagi",
        "Guru": "Bu Ana"
      },
      {
        "Jam": "08.30 - 09.15",
        "Kegiatan": "Bernyanyi & Gerak Lagu",
        "Guru": "Bu Rina"
      },
      {
        "Jam": "09.15 - 10.00",
        "Kegiatan": "Mewarnai Gambar",
        "Guru": "Bu Dita"
      },
      {"Jam": "10.00 - 10.30", "Kegiatan": "Istirahat & Snack", "Guru": "-"},
      {
        "Jam": "10.30 - 11.15",
        "Kegiatan": "Bercerita (Storytelling)",
        "Guru": "Bu Maya"
      },
    ],
    "Selasa": [
      {
        "Jam": "08.00 - 08.30",
        "Kegiatan": "Pembukaan & Ice Breaking",
        "Guru": "Bu Rina"
      },
      {
        "Jam": "08.30 - 09.15",
        "Kegiatan": "Menggunting & Menempel",
        "Guru": "Bu Dita"
      },
      {"Jam": "09.15 - 10.00", "Kegiatan": "Bermain Puzzle", "Guru": "Bu Ana"},
      {"Jam": "10.00 - 10.30", "Kegiatan": "Istirahat", "Guru": "-"},
      {
        "Jam": "10.30 - 11.00",
        "Kegiatan": "Bermain Pasir",
        "Guru": "Semua Guru"
      },
    ],
    "Rabu": [
      {
        "Jam": "08.00 - 08.30",
        "Kegiatan": "Pembukaan & Senam Kecil",
        "Guru": "Bu Maya"
      },
      {
        "Jam": "08.30 - 09.15",
        "Kegiatan": "Mengenal Angka & Berhitung",
        "Guru": "Bu Ana"
      },
      {"Jam": "09.15 - 10.00", "Kegiatan": "Bermain Balok", "Guru": "Bu Dita"},
      {"Jam": "10.00 - 10.30", "Kegiatan": "Istirahat", "Guru": "-"},
      {
        "Jam": "10.30 - 11.15",
        "Kegiatan": "Membuat Prakarya",
        "Guru": "Bu Rina"
      },
    ],
    "Kamis": [
      {
        "Jam": "08.00 - 08.30",
        "Kegiatan": "Pembukaan & Bernyanyi",
        "Guru": "Bu Dita"
      },
      {
        "Jam": "08.30 - 09.15",
        "Kegiatan": "Mengenal Huruf & Membaca",
        "Guru": "Bu Maya"
      },
      {
        "Jam": "09.15 - 10.00",
        "Kegiatan": "Bermain Peran (Role Play)",
        "Guru": "Bu Rina"
      },
      {"Jam": "10.00 - 10.30", "Kegiatan": "Istirahat", "Guru": "-"},
      {
        "Jam": "10.30 - 11.00",
        "Kegiatan": "Menonton Video Edukasi",
        "Guru": "Bu Ana"
      },
    ],
    "Jumat": [
      {
        "Jam": "08.00 - 08.30",
        "Kegiatan": "Pembukaan & Doa Pagi",
        "Guru": "Bu Maya"
      },
      {
        "Jam": "08.30 - 09.30",
        "Kegiatan": "Field Trip / Kegiatan Outdoor",
        "Guru": "Semua Guru"
      },
      {"Jam": "09.30 - 10.00", "Kegiatan": "Istirahat", "Guru": "-"},
      {
        "Jam": "10.00 - 10.45",
        "Kegiatan": "Menggambar Bebas",
        "Guru": "Bu Dita"
      },
    ],
  };

  String _selectedFilter = "Semua Hari";
  final List<String> _filterOptions = [
    "Semua Hari",
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat"
  ];

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Jadwal Sekolah",
          style: TextStyle(
            fontFamily: AppFonts.PoppinsBold,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1E88E5),
                Color(0xFF0D47A1),
              ],
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filter Section with clear background
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.white,
            child: Row(
              children: [
                Icon(Icons.filter_alt, color: AppColors.green),
                SizedBox(width: 8),
                Text(
                  "Filter Hari:",
                  style: TextStyle(
                    fontFamily: AppFonts.PoppinsMedium,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedFilter,
                      icon: Icon(Icons.arrow_drop_down, color: AppColors.green),
                      dropdownColor: Colors.white,
                      underline: Container(),
                      style: TextStyle(
                        fontFamily: AppFonts.PoppinsRegular,
                        color: Colors.black87,
                      ),
                      items: _filterOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedFilter = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Schedule List
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  if (_selectedFilter == "Semua Hari")
                    ..._buildAllDaysSchedule()
                  else
                    ..._buildSingleDaySchedule(_selectedFilter),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAllDaysSchedule() {
    return tkSchedule.entries.map((entry) {
      String day = entry.key;
      List<Map<String, String>> activities = entry.value;
      return _buildDaySchedule(day, activities);
    }).toList();
  }

  List<Widget> _buildSingleDaySchedule(String day) {
    return [_buildDaySchedule(day, tkSchedule[day]!)];
  }

  Widget _buildDaySchedule(String day, List<Map<String, String>> activities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          day,
          style: TextStyle(
            fontFamily: AppFonts.PoppinsBold,
            fontSize: 18,
            color: Color(0xFF0D47A1),
          ),
        ),
        SizedBox(height: 10),
        ...activities.map((activity) {
          return Card(
            color: AppColors.lightBackground,
            margin: EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  // Waktu
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      activity["Jam"]!,
                      style: TextStyle(
                        fontFamily: AppFonts.PoppinsMedium,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  // Kegiatan & Guru
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity["Kegiatan"]!,
                          style: TextStyle(
                            fontFamily: AppFonts.PoppinsSemiBold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "${activity["Guru"]!}",
                          style: TextStyle(
                            fontFamily: AppFonts.PoppinsRegular,
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        SizedBox(height: 20),
      ],
    );
  }
}
