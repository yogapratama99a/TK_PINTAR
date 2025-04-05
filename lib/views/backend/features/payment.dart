import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';

class PaymentScreen extends StatelessWidget {
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
          "Pembayaran",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Informasi Siswa
            Card(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Sumbangan Pembinaan Pendidikan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
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
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nama: Santoso Pratama",style: TextStyle(fontFamily: AppFonts.PoppinsRegular, fontSize: 12),
                            ),
                              Text("NIS: 6666",style: TextStyle(fontFamily: AppFonts.PoppinsRegular, fontSize: 12),
                            ),
                              Text("Jenis Kelamin: Laki - Laki",style: TextStyle(fontFamily: AppFonts.PoppinsRegular, fontSize: 12),
                            ),
                              Text("Kelas: TK A1",style: TextStyle(fontFamily: AppFonts.PoppinsRegular, fontSize: 12),
                            ),
                              Text("Orang Tua: Imam Wahyu",style: TextStyle(fontFamily: AppFonts.PoppinsRegular, fontSize: 12),
                            ),
                              Text("Wali Kelas: Putri Aradea",style: TextStyle(fontFamily: AppFonts.PoppinsRegular, fontSize: 12),
                            ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Dropdown Tahun
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.green),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tahun 2024", style: TextStyle(fontWeight: FontWeight.bold)),
                  Icon(Icons.arrow_drop_down, color: AppColors.green),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Header Tabel (Tidak Scroll)
            Container(
              color: AppColors.green,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _tableHeader("No", 40),
                  _tableHeader("Bulan", 90),
                  _tableHeader("Tanggal", 90),
                  _tableHeader("Status", 90),
                ],
              ),
            ),

            // Isi Tabel (Scroll)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(12, (index) {
                    return _tableRow((index + 1).toString(), _bulan[index], "", "");
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Data Bulan
  final List<String> _bulan = [
    "Januari", "Februari", "Maret", "April", "Mei", "Juni",
    "Juli", "Agustus", "September", "Oktober", "November", "Desember"
  ];

  // Widget Header Tabel
  Widget _tableHeader(String title, double width) {
    return SizedBox(
      width: width,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  // Widget Isi Tabel
  Widget _tableRow(String no, String bulan, String tanggal, String status) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _tableCell(no, 40),
          _tableCell(bulan, 90),
          _tableCell(tanggal, 90),
          _tableCell(status, 90),
        ],
      ),
    );
  }

  // Widget Isi Sel Tabel
  Widget _tableCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
