import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class MessageBubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final DateTime time;

  const MessageBubble({
    super.key,
    required this.isMe,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDay = DateTime(time.year, time.month, time.day);

    final isToday = messageDay == today;
    final isYesterday = messageDay == yesterday;

    String timeText;
    if (isToday) {
      timeText = DateFormat('HH:mm').format(time);
    } else if (isYesterday) {
      timeText = 'Kemarin, ${DateFormat('HH:mm').format(time)}';
    } else {
      timeText =
          '${DateFormat('d MMM').format(time)}, ${DateFormat('HH:mm').format(time)}';
    }

    final bubbleColor = isMe
        ? const Color(0xFF1E88E5) // Warna biru untuk pesan sendiri
        : const Color(0xFFF1F1F1); // Warna abu untuk pesan orang lain

    final textColor = isMe ? Colors.white : Colors.black;

    final canEditOrDelete = now.difference(time).inMinutes < 60;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: GestureDetector(
          onLongPress: () {
            _showMessageOptions(context, canEditOrDelete);
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(message,
                      style: TextStyle(fontSize: 14, color: textColor)),
                  const SizedBox(height: 4),
                  Text(timeText,
                      style: TextStyle(
                          fontSize: 10, color: textColor.withOpacity(0.7))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMessageOptions(BuildContext context, bool canEditOrDelete) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Dikirim pada'),
                subtitle: Text(DateFormat('d MMM yyyy, HH:mm').format(time)),
              ),
              const ListTile(
                leading: Icon(Icons.mark_email_read),
                title: Text('Dibaca pada'),
                subtitle: Text('- Belum diimplementasikan -'),
              ),
              if (canEditOrDelete && isMe)
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Edit pesan'),
                  onTap: () {
                    Navigator.pop(context);
                    // Panggil logika edit (nanti kamu bisa implementasikan di controller)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fitur edit pesan dipilih')),
                    );
                  },
                ),
              ListTile(
                leading: const Icon(Icons.copy),
                title: const Text('Salin pesan'),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: message));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pesan disalin')),
                  );
                },
              ),
              if (canEditOrDelete && isMe)
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Hapus pesan'),
                  onTap: () {
                    Navigator.pop(context);
                    // Panggil logika hapus (nanti kamu bisa implementasikan di controller)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fitur hapus pesan dipilih')),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
