import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/views/backend/features/announcement.dart';
import 'package:tk_pertiwi/views/backend/profile/account.dart';
import 'package:tk_pertiwi/views/backend/profile/change_password.dart';
import 'package:tk_pertiwi/views/backend/profile/notification.dart';
import 'package:tk_pertiwi/views/backend/profile/profile.dart';
import 'package:tk_pertiwi/views/backend/profile/support_center.dart';
import 'package:tk_pertiwi/views/frontend/splash.dart';
import 'package:tk_pertiwi/views/frontend/choice.dart';
import 'package:tk_pertiwi/views/frontend/register/parent.dart';
import 'package:tk_pertiwi/views/frontend/register/teacher.dart';
import 'package:tk_pertiwi/views/frontend/login.dart';
import 'package:tk_pertiwi/views/backend/home.dart';
import 'package:tk_pertiwi/views/frontend/forgot_password/send_email.dart';
import 'package:tk_pertiwi/views/frontend/forgot_password/verification.dart';
import 'package:tk_pertiwi/views/frontend/forgot_password/reset_password.dart';
import 'package:tk_pertiwi/views/frontend/forgot_password/password_updated.dart';

class MobileRoutes {
  static final routes = [
    // FrontEnd

    GetPage(name: '/splash', page: () => const SplashScreen()),
    GetPage(name: '/choice', page: () => const ChoiceScreen()),

    // Register
    GetPage(
      name: '/parent', page: () => const RegisterParentScreen(),
      transition: Transition.fadeIn, // Transisi di sini!
      transitionDuration: Duration(milliseconds: 200), // Durasi transisi
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: '/teacher', page: () => const RegisterTeacherScreen(),
      transition: Transition.fadeIn, // Transisi di sini!
      transitionDuration: Duration(milliseconds: 200), // Durasi transisi
      curve: Curves.easeInOut, // Biar smooth
    ),

    GetPage(name: '/login', page: () => const LoginScreen()),

    // Forgot Password
    GetPage(name: '/email', page: () => const SendEmailScreen()),
    GetPage(name: '/verification', page: () => const VerificationScreen()),
    GetPage(name: '/reset', page: () => const ResetPasswordScreen()),
    GetPage(name: '/updated', page: () => const PasswordUpdatedScreen()),

    // BackEnd

    GetPage(
      name: '/home', page: () => const HomeScreen()),
      

     GetPage(
      name: '/announcement', page: () => const AnnouncementScreen()),

    // Profile
    GetPage(
      name: '/profile', page: () => const ProfileScreen()),
    GetPage(
      name: '/account', page: () => const AccountScreen()),
    GetPage(
      name: '/change', page: () => const ChangePasswordScreen()),
    GetPage(
      name: '/notification', page: () => NotificationScreen()),
    GetPage(
      name: '/support', page: () => SupportCenterScreen()),
  ];
}
