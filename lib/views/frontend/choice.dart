import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/widgets/auth_button.dart';
import 'package:tk_pertiwi/views/widgets/register_options.dart';

class ChoiceScreen extends StatefulWidget {
  const ChoiceScreen({super.key});

  @override
  _ChoiceScreenState createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _fadeInAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
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
      body: Stack(
        children: [
          Container(color: AppColors.green.withOpacity(0.80)),
          Center(
            child: FadeTransition(
              opacity: _fadeInAnimation,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Image.asset(
                        'assets/img/logo.png',
                        width: screenWidth * 0.6,
                        height: screenHeight * 0.25,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 16), // Spasi antara logo dan teks
                    const Text(
                      "TK PINTAR",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 5.0,
                      ),
                    ),
                    const SizedBox(height: 40),
                    AuthButton(
                      text: 'MASUK',
                      onPressed: () {
                        Get.toNamed('/login');
                      },
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.green,
                    ),
                    const SizedBox(height: 20),
                    AuthButton(
                      text: 'DAFTAR',
                      onPressed: () {
                        RegisterOptions.show(context);
                      },
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.green,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
