import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/controllers/schedule_controller.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';

class ScheduleScreen extends StatelessWidget {
  final ScheduleController controller = Get.put(ScheduleController());

  final List<String> filterOptions = [
    "Semua Hari",
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat"
  ];

   ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          "Jadwal Sekolah",
          style: TextStyle(
            fontFamily: AppFonts.PoppinsBold,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.scheduleData;
        final selectedFilter = controller.selectedFilter.value;

        return Column(
          children: [
            // Filter dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  const Icon(Icons.filter_alt, color: AppColors.green),
                  const SizedBox(width: 8),
                  const Text(
                    "Filter Hari:",
                    style: TextStyle(
                      fontFamily: AppFonts.PoppinsMedium,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButton<String>( 
                        isExpanded: true,
                        value: selectedFilter,
                        icon: const Icon(Icons.arrow_drop_down, color: AppColors.green),
                        dropdownColor: Colors.white,
                        underline: Container(),
                        style: const TextStyle(
                          fontFamily: AppFonts.PoppinsRegular,
                          color: Colors.black87,
                        ),
                        items: filterOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.selectedFilter.value = newValue;
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

              // Jadwal
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: selectedFilter == "Semua Hari"
                      ? data.entries.map((entry) {
                          return _buildDaySchedule(entry.key, entry.value);
                        }).toList()
                      : [
                          if (data[selectedFilter]?.isNotEmpty ?? false)
                            _buildDaySchedule(
                                selectedFilter, data[selectedFilter]!)
                          else
                            Center(child: Text("Tidak ada jadwal untuk hari $selectedFilter")),
                        ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildDaySchedule(String day, List<Map<String, dynamic>> activities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          day,
          style: const TextStyle(
            fontFamily: AppFonts.PoppinsBold,
            fontSize: 18,
            color: Color(0xFF0D47A1),
          ),
        ),
        const SizedBox(height: 10),
        ...activities.map((activity) {
          return Card(
            color: AppColors.lightBackground,
            margin: const EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Jam dengan lebar tetap
                  Container(
                    width: 100, // Tentukan lebar tetap
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      activity["Jam"] ?? '',
                      style: const TextStyle(
                        fontFamily: AppFonts.PoppinsMedium,
                        color: Color(0xFF0D47A1),
                        overflow: TextOverflow.ellipsis, // Menghindari overflow
                      ),
                      textAlign: TextAlign.center, // Mengatur teks agar terpusat
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Kegiatan dan Guru
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity["Kegiatan"] ?? '',
                          style: const TextStyle(
                            fontFamily: AppFonts.PoppinsSemiBold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          activity["Guru"] == '-' ? 'Tidak ada guru' : (activity["Guru"] ?? ''),
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
        }),
        const SizedBox(height: 20),
      ],
    );
  }
}
