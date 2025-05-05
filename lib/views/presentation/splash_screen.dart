import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  final controller = Get.put(SplashController());

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: controller.gradientAnimation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFFE3F2FD) // biru muda mendekati putih
                          .withOpacity(controller.gradientAnimation.value),
                      const Color(0xFF64B5F6) // biru sedang
                          .withOpacity(controller.gradientAnimation.value),
                      const Color(0xFF1565C0) // biru tua
                          .withOpacity(controller.gradientAnimation.value),
                    ],
                    stops: const [0.1, 0.5, 1.0],
                  ),
                ),
              );
            },
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo-hero',
                  child: AnimatedBuilder(
                    animation: controller.bounceAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(
                          0,
                          controller.stopBouncing.value
                              ? (controller.startFadeOut.value ? -50 : 0)
                              : controller.bounceAnimation.value,
                        ),
                        child: Image.asset(
                          'assets/img/logo.png',
                          width: screenWidth * 0.6,
                          height: screenHeight * 0.25,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Obx(() => controller.startTextAnimation.value
                    ? Text(
                        controller.displayedText.value,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: controller
                              .textColor.value, // Gunakan nilai dari controller
                          letterSpacing: 5.0,
                        ),
                      )
                    : const SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
