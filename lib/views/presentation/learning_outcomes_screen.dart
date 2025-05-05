import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/controllers/learning_outcome_controller.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';

class LearningOutcomesScreen extends StatelessWidget {
  final LearningOutcomeController controller =
      Get.put(LearningOutcomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Hasil Belajar",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: AppFonts.PoppinsBold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hasError.value) {
          return Center(child: Text(controller.errorMessage.value));
        }

        final data = controller.learningOutcome.value;
        if (data == null) {
          return const Center(
              child: Text('Data hasil belajar tidak ditemukan.'));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/img/logo.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          "Ayo terus asah minat, bakat serta keterampilanmu. Jangan mudah putus asa untuk mencapai semua cita-citamu.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: AppFonts.PoppinsBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        // Cek apakah imageUrl kosong atau tidak
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: data.imageUrl.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: data.imageUrl,
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: 60,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.person,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : const Icon(Icons.person,
                                  size: 40, color: Colors.white),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nama: ${data.name}", style: _infoTextStyle),
                              Text("Number: ${data.number}",
                                  style: _infoTextStyle),
                              Text("Kelas: ${data.className}",
                                  style: _infoTextStyle),
                              Text("Wali Kelas: ${data.teacher}",
                                  style: _infoTextStyle),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Penilaian Perkembangan Anak",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.PoppinsBold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Laporan perkembangan secara keseluruhan",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Perkembangan Keseluruhan",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                data.accreditation,
                                style: const TextStyle(
                                  color: AppColors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ...(data.values ?? []).map((val) {
                          return _buildDevelopmentArea(
                            val.course ?? '-',
                            val.value ?? 0.0,
                            val.information ?? '',
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDevelopmentArea(String area, double score, String information) {
    final safeScore = score.isNaN ? 0.0 : score;

    // Tentukan format tampilan score
    final formattedScore = safeScore == safeScore.toInt()
        ? safeScore
            .toInt()
            .toString() // Jika nilai adalah bilangan bulat, tanpa desimal
        : safeScore.toStringAsFixed(1); // Jika tidak, dengan satu angka desimal

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                area,
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: AppFonts.PoppinsBold,
                ),
              ),
              Text(
                formattedScore,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  fontFamily: AppFonts.PoppinsBold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: safeScore / 5,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(safeScore >= 4
                ? AppColors.green
                : safeScore >= 3
                    ? Colors.orange
                    : Colors.red),
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline, size: 14, color: Colors.grey),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  information,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                    fontFamily: AppFonts.PoppinsRegular,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static const _infoTextStyle = TextStyle(
    fontFamily: AppFonts.PoppinsRegular,
    fontSize: 12,
  );

   LearningOutcomesScreen({super.key});
}
