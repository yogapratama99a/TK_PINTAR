import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';

class TeacherDetailsBottomSheet extends StatelessWidget {
  final String name;
  final String subject;

  const TeacherDetailsBottomSheet({
    super.key,
    required this.name,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
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
          // Handle bar
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
          
          // Header with close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
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
          
          // Main content container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
              children: [
                // Profile section (left)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.green.withOpacity(0.1),
                        image: const DecorationImage(
                          image: AssetImage('assets/img/attack_titan.jpg'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: AppColors.green.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: AppFonts.PoppinsBold,
                        fontSize: 16,
                        color: AppColors.green,
                      ),
                    ),
                    Text(
                      subject,
                      style: TextStyle(
                        fontFamily: AppFonts.PoppinsRegular,
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                
                // Vertical divider
                Container(
                  width: 1,
                  height: 140, // Match the height of profile section
                  color: Colors.grey[300],
                ),
                const SizedBox(width: 20),
                
                // Contact details (right)
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildContactRow(Icons.email, 'Email', '${name.toLowerCase()}@pertiwi.sch.id'),
                      const SizedBox(height: 12),
                      _buildContactRow(Icons.phone, 'Telepon', '+6281234567890'),
                      const SizedBox(height: 12),
                      _buildContactRow(Icons.calendar_today, 'Bergabung', '15 Agustus 2020'),
                      const SizedBox(height: 12),
                      _buildContactRow(Icons.school, 'Pendidikan', 'S1 Pendidikan $subject'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // About teacher section
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
                    Text(
                      'Tentang Guru',
                      style: TextStyle(
                        fontFamily: AppFonts.PoppinsBold,
                        fontSize: 16,
                        color: AppColors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${name.split(' ')[1]} adalah guru $subject yang berdedikasi dengan pengalaman mengajar lebih dari 5 tahun. '
                      'Memiliki spesialisasi dalam metode pembelajaran kreatif dan dikenal dengan pendekatan mengajar yang menyenangkan.',
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