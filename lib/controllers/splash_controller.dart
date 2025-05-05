import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController logoController;
  late Animation<double> bounceAnimation;

  late AnimationController gradientController;
  late Animation<double> gradientAnimation;

  final fullText = "TK PINTAR";
  var displayedText = "".obs;
  var charIndex = 0;
  var stopBouncing = false.obs;
  var startTextAnimation = false.obs;
  var startFadeOut = false.obs;
  var textColor = Colors.white.obs; // Tambahkan ini

  @override
  void onInit() {
    super.onInit();

    logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward().whenComplete(() {
        stopBouncing.value = true;
        startTextAnimation.value = true;

        Future.delayed(const Duration(milliseconds: 300), () {
          Timer.periodic(const Duration(milliseconds: 200), (timer) {
            if (charIndex < fullText.length) {
              displayedText.value += fullText[charIndex];
              charIndex++;
            } else {
              timer.cancel();
            }
          });
        });

        Future.delayed(const Duration(seconds: 3), () {
          startFadeOut.value = true;
          gradientController.forward();
        });
      });

    bounceAnimation = Tween<double>(begin: -80, end: 0).animate(
      CurvedAnimation(parent: logoController, curve: Curves.bounceOut),
    );

    gradientController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    gradientAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: gradientController,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        // Tambahkan listener untuk update warna teks
        if (gradientAnimation.value <= 0.01) {
          textColor.value = Colors.black;
        } else {
          textColor.value = Colors.white;
        }
      });

    gradientController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.toNamed("/login");
      }
    });
  }

  @override
  void onClose() {
    logoController.dispose();
    gradientController.dispose();
    super.onClose();
  }
}