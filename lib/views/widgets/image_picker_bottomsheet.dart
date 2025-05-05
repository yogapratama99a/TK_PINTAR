
import 'package:flutter/material.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  const ImagePickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Kamera'),
          onTap: () {
            Navigator.pop(context);
            // Tambahkan fungsi ambil gambar dari kamera
          },
        ),
        ListTile(
          leading: const Icon(Icons.photo),
          title: const Text('Galeri'),
          onTap: () {
            Navigator.pop(context);
            // Tambahkan fungsi ambil gambar dari galeri
          },
        ),
      ],
    );
  }
}
