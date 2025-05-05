import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import CachedNetworkImage

class AnnouncementCard extends StatelessWidget {
  final String? name;
  final String? title;
  final String? position;
  final String message;
  final String? date;
  final String? imageUrl;
  final bool isPreview;

  const AnnouncementCard({
    super.key,
    required this.title,
    this.name,
    this.position = 'Guru',
    required this.message,
    this.date,
    this.imageUrl,
    this.isPreview = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/announcements/student');
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
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: imageUrl ?? '',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 40,
                        height: 40,
                        color: AppColors.green.withOpacity(0.2),
                        child: const Icon(Icons.person, color: AppColors.green),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 40,
                        height: 40,
                        color: AppColors.green.withOpacity(0.2),
                        child: const Icon(Icons.person, color: AppColors.green),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name ?? 'Guru',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.PoppinsBold,
                        ),
                      ),
                      Text(
                        position ?? 'Guru',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontFamily: AppFonts.PoppinsRegular,
                        ),
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
                    ? "${message.substring(0, 50)}..."
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
