import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/backend/features/announcement.dart'; // Import AnnouncementScreen

class AnnouncementCard extends StatelessWidget {
  final String name;
  final String position;
  final String message;
  final String? date;
  final bool isPreview; // Mode preview untuk Home

  const AnnouncementCard({
    super.key,
    required this.name,
    required this.position,
    required this.message,
    this.date,
    this.isPreview = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Pindah ke AnnouncementScreen saat diklik
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AnnouncementScreen(),
          ),
        );
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(backgroundColor: AppColors.green, radius: 20),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: AppFonts.PoppinsBold),
                      ),
                      Text(
                        position,
                        style: const TextStyle(color: Colors.grey, fontSize: 12, fontFamily: AppFonts.PoppinsRegular),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (date != null)
                    Text(
                      date!,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                isPreview && message.length > 50
                    ? "${message.substring(0, 50)}..." // Tampilkan hanya 50 karakter pertama jika preview
                    : message,
                style: const TextStyle(fontFamily: AppFonts.PoppinsRegular),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
