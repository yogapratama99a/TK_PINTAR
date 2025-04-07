import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class SendMessageScreen extends StatefulWidget {
  final String teacherName;
  final String teacherSubject;
  final String teacherImage;

  const SendMessageScreen({
    super.key,
    required this.teacherName,
    required this.teacherSubject,
    required this.teacherImage,
  });

  @override
  State<SendMessageScreen> createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  String _selectedTemplate = '';
  bool _hasMessage = false;
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _messages = [
    {
      'isMe': false,
      'message': 'Selamat siang, ada yang bisa saya bantu?',
      'time': DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    },
    {
      'isMe': true,
      'message': 'Saya ingin berkonsultasi tentang nilai anak saya',
      'time': DateTime.now().subtract(const Duration(days: 1, hours: 1)),
    },
    {
      'isMe': false,
      'message': 'Tentu, kapan Bapak/Ibu bisa datang ke sekolah?',
      'time': DateTime.now().subtract(const Duration(hours: 12)),
    },
    {
      'isMe': true,
      'message': 'Bagaimana kalau besok jam 10 pagi?',
      'time': DateTime.now().subtract(const Duration(hours: 11)),
    },
  ];

  final List<Map<String, String>> _messageTemplates = [
    {
      'title': 'Izin Tidak Masuk',
      'message': 'Anak saya tidak dapat mengikuti pelajaran hari ini karena sakit. Mohon izinnya.'
    },
    {
      'title': 'Izin Sakit',
      'message': 'Dengan hormat, saya memberitahukan bahwa anak saya sedang sakit dan tidak dapat mengikuti pelajaran hari ini.'
    },
    {
      'title': 'Izin Acara Keluarga',
      'message': 'Mohon izin anak saya tidak dapat mengikuti pelajaran pada tanggal [tanggal] karena ada acara keluarga yang penting.'
    },
    {
      'title': 'Konsultasi Akademik',
      'message': 'Saya ingin berkonsultasi mengenai perkembangan akademik anak saya. Kapan saya bisa menemui Bapak/Ibu?'
    },
    {
      'title': 'Laporan Masalah',
      'message': 'Saya ingin melaporkan bahwa anak saya mengalami [jelaskan masalah] di sekolah. Mohon bantuannya.'
    },
  ];

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      setState(() {
        _hasMessage = _messageController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(widget.teacherImage),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.teacherName,
                  style: TextStyle(
                    fontFamily: AppFonts.PoppinsMedium,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.teacherSubject,
                  style: TextStyle(
                    fontFamily: AppFonts.PoppinsRegular,
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1E88E5),
                Color(0xFF0D47A1),
              ],
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFE3F2FD),
                    Color(0xFFBBDEFB),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Cloud background
                  CustomPaint(
                    painter: _CloudPainter(),
                    size: Size.infinite,
                  ),
                  // Messages list
                  ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      bool showDateSeparator = false;
                      if (index == 0) {
                        showDateSeparator = true;
                      } else {
                        final currentDate = DateFormat('yyyy-MM-dd').format(_messages[index]['time']);
                        final previousDate = DateFormat('yyyy-MM-dd').format(_messages[index - 1]['time']);
                        showDateSeparator = currentDate != previousDate;
                      }

                      final message = _messages[index];
                      final isToday = DateFormat('yyyy-MM-dd').format(message['time']) == 
                          DateFormat('yyyy-MM-dd').format(DateTime.now());
                      final isYesterday = DateFormat('yyyy-MM-dd').format(message['time']) == 
                          DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 1)));

                      return Column(
                        children: [
                          if (showDateSeparator)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                isToday ? 'Hari Ini' : isYesterday ? 'Kemarin' : 
                                    DateFormat('EEEE, d MMMM y').format(message['time']),
                                style: TextStyle(
                                  fontFamily: AppFonts.PoppinsMedium,
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          _buildChatBubble(
                            isMe: message['isMe'],
                            message: message['message'],
                            time: message['time'],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _messageTemplates.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ChoiceChip(
                          label: Text(_messageTemplates[index]['title']!),
                          selected: _selectedTemplate == _messageTemplates[index]['title'],
                          onSelected: (selected) {
                            setState(() {
                              _selectedTemplate = selected 
                                ? _messageTemplates[index]['title']! 
                                : '';
                              if (selected) {
                                _messageController.text = _messageTemplates[index]['message']!;
                                _hasMessage = true;
                              }
                            });
                          },
                          backgroundColor: Colors.grey[200],
                          selectedColor: AppColors.green.withOpacity(0.2),
                          labelStyle: TextStyle(
                            fontFamily: AppFonts.PoppinsMedium,
                            fontSize: 12,
                            color: _selectedTemplate == _messageTemplates[index]['title'] 
                              ? AppColors.green 
                              : Colors.grey[700],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.attach_file, color: AppColors.green),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Ketik pesan...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        ),
                        maxLines: 3,
                        minLines: 1,
                      ),
                    ),
                    if (_hasMessage)
                      IconButton(
                        icon: Icon(Icons.send, color: AppColors.green),
                        onPressed: _sendMessage,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble({
    required bool isMe,
    required String message,
    required DateTime time,
  }) {
    final timeString = DateFormat('HH:mm').format(time);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDay = DateTime(time.year, time.month, time.day);
    
    final timeText = messageDay == today 
        ? timeString 
        : '${DateFormat('d MMM').format(time)}, $timeString';

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isMe
                ? const Color(0xFFE1F5FE)
                : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: Radius.circular(isMe ? 12 : 4),
              bottomRight: Radius.circular(isMe ? 4 : 12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(
                  fontFamily: AppFonts.PoppinsRegular,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  timeText,
                  style: TextStyle(
                    fontFamily: AppFonts.PoppinsRegular,
                    fontSize: 10,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon isi pesan terlebih dahulu'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _messages.add({
        'isMe': true,
        'message': _messageController.text,
        'time': DateTime.now(),
      });
    });

    _messageController.clear();
    _selectedTemplate = '';
    _hasMessage = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}

class _CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final random = Random();
    for (int i = 0; i < 8; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height * 0.7;
      _drawCloud(canvas, paint, Offset(x, y));
    }
  }

  void _drawCloud(Canvas canvas, Paint paint, Offset center) {
    canvas.drawCircle(center, 25, paint);
    canvas.drawCircle(center + Offset(20, -8), 30, paint);
    canvas.drawCircle(center + Offset(35, 0), 25, paint);
    canvas.drawCircle(center + Offset(20, 8), 30, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}