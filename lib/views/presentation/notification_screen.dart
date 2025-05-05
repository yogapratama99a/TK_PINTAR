import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _showNotifications = true;
  bool _notificationSound = true;
  bool _vibration = true;
  bool _clearOnOpen = false;
  bool _showPreview = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Pengaturan Notifikasi',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSettingItem(
              icon: Icons.notifications_active,
              title: "Tampilkan Notifikasi",
              value: _showNotifications,
              onChanged: (value) {
                setState(() {
                  _showNotifications = value;
                });
              },
            ),
            _buildDivider(),
            _buildSettingItem(
              icon: Icons.volume_up,
              title: "Suara Notifikasi",
              value: _notificationSound,
              onChanged: (value) {
                setState(() {
                  _notificationSound = value;
                });
              },
            ),
            _buildDivider(),
            _buildSettingItem(
              icon: Icons.vibration,
              title: "Getar",
              value: _vibration,
              onChanged: (value) {
                setState(() {
                  _vibration = value;
                });
              },
            ),
            _buildDivider(),
            _buildSettingItem(
              icon: Icons.delete_outline,
              title: "Hapus Saat Buka Aplikasi",
              value: _clearOnOpen,
              onChanged: (value) {
                setState(() {
                  _clearOnOpen = value;
                });
              },
            ),
            _buildDivider(),
            _buildSettingItem(
              icon: Icons.text_snippet,
              title: "Tampilkan Pratinjau",
              value: _showPreview,
              onChanged: (value) {
                setState(() {
                  _showPreview = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.green),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: AppFonts.PoppinsRegular,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.green,
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Colors.black12,
    );
  }

}