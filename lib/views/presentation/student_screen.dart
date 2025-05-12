// student_chat_screen.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/controllers/student_controller.dart';
import 'package:tk_pertiwi/views/presentation/chat-teacher_screen.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/input_field_register.dart';
class StudentChatScreen extends StatefulWidget {
  final StudentController controller = Get.put(StudentController());

  StudentChatScreen({super.key});

  @override
  State<StudentChatScreen> createState() => _StudentChatScreenState();
}

class _StudentChatScreenState extends State<StudentChatScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.addListener(() {
      widget.controller.filterStudents(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  bool isImageUrlValid(String? url) {
    if (url == null || url.isEmpty) return false;
    final uri = Uri.tryParse(url);
    return uri != null && uri.pathSegments.isNotEmpty && uri.pathSegments.last.contains('.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          'Chat Siswa',
          style: TextStyle(
            fontFamily: AppFonts.PoppinsBold,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: kToolbarHeight + 10,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
            child: BorderLabelInputField(
              borderLabel: "Pencarian",
              hintText: "Cari Siswa...",
              controller: searchController,
              keyboardType: TextInputType.text,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildChatList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return Obx(() {
      if (widget.controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (widget.controller.errorMessage.isNotEmpty) {
        return Center(
          child: Text(
            widget.controller.errorMessage.value,
            style: const TextStyle(color: Colors.red),
          ),
        );
      }

      final students = widget.controller.filteredStudents;

      if (students.isEmpty) {
        return const Center(child: Text("Tidak ada siswa ditemukan"));
      }

      return ListView.separated(
        itemCount: students.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final student = students[index];
          return ListTile(
            leading: isImageUrlValid(student.imageUrl)
                ? CircleAvatar(
                    radius: 25,
                    backgroundImage: CachedNetworkImageProvider(student.imageUrl!),
                    backgroundColor: Colors.transparent,
                  )
                : CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.green.withOpacity(0.1),
                    child: const Icon(Icons.person, color: AppColors.green, size: 25),
                  ),
            title: Text(
              student.name,
              style: const TextStyle(
                fontFamily: AppFonts.PoppinsMedium,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              student.className ?? '-',
              style: const TextStyle(
                fontFamily: AppFonts.PoppinsRegular,
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            trailing: const Icon(Icons.chevron_right, color: AppColors.blue),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SendMessageScreen2(
                    receiverId: student.user_id,
                    receiverName: student.name,
                    receiverImage: student.imageUrl ?? '',
                    number: student.number,
                  ),
                ),
              );
            },
          );
        },
      );
    });
  }
}
