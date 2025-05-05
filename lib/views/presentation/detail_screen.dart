import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:get/get.dart';
import '../../controllers/teacher_detail_controller.dart';

class TeacherDetailsBottomSheet extends StatefulWidget {
  final int id;
  final String name;
  final String subject;

  const TeacherDetailsBottomSheet({
    super.key,
    required this.id,
    required this.name,
    required this.subject,
  });

  @override
  State<TeacherDetailsBottomSheet> createState() => _TeacherDetailsBottomSheetState();
}

class _TeacherDetailsBottomSheetState extends State<TeacherDetailsBottomSheet> {
  final TeacherDetailController controller = Get.put(TeacherDetailController());

  @override
  void initState() {
    super.initState();
    controller.fetchTeacherDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }

      final data = controller.detail;

      // Menggunakan ikon default jika URL foto kosong
      final isPhotoAvailable = data['url'] != null && data['url'].isNotEmpty;

      return Container(
        height: screenHeight * 0.75,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Detail Guru',
                  style: TextStyle(
                    fontFamily: AppFonts.PoppinsBold,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.green,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // PROFILE & INFO
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // FOTO - Menggunakan ikon person jika foto tidak ada
                  Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.green.withOpacity(0.1),
                          border: Border.all(
                            color: AppColors.green.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: isPhotoAvailable
                            ? ClipOval(
                                child: Image.network(
                                  data['url'],
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(
                                Icons.person,
                                size: 60,
                                color: AppColors.green,
                              ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        data['name'] ?? '-',
                        style: const TextStyle(
                          fontFamily: AppFonts.PoppinsBold,
                          fontSize: 16,
                          color: AppColors.green,
                        ),
                      ),
                      Text(
                        widget.subject,
                        style: TextStyle(
                          fontFamily: AppFonts.PoppinsRegular,
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),

                  Container(
                    width: 1,
                    height: 140,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(width: 20),

                  // INFORMASI KONTAK
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildContactRow(Icons.person, 'NIP', data['nip'] ?? '-'),
                        const SizedBox(height: 12),
                        _buildContactRow(Icons.cake, 'TTL', data['ttl'] ?? '-'),
                        const SizedBox(height: 12),
                        _buildContactRow(Icons.phone, 'Telepon', data['phone_number'] ?? '-'),
                        const SizedBox(height: 12),
                        _buildContactRow(Icons.location_on, 'Alamat', data['address'] ?? '-'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ABOUT ME
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tentang Guru',
                        style: TextStyle(
                          fontFamily: AppFonts.PoppinsBold,
                          fontSize: 16,
                          color: AppColors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data['about_me'] ?? 'Tidak ada informasi.',
                        style: TextStyle(
                          fontFamily: AppFonts.PoppinsRegular,
                          fontSize: 14,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.green, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: AppFonts.PoppinsMedium,
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: AppFonts.PoppinsRegular,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
