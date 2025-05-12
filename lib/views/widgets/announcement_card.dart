import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import CachedNetworkImage

class AnnouncementCard extends StatelessWidget {
  final String? title;
  final String message;
  final String? date;
  final bool isPreview;

  const AnnouncementCard({
    super.key,
    required this.title,
    required this.message,
    this.date,
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
                  const SizedBox(width: 8),
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
