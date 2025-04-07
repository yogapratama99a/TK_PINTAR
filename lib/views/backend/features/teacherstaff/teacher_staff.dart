import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/backend/features/teacherstaff/chat.dart';
import 'package:tk_pertiwi/views/backend/features/teacherstaff/detail.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:tk_pertiwi/views/widgets/custom_input_field.dart';

class TeacherStaffScreen extends StatefulWidget {
  const TeacherStaffScreen({super.key});

  @override
  _TeacherStaffScreenState createState() => _TeacherStaffScreenState();
}

class _TeacherStaffScreenState extends State<TeacherStaffScreen> {
  bool isAllSelected = true;
  TextEditingController searchController = TextEditingController();
  int selectedIndex = 0;
  List<String> allTeachers = [
    'Bu Sarah (Matematika)',
    'Pak Budi (IPA)',
    'Bu Dian (Bahasa Indonesia)',
    'Pak Eko (IPS)',
    'Bu Fitri (Seni Budaya)',
    'Pak Guntur (Olahraga)',
    'Bu Hani (Bahasa Inggris)',
    'Pak Irfan (Agama)',
    'Bu Jihan (PKn)',
    'Pak Kurnia (Prakarya)',
  ];
  String homeroomTeacher = 'Bu Sarah (Wali Kelas 5A)';
  List<String> filteredTeachers = [];

  void _showTeacherDetails(BuildContext context, String name, String subject) {
    print(
        "Menampilkan detail guru: $name, Mata pelajaran: $subject"); // Debugging
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TeacherDetailsBottomSheet(
        name: name,
        subject: subject,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    filteredTeachers = allTeachers;
    searchController.addListener(_filterTeachers);
  }

  void _filterTeachers() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredTeachers = allTeachers.where((teacher) {
        return teacher.toLowerCase().contains(query);
      }).toList();
    });
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Data Guru dan Staff',
          style: TextStyle(
            fontFamily: AppFonts.PoppinsBold,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1E88E5), // Light blue
                Color(0xFF0D47A1), // Dark blue
              ],
            ),
          ),
        ),
        foregroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: kToolbarHeight + 10,
      ),
      body: Column(
        children: [
          // Search Field with centered padding
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
            child: CustomInputField(
              label: "Pencarian",
              hintText: "Cari Guru/Staff...",
              controller: searchController,
              keyboardType: TextInputType.text,
              // prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
            ),
          ),

          // Filter Chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: const Text('Semua Guru'),
                    selected: isAllSelected,
                    onSelected: (bool selected) {
                      setState(() {
                        isAllSelected = true;
                      });
                    },
                    selectedColor: AppColors.green,
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(
                      color: isAllSelected ? Colors.white : Colors.black,
                      fontFamily: AppFonts.PoppinsMedium,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  const SizedBox(width: 10),
                  FilterChip(
                    label: const Text('Wali Kelas'),
                    selected: !isAllSelected,
                    onSelected: (bool selected) {
                      setState(() {
                        isAllSelected = false;
                      });
                    },
                    selectedColor: AppColors.green,
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(
                      color: !isAllSelected ? Colors.white : Colors.black,
                      fontFamily: AppFonts.PoppinsMedium,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // List Content
          Expanded(
            child: Container(
              // color: AppColors.lightBackground, // Background color di sini
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: isAllSelected
                    ? _buildAllTeachersList()
                    : _buildHomeroomTeacherCard(),
              ),
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

  Widget _buildAllTeachersList() {
    return ListView.builder(
      itemCount: filteredTeachers.length,
      itemBuilder: (context, index) {
        return _buildTeacherCard(
          name: filteredTeachers[index].split(' (')[0],
          subject: filteredTeachers[index].split(' (')[1].replaceAll(')', ''),
          isHomeroom: false,
        );
      },
    );
  }

  Widget _buildHomeroomTeacherCard() {
    return ListView(
      children: [
        _buildTeacherCard(
          name: homeroomTeacher.split(' (')[0],
          subject: homeroomTeacher.split(' (')[1].replaceAll(')', ''),
          isHomeroom: true,
        ),
      ],
    );
  }

  Widget _buildTeacherCard({
    required String name,
    required String subject,
    required bool isHomeroom,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.green.withOpacity(0.1),
                    image: const DecorationImage(
                      image: AssetImage('assets/img/attack_titan.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
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
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Align buttons to right
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showTeacherDetails(context, name, subject);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                if (!isAllSelected) ...[
                  const SizedBox(width: 10),
                  // In your _buildTeacherCard method, modify the OutlinedButton:
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SendMessageScreen(
                            teacherName: name,
                            teacherSubject: subject,
                            teacherImage:
                                'assets/img/attack_titan.jpg', // Add your image path
                          ),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
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
            const Divider(
              // Added divider line
              height: 24,
              thickness: 1,
              color:
                  Colors.grey, // You can use AppColors.greyLight if available
            ),
          ],
        ),
      ),
    );
  }
}
