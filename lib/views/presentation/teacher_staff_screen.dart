import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/controllers/teacher_controller.dart';
import 'package:tk_pertiwi/views/presentation/chat-parent_screen.dart';
import 'package:tk_pertiwi/views/presentation/detail_screen.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:tk_pertiwi/views/widgets/custom_input_field.dart';

import '../../controllers/teacher_detail_controller.dart';

class TeacherStaffScreen extends StatefulWidget {
  final TeacherStaffController controller = Get.put(TeacherStaffController());

   TeacherStaffScreen({super.key});

  @override
  State<TeacherStaffScreen> createState() => _TeacherStaffScreenState();
}

class _TeacherStaffScreenState extends State<TeacherStaffScreen> {
  late TextEditingController searchController;
  bool isAllSelected = true;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.addListener(() {
      widget.controller.filterTeachers(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _showTeacherDetails(BuildContext context, int id, String name, String subject) {
  final controller = Get.put(TeacherDetailController());

  // Panggil API
  controller.fetchTeacherDetail(id);

  // Tampilkan bottom sheet
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => TeacherDetailsBottomSheet(
      id: id,
      name: name,
      subject: subject,
    ),
  );
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
          'Data Guru dan Staff',
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
            child: CustomInputField(
              label: "Pencarian",
              hintText: "Cari Guru/Staff...",
              controller: searchController,
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip(
                    label: 'Semua Guru',
                    selected: isAllSelected,
                    onTap: () {
                      setState(() {
                        isAllSelected = true;
                        widget.controller.showAllTeachers();
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  _buildFilterChip(
                    label: 'Wali Kelas',
                    selected: !isAllSelected,
                    onTap: () {
                      setState(() {
                        isAllSelected = false;
                        widget.controller.showHomeroomTeachers();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildTeacherList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: selectedIndex,
        onItemTapped: onItemTapped,
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: AppColors.green,
      backgroundColor: Colors.grey[200],
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black,
        fontFamily: AppFonts.PoppinsMedium,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  Widget _buildTeacherList() {
    return Obx(() {
      if (widget.controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final teachers = widget.controller.filteredTeachers;

      if (teachers.isEmpty) {
        return const Center(child: Text("Tidak ada data guru"));
      }

      return ListView.builder(
        itemCount: teachers.length,
        itemBuilder: (context, index) {
          final teacher = teachers[index];
          return _buildTeacherCard(
            user_id: teacher['user_id'] ?? '',
            name: teacher['name'] ?? '-',
            subject: teacher['position'] ?? 'Tidak diketahui',
            url: teacher['url'],
            isHomeroom: !isAllSelected,
          );
        },
      );
    });
  }

  Widget _buildTeacherCard({
    required int user_id,
    required String name,
    required String subject,
    required String? url,
    required bool isHomeroom,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              isImageUrlValid(url)
                  ? CircleAvatar(
                      radius: 30,
                      backgroundImage: CachedNetworkImageProvider(url!),
                      backgroundColor: Colors.transparent,
                    )
                  : CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.green.withOpacity(0.1),
                      child: const Icon(Icons.person, color: AppColors.green, size: 30),
                    ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontFamily: AppFonts.PoppinsBold,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
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
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => _showTeacherDetails(context, user_id, name, subject),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),  
                child: const Text(
                  'Selengkapnya',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: AppFonts.PoppinsMedium,
                  ),
                ),
              ),
              if (isHomeroom) ...[
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SendMessageScreen(
                          receiverId: user_id,
                          receiverName: name,
                          subject: subject,
                          receiverImage: url ?? '',
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    side: const BorderSide(color: AppColors.green),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Kirim Pesan',
                    style: TextStyle(
                      color: AppColors.green,
                      fontFamily: AppFonts.PoppinsMedium,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const Divider(height: 24, thickness: 1, color: Colors.grey),
        ],
      ),
    );
  }
}
