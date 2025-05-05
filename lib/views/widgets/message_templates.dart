
import 'package:flutter/material.dart';

class MessageTemplates extends StatelessWidget {
  const MessageTemplates({super.key});

  @override
  Widget build(BuildContext context) {
    final templates = [
      'Halo, saya ingin bertanya.',
      'Terima kasih atas bantuannya!',
      'Saya sedang mengalami kendala.'
    ];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: templates.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: ActionChip(
              label: Text(templates[index]),
              onPressed: () {
                // Tambahkan fungsi pilih template
              },
            ),
          );
        },
      ),
    );
  }
}
