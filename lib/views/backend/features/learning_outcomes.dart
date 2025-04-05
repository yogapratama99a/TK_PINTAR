import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';

class LearningOutcomesScreen extends StatelessWidget {
  const LearningOutcomesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Hasil Belajar",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: AppFonts.PoppinsBold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Banner
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Gambar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/img/logo.png', // Ganti dengan gambar yang sesuai
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Teks Motivasi
                    const Expanded(
                      child: Text(
                        "Ayo terus asah minat, bakat serta keterampilanmu. Jangan mudah putus asa untuk mencapai semua cita-citamu.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: AppFonts.PoppinsBold,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Informasi Siswa
              Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Placeholder untuk foto profil
                      Container(
                        
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.image, size: 40, color: Colors.white),
                      ),
                      const SizedBox(width: 28),
                      // Detail Siswa
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama         : Santoso Pratama",
                              style: TextStyle(fontFamily: AppFonts.PoppinsRegular, fontSize: 12),
                            ),
                            Text(
                              "NIS          : 6666",
                              style: TextStyle(fontFamily: AppFonts.PoppinsRegular, fontSize: 12),
                            ),
                            Text(
                              "Jenis Kelamin: Laki - Laki",
                              style: TextStyle(fontFamily: AppFonts.PoppinsRegular, fontSize: 12),
                            ),
                            Text(
                              "Kelas   : TK A1",
                              style: TextStyle(fontFamily: AppFonts.PoppinsRegular, fontSize: 12),
                            ),
                            Text(
                              "Tahun Ajaran : 2024/2025",
                              style: TextStyle(fontFamily: AppFonts.PoppinsRegular, fontSize: 12),
                            ),
                            Text(
                              "Orang Tua   : Imam Wahyu",
                              style: TextStyle(fontFamily: AppFonts.PoppinsRegular, fontSize: 12),
                            ),
                            Text(
                              "Wali Kelas   : Imam Wahyu S.Pd",
                              style: TextStyle(fontFamily: AppFonts.PoppinsRegular, fontSize: 12),
                            ),
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Informasi Hasil Belajar
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Informasi Hasil Belajar Siswa",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),

              // List Hasil Belajar dengan nilai dan informasi tambahan
              _buildCategoryTile("Menggambar", 100, "Pertahankan kreativitasnya"),
              _buildCategoryTile("Membaca", 85, "Tingkatkan pemahaman bacaan"),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan kategori dengan nilai dan informasi tambahan
  Widget _buildCategoryTile(String title, int value, String info) {
    return Card(
      color: AppColors.green,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Nama kategori
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Nilai
                Text(
                  "Nilai: $value",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                // Informasi tambahan
                Text(
                  info,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
