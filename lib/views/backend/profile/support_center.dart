import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';

class SupportCenterScreen extends StatelessWidget {
  final String phoneNumber = '6285784704929';

  void _showSupportInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
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
            child: const Text('TUTUP',
                style: TextStyle(color: AppColors.green)),
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
            // Header Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.help_outline_rounded,
                      size: 28, color: AppColors.green),
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
            ),

            const SizedBox(height: 32),

            // Illustration Section
            Center(
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
            ),

            const SizedBox(height: 32),

            // Description Section
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

            const SizedBox(height: 32),

            // Contact Section
            Container(
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
                      child: const Icon(Icons.phone_rounded,
                          color: AppColors.green),
                    ),
                    title: Text(
                      'Putri Aradea, S.Kom',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                        fontFamily: AppFonts.PoppinsSemiBold,
                      ),
                    ),
                    subtitle: Text(
                      phoneNumber,
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
                      icon: const Icon(
                        Icons.chat_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
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
                      onPressed: () => _openWhatsApp(phoneNumber),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openWhatsApp(String number) {
    String url = "whatsapp://send?phone=$number";
    // Implementasi buka WhatsApp
  }
}
