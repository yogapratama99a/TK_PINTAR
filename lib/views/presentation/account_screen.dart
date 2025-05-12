import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/controllers/account_controller.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/custom_input_field.dart';
import 'package:tk_pertiwi/views/widgets/dropdown.dart';
import 'package:tk_pertiwi/views/widgets/auth_button.dart';
import 'package:tk_pertiwi/views/widgets/input_field_register.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final AccountController controller = Get.put(AccountController());

  late final TextEditingController namaController;
  late final TextEditingController ttlController;
  late final TextEditingController noTeleponController;
  late final TextEditingController alamatController;
  late final TextEditingController nipController;
  late final TextEditingController aboutMeController;

  @override
  void initState() {
    super.initState();

    namaController = TextEditingController();
    ttlController = TextEditingController();
    noTeleponController = TextEditingController();
    alamatController = TextEditingController();
    nipController = TextEditingController();
    aboutMeController = TextEditingController();

    controller.loadProfile().then((_) {
      if (controller.userRole.value == 'teacher') {
        namaController.text = controller.teacherName.value;
        ttlController.text = controller.teacherBorn.value;
        noTeleponController.text = controller.teacherPhone.value;
        alamatController.text = controller.teacherAddress.value;
        nipController.text = controller.teacherNip.value;
        aboutMeController.text = controller.teacherAboutMe.value;
      } else {
        namaController.text = controller.studentName.value;
        ttlController.text = controller.studentBorn.value;
        noTeleponController.text = controller.parentPhone.value;
        alamatController.text = controller.parentAddress.value;
      }
    }).catchError((error) {
      Get.snackbar("Error", "Gagal memuat data profil: $error");
    });

    _setupControllerListeners();
  }

  void _setupControllerListeners() {
    if (controller.userRole.value == 'teacher') {
      ever(controller.studentName, (value) {
        if (namaController.text != value) {
          namaController.text = value;
        }
      });
      ever(controller.studentBorn, (value) {
        if (ttlController.text != value) {
          ttlController.text = value;
        }
      });
      ever(controller.parentPhone, (value) {
        if (noTeleponController.text != value) {
          noTeleponController.text = value;
        }
      });
      ever(controller.parentAddress, (value) {
        if (alamatController.text != value) {
          alamatController.text = value;
        }
      });
    } else {
      ever(controller.teacherName, (value) {
        if (namaController.text != value) {
          namaController.text = value;
        }
      });
      ever(controller.teacherBorn, (value) {
        if (ttlController.text != value) {
          ttlController.text = value;
        }
      });
      ever(controller.teacherPhone, (value) {
        if (noTeleponController.text != value) {
          noTeleponController.text = value;
        }
      });
      ever(controller.teacherAddress, (value) {
        if (alamatController.text != value) {
          alamatController.text = value;
        }
      });
      ever(controller.teacherNip, (value) {
        if (nipController.text != value) {
          nipController.text = value;
        }
      });
      ever(controller.teacherAboutMe, (value) {
        if (aboutMeController.text != value) {
          aboutMeController.text = value;
        }
      });
    }
  }

  @override
  void dispose() {
    namaController.dispose();
    ttlController.dispose();
    noTeleponController.dispose();
    alamatController.dispose();
    nipController.dispose();
    aboutMeController.dispose();

    super.dispose();
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
              const Color(0xFFE1F5FE).withOpacity(0.5),
              const Color(0xFFB3E5FC).withOpacity(0.3),
            ],
            stops: const [0.1, 0.5, 1.0],
          ),
        ),
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                child: Obx(
                  () => Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProfileHeader(),
                        const SizedBox(height: 32),
                        if (controller.userRole.value == 'teacher') ...[
                          _buildTeacherProfileForm(),
                        ] else ...[
                          _buildProfileForm(),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
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
    );
  }

  Widget _buildProfileHeader() {
    return Center(
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
            child: Obx(() {
              final imageUrl = controller.studentImageUrl.value;
              final hasImage = imageUrl.isNotEmpty;

              return CircleAvatar(
                radius: 50,
                backgroundColor:
                    hasImage ? Colors.transparent : AppColors.green,
                child: hasImage
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error_outline,
                          size: 40,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
              );
            }),
          ),
          const SizedBox(height: 16),
          const Text(
            "Halo, ",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontFamily: AppFonts.PoppinsRegular,
            ),
          ),
          const SizedBox(height: 8),
          Obx(() => Text(
                controller.displayName,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.PoppinsBold,
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildTeacherProfileForm() {
    return Container(
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
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Informasi Guru",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.PoppinsBold,
            ),
          ),
          const SizedBox(height: 16),
          BorderLabelInputField(
            borderLabel: "Nama",
            hintText: "Masukkan Nama",
            controller: namaController,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 12),
          BorderLabelInputField(
            borderLabel: "NIP",
            hintText: "Masukkan NIP",
            controller: nipController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          BorderLabelInputField(
            borderLabel: "Tempat Tanggal Lahir",
            hintText: "Masukkan Tempat Tanggal Lahir",
            controller: ttlController,
          ),
          const SizedBox(height: 12),
          BorderLabelInputField(
            borderLabel: "Nomor Telepon",
            hintText: "Masukkan Nomor Telepon",
            controller: noTeleponController,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          BorderLabelInputField(
            borderLabel: "Alamat",
            hintText: "Masukkan Alamat",
            controller: alamatController,
          ),
          const SizedBox(height: 12),
          BorderLabelInputField(
            borderLabel: "Tentang Saya",
            hintText: "Masukkan Tentang Saya",
            controller: aboutMeController,
            maxLines: 4,
          ),
          const SizedBox(height: 32),
          AuthButton(
            text: "Simpan Perubahan",
            onPressed: () async {
              if (namaController.text.trim().isEmpty ||
                  nipController.text.trim().isEmpty ||
                  ttlController.text.trim().isEmpty ||
                  noTeleponController.text.trim().isEmpty ||
                  alamatController.text.trim().isEmpty ||
                  aboutMeController.text.trim().isEmpty) {
                Get.snackbar(
                  "Peringatan",
                  "Mohon lengkapi semua data!",
                  backgroundColor: Colors.orange,
                  colorText: Colors.white,
                );
                return;
              }

              final response = await AccountController.updateTeacherProfile(
                teacherName: namaController.text.trim(),
                teacherNip: nipController.text.trim(),
                teacherTTL: ttlController.text.trim(),
                teacherPhone: noTeleponController.text.trim(),
                teacherAddress: alamatController.text.trim(),
                teacherAboutMe: aboutMeController.text.trim(),
              );

              if (response['success'] == true) {
                controller.teacherName.value = namaController.text.trim();
                Get.snackbar(
                  "Sukses",
                  "Profil guru berhasil diperbarui!",
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              } else {
                Get.snackbar(
                  "Gagal",
                  "Gagal menyimpan data: ${response['message'] ?? ''}",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileForm() {
    return Container(
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
          ),
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
          BorderLabelInputField(
            borderLabel: "Nama",
            hintText: "Masukkan Nama",
            controller: namaController,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 12),
          BorderLabelInputField(
            borderLabel: "Tempat Tanggal Lahir",
            hintText: "Masukkan Tempat Tanggal Lahir",
            controller: ttlController,
          ),
          const SizedBox(height: 12),
          CustomDropdown(
            label: "Jenis Kelamin",
            items: const ["Laki-laki", "Perempuan"],
            initialValue: controller.studentGender.value.isNotEmpty
                ? controller.studentGender.value
                : "Laki-laki", // fallback
            onChanged: (value) {
              setState(() {
                controller.studentGender.value =
                    value ?? "Laki-laki"; // Update state value here
              });
            },
          ),
          const SizedBox(height: 12),
          CustomDropdown(
            label: "Agama",
            items: const ["Islam", "Kristen", "Hindu", "Buddha", "Konghucu"],
            initialValue: controller.studentReligion.value.isNotEmpty
                ? controller.studentReligion.value
                : "Islam",
            onChanged: (value) {
              setState(() {
                controller.studentReligion.value = value ?? "Islam";
              });
            },
          ),
          const SizedBox(height: 12),
          BorderLabelInputField(
            borderLabel: "Nomor Telepon",
            hintText: "Masukkan Nomor Telepon",
            controller: noTeleponController,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          BorderLabelInputField(
            borderLabel: "Alamat",
            hintText: "Masukkan Alamat",
            controller: alamatController,
          ),
          const SizedBox(height: 32),
          AuthButton(
            text: "Simpan Perubahan",
            onPressed: () async {
              if (namaController.text.trim().isEmpty ||
                  ttlController.text.trim().isEmpty ||
                  noTeleponController.text.trim().isEmpty ||
                  alamatController.text.trim().isEmpty) {
                Get.snackbar(
                  "Peringatan",
                  "Mohon lengkapi semua data!",
                  backgroundColor: Colors.orange,
                  colorText: Colors.white,
                );
                return;
              }

              final response =
                  await AccountController.updateStudentParentProfile(
                studentName: namaController.text.trim(),
                ttl: ttlController.text.trim(),
                gender: controller.studentGender.value,
                religion: controller.studentReligion.value,
                parentPhoneNumber: noTeleponController.text.trim(),
                parentAddress: alamatController.text.trim(),
              );

              if (response['success'] == true) {
                // Update state controller agar nama baru muncul di atas
                controller.studentName.value = namaController.text.trim();
                controller.studentBorn.value = ttlController.text.trim();
                controller.parentPhone.value = noTeleponController.text.trim();
                controller.parentAddress.value = alamatController.text.trim();

                Get.snackbar(
                  "Berhasil",
                  "Profil berhasil diperbarui",
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              } else {
                Get.snackbar(
                  "Gagal",
                  "Gagal memperbarui profil: ${response['message'] ?? 'Terjadi kesalahan'}",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
