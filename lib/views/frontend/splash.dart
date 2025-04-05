import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;
  String fullText = "TK PINTAR";
  String displayedText = "";
  int charIndex = 0;
  bool stopBouncing = false;
  bool startTextAnimation = false;
  bool startFadeOut = false;

  @override
  void initState() {
    super.initState();

    // **Animasi Logo dengan Pantulan**
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward().whenComplete(() {
        setState(() {
          stopBouncing = true;
          startTextAnimation = true; // **Mulai teks setelah logo selesai**
        });

        // **Mulai animasi teks setelah logo selesai**
        Future.delayed(const Duration(milliseconds: 300), () {
          Timer.periodic(const Duration(milliseconds: 200), (timer) {
            if (charIndex < fullText.length) {
              setState(() {
                displayedText += fullText[charIndex];
                charIndex++;
              });
            } else {
              timer.cancel();
            }
          });
        });

        // **Tunggu beberapa detik sebelum efek keluar**
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              startFadeOut = true;
            });
          }
          Future.delayed(const Duration(milliseconds: 800), () {
            Get.offNamed('/choice');
          });
        });
      });

    _bounceAnimation = Tween<double>(begin: -80, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.green,
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          opacity: startFadeOut ? 0 : 1, // **Efek keluar**
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // **Logo dengan pantulan lebih jauh**
              AnimatedBuilder(
                animation: _bounceAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, stopBouncing ? (startFadeOut ? -50 : 0) : _bounceAnimation.value),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: startFadeOut ? 0 : 1,
                      child: child,
                    ),
                  );
                },
                child: Image.asset(
                  'assets/img/logo.png',
                  width: screenWidth * 0.6,
                  height: screenHeight * 0.25,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),

              // **Teks muncul hanya setelah logo selesai**
              if (startTextAnimation)
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: startFadeOut ? 0 : 1,
                  child: Text(
                    displayedText,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 5.0,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
