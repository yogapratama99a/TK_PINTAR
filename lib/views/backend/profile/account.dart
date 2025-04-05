import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/custom_input_field.dart';
import 'package:tk_pertiwi/views/widgets/dropdown.dart';
import 'package:tk_pertiwi/views/widgets/auth_button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController ttlController = TextEditingController();
  final TextEditingController noTeleponController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();

  String selectedGender = "Laki-laki";
  String selectedReligion = "Islam";

  void _saveProfile() {
    String nama = namaController.text;
    String ttl = ttlController.text;
    String noTelepon = noTeleponController.text;
    String alamat = alamatController.text;

    print("Nama: $nama");
    print("TTL: $ttl");
    print("Jenis Kelamin: $selectedGender");
    print("Agama: $selectedReligion");
    print("No Telepon: $noTelepon");
    print("Alamat: $alamat");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFE1F5FE).withOpacity(0.5),
              Color(0xFFB3E5FC).withOpacity(0.3),
            ],
            stops: const [0.1, 0.5, 1.0],
          ),
        ),
        child: Column(
          children: [
            // App Bar with Gradient Background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.9),
                    Colors.white.withOpacity(0.7),
                  ],
                ),
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  "Akun",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: AppFonts.PoppinsBold,
                  ),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Picture with Gradient Border
                    Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColors.green,
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Halo, ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black, // Changed from white to black
                              fontFamily: AppFonts.PoppinsRegular,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Ananta Ramadhan",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black, // Changed from white to black
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.PoppinsBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Account Information Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.9),
                            Colors.white.withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Informasi Akun",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.PoppinsBold,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Input Fields
                          CustomInputField(
                            label: "Nama",
                            hintText: "Masukkan Nama",
                            controller: namaController,
                          ),
                          const SizedBox(height: 12),

                          CustomInputField(
                            label: "Tempat Tanggal Lahir",
                            hintText: "Masukkan Tempat Tanggal Lahir",
                            controller: ttlController,
                          ),
                          const SizedBox(height: 12),

                          CustomDropdown(
                            label: "Jenis Kelamin",
                            items: const ["Laki-laki", "Perempuan"],
                            initialValue: "Laki-laki",
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value!;
                              });
                            },
                          ),
                          const SizedBox(height: 12),

                          CustomDropdown(
                            label: "Agama",
                            items: const [
                              "Islam",
                              "Kristen",
                              "Katolik",
                              "Hindu",
                              "Buddha",
                              "Konghucu"
                            ],
                            initialValue: "Islam",
                            onChanged: (value) {
                              setState(() {
                                selectedReligion = value!;
                              });
                            },
                          ),
                          const SizedBox(height: 12),

                          CustomInputField(
                            label: "No Telepon",
                            hintText: "Masukkan No Telepon",
                            keyboardType: TextInputType.phone,
                            controller: noTeleponController,
                          ),
                          const SizedBox(height: 12),

                          CustomInputField(
                            label: "Alamat",
                            hintText: "Masukkan Alamat Lengkap (Jalan, RT/RW, Kelurahan, Kecamatan, Kota, Provinsi)",
                            controller: alamatController,
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    AuthButton(
                      text: "Simpan",
                      width: double.infinity,
                      onPressed: _saveProfile,
                      backgroundColor: AppColors.green,
                      foregroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}