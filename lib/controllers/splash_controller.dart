import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tk_pertiwi/services/api_service.dart';

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
  var textColor = Colors.white.obs;

  @override
  void onInit() {
    super.onInit();
    _initAnimations();
  }

  void _initAnimations() {
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
        if (gradientAnimation.value <= 0.01) {
          textColor.value = Colors.black;
        } else {
          textColor.value = Colors.white;
        }
      });
    Future.delayed(const Duration(seconds: 1), () {
      _checkAuthStatus();
    });
  }

  Future<void> _checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');
    final role = prefs.getString('role');

    print('Token tersimpan: $token');
    print('Role tersimpan: $role');

    if (token == null || token.isEmpty || role == null || role.isEmpty) {
      // Kalau token atau role kosong → ke login
      _navigateAfterDelay("/login");
      return;
    }

    // Kalau token dan role ada → arahkan sesuai role
    if (role == 'teacher') {
      _navigateAfterDelay("/home-teacher");
    } else if (role == 'parent') {
      _navigateAfterDelay("/home-parent");
    } else {
      // Kalau role aneh → fallback ke login
      _navigateAfterDelay("/login");
    }
  }

  Future<void> _navigateAfterDelay(String routeName) async {
    // Wait for animations to complete or minimum splash time (3 seconds)
    await Future.delayed(const Duration(seconds: 3));

    startFadeOut.value = true;
    gradientController.forward().whenComplete(() {
      Get.offAllNamed(routeName);
    });
  }

  @override
  void onClose() {
    logoController.dispose();
    gradientController.dispose();
    super.onClose();
  }
}
