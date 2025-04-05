import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tk_pertiwi/views/backend/features/article.dart';
import 'package:tk_pertiwi/views/backend/features/schedule.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';
import 'package:tk_pertiwi/views/backend/features/teacherstaff/teacher_staff.dart';
import 'package:tk_pertiwi/views/backend/features/learning_outcomes.dart';
import 'package:tk_pertiwi/views/backend/features/payment.dart';
import 'package:tk_pertiwi/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:tk_pertiwi/views/widgets/announcement_card.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 1.0);
  bool _isNotificationActive = false;

  List<Map<String, String>> fasilitas = [
    {
      "image": "assets/img/attack_titan.jpg",
      "title": "TAMAN BERMAIN TK PERTIWI GROJOGAN",
      "description":
          "Fasilitas yang terdapat dalam TK Pertiwi Grojogan salah satunya adalah taman bermain yang bertujuan untuk memberikan ruang bagi anak-anak untuk berekspresi dan bersosialisasi. Taman bermain ini dilengkapi dengan berbagai permainan edukatif yang aman untuk anak usia dini, seperti ayunan, perosotan, dan area bermain pasir. Fasilitas ini dirancang untuk mendukung perkembangan motorik kasar dan halus anak serta melatih kemampuan sosial mereka melalui interaksi dengan teman sebaya.",
    },
    {
      "image": "assets/img/attack_titan.jpg",
      "title": "PERPUSTAKAAN SEKOLAH",
      "description":
          "Tersedia perpustakaan sekolah untuk menunjang pembelajaran siswa dengan koleksi buku yang beragam mulai dari buku cerita bergambar, buku pengetahuan dasar, hingga buku panduan untuk orang tua. Perpustakaan kami dirancang khusus untuk anak usia dini dengan furniture yang ramah anak dan area membaca yang nyaman. Kami juga menyelenggarakan kegiatan membaca bersama setiap minggu untuk menumbuhkan minat baca sejak dini.",
    },
  ];

  String _truncateDescription(String text, {int maxLength = 80}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength).trim()}...';
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleNotification() {
    setState(() {
      _isNotificationActive = !_isNotificationActive;
    });

    Get.snackbar(
      _isNotificationActive ? "Notifikasi Aktif" : "Notifikasi Dimatikan",
      _isNotificationActive
          ? "Anda akan menerima pemberitahuan baru."
          : "Anda tidak akan menerima pemberitahuan baru.",
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
      backgroundColor: AppColors.green,
      colorText: Colors.white,
      borderRadius: 10,
      margin: EdgeInsets.all(10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed('/profile');
                  },
                  child: ClipOval(
                    child: Image.asset(
                      'assets/img/profile.png',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Selamat Datang,",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: AppFonts.PoppinsRegular,
                            fontSize: 12)),
                    Text("User Name",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: AppFonts.PoppinsBold,
                            fontWeight: FontWeight.w700,
                            fontSize: 14)),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    _isNotificationActive
                        ? Icons.notifications_active
                        : Icons.notifications_off,
                    color: AppColors.green,
                  ),
                  onPressed: _toggleNotification,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 8),
                // Carousel Section
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.8),
                        Colors.white.withOpacity(0.6),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: fasilitas.length,
                          // Di dalam PageView.builder di HomeScreen
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ArticleScreen(
                                      image: fasilitas[index]["image"]!,
                                      title: fasilitas[index]["title"]!,
                                      description: fasilitas[index]
                                          ["description"]!,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF1E88E5),
                                      Color(0xFF0D47A1),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                    )
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 12),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        fasilitas[index]["image"]!,
                                        width: 120,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            fasilitas[index]["title"]!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Divider(color: Colors.white),
                                          Text(
                                            _truncateDescription(
                                                fasilitas[index]
                                                    ["description"]!,
                                                maxLength: 80),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: fasilitas.length,
                        effect: const ExpandingDotsEffect(
                          activeDotColor: Colors.black,
                          dotColor: Colors.grey,
                          dotHeight: 8,
                          dotWidth: 8,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Features Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.9),
                        AppColors.green.withOpacity(0.8),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fitur yang tersedia",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppFonts.PoppinsBold,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCircleFeature(Icons.schedule, "Jadwal",
                              [Color(0xFFF9A825), Color(0xFFEF6C00)], () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScheduleScreen()),
                            );
                          }),
                          _buildCircleFeature(Icons.school, "Guru & Staff",
                              [Color(0xFF1976D2), Color(0xFF0D47A1)], () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TeacherStaffScreen()),
                            );
                          }),
                          _buildCircleFeature(Icons.assessment, "Hasil Belajar",
                              [Color(0xFF2E7D32), Color(0xFF1B5E20)], () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LearningOutcomesScreen()),
                            );
                          }),
                          _buildCircleFeature(Icons.payment, "Pembayaran",
                              [Color(0xFF6A1B9A), Color(0xFF4A148C)], () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentScreen()),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Simplified Announcements Section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFB3DAF0).withOpacity(0.8),
                        Color(0xFFE1F5FE).withOpacity(0.8),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Informasi Terbaru",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const AnnouncementCard(
                        name: "Imam Wahyu S.Pd",
                        position: "Guru Agama",
                        message:
                            "Untuk besok anak-anak diharapkan untuk memakai baju muslim, untuk memperingati hari Maulid Nabi.",
                        isPreview: true,
                      ),
                      const SizedBox(height: 8),
                      const AnnouncementCard(
                        name: "Imam Wahyu S.Pd",
                        position: "Guru Agama",
                        message:
                            "Untuk besok anak-anak diharapkan untuk memakai baju muslim, untuk memperingati hari Maulid Nabi.",
                        isPreview: true,
                      ),
                      const SizedBox(height: 8),
                      const AnnouncementCard(
                        name: "Imam Wahyu S.Pd",
                        position: "Guru Agama",
                        message:
                            "Untuk besok anak-anak diharapkan untuk memakai baju muslim, untuk memperingati hari Maulid Nabi.",
                        isPreview: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildCircleFeature(IconData icon, String label,
      List<Color> gradientColors, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: gradientColors.last.withOpacity(0.4),
                  blurRadius: 5,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Icon(icon, size: 30, color: Colors.white),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 80,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: AppFonts.PoppinsRegular,
                fontSize: 12,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
