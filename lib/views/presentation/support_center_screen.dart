import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import '../../controllers/support_controller.dart';

class SupportCenterScreen extends StatelessWidget {
  final SupportCenterController supportController = Get.put(SupportCenterController());

   SupportCenterScreen({super.key}); // Use Get.find() to retrieve the existing controller

  void _showSupportInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Informasi Support',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.PoppinsBold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoItem(Icons.schedule_rounded, 'Jam Operasional',
                'Senin-Jumat: 08:00 - 16:00 WIB\nSabtu: 08:00 - 12:00 WIB'),
            const SizedBox(height: 16),
            _buildInfoItem(Icons.email_rounded, 'Email Support',
                'support@tkpertiwi.id\nadmin@tkpertiwi.id'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('TUTUP', style: TextStyle(color: AppColors.green)),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24, color: AppColors.green),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: AppFonts.PoppinsSemiBold,
                  )),
              const SizedBox(height: 4),
              Text(text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: AppFonts.PoppinsRegular,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  void _openWhatsApp(String number) async {
    final url = Uri.parse("https://wa.me/$number");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      Get.snackbar("Gagal", "Tidak dapat membuka WhatsApp");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Pusat Bantuan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontFamily: AppFonts.PoppinsBold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded, color: Colors.black54),
            onPressed: () => _showSupportInfo(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderBox(),
            const SizedBox(height: 32),
            _buildIllustration(),
            const SizedBox(height: 32),
            _buildDescription(),
            const SizedBox(height: 32),
            Obx(() {
              if (supportController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (supportController.supportList.isEmpty) {
                return const Center(child: Text('Belum ada data support.'));
              }

              final support = supportController.supportList.first;

              return _buildContactBox(support.name, support.waNumber);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.help_outline_rounded, size: 28, color: AppColors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Butuh bantuan lebih lanjut?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
                fontFamily: AppFonts.PoppinsSemiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIllustration() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.green.withOpacity(0.05),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          'assets/img/sc.png',
          width: 180,
          height: 180,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kami siap membantu Anda',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.grey[900],
            fontFamily: AppFonts.PoppinsBold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Hubungi tim support kami melalui WhatsApp untuk mendapatkan bantuan seputar kendala teknis atau pertanyaan lainnya.',
          style: TextStyle(
            fontSize: 15,
            height: 1.5,
            color: Colors.grey[600],
            fontFamily: AppFonts.PoppinsRegular,
          ),
        ),
      ],
    );
  }

  Widget _buildContactBox(String name, String waNumber) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.phone_rounded, color: AppColors.green),
            ),
            title: Text(
              name,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
                fontFamily: AppFonts.PoppinsSemiBold,
              ),
            ),
            subtitle: Text(
              waNumber,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontFamily: AppFonts.PoppinsBold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.chat_rounded, size: 20, color: Colors.white),
              label: const Text(
                'Hubungi via WhatsApp',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.PoppinsSemiBold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: () => _openWhatsApp(waNumber),
            ),
          ),
        ],
      ),
    );
  }
}
