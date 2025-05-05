import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:tk_pertiwi/views/auth/register_success_Screen.dart';
import 'package:tk_pertiwi/views/presentation/announcement_screen.dart';
import 'package:tk_pertiwi/views/presentation/account_screen.dart';
import 'package:tk_pertiwi/views/presentation/change_password_screen.dart';
import 'package:tk_pertiwi/views/presentation/learning_outcomes_screen.dart';
import 'package:tk_pertiwi/views/presentation/notification_screen.dart';
import 'package:tk_pertiwi/views/presentation/payment_screen.dart';
import 'package:tk_pertiwi/views/presentation/profile_screen.dart';
import 'package:tk_pertiwi/views/presentation/schedule_screen.dart';
import 'package:tk_pertiwi/views/presentation/student_screen.dart';
import 'package:tk_pertiwi/views/presentation/support_center_screen.dart';
import 'package:tk_pertiwi/views/presentation/splash_screen.dart';
import 'package:tk_pertiwi/views/presentation/register_parent_screen.dart';
import 'package:tk_pertiwi/views/presentation/register_teacher_screen.dart';
import 'package:tk_pertiwi/views/presentation/login_screen.dart';
import 'package:tk_pertiwi/views/presentation/parent_home.dart';
import 'package:tk_pertiwi/views/presentation/send_email_screen.dart';
import 'package:tk_pertiwi/views/presentation/teacher_home.dart';
import 'package:tk_pertiwi/views/presentation/teacher_staff_screen.dart';
import 'package:tk_pertiwi/views/presentation/verification_screen.dart';
import 'package:tk_pertiwi/views/presentation/reset_password_screen.dart';
import 'package:tk_pertiwi/views/presentation/password_updated.dart';

class MobileRoutes {
  static final routes = [
    // FrontEnd
    GetPage(name: '/splash', page: () => SplashScreen()),

    // Register
    GetPage(
      name: '/register-parent', page: () => RegisterParentScreen(),
      transition: Transition.fadeIn, // Transisi di sini!
      transitionDuration: const Duration(milliseconds: 200), // Durasi transisi
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: '/register-teacher', page: () => RegisterTeacherScreen(),
      transition: Transition.fadeIn, // Transisi di sini!
      transitionDuration: const Duration(milliseconds: 200), // Durasi transisi
      curve: Curves.easeInOut, // Biar smooth
    ),
    GetPage(
      name: '/register-success',
      page: () => const RegisterSuccessScreen(),
    ),

    GetPage(
        name: '/login',
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
        page: () => LoginScreen()),

    // Forgot Passw ord
    GetPage(
      name: '/forgot-password/check-email', page: () => SendEmailScreen(),
      transition: Transition.fadeIn, // Transisi di sini!
      transitionDuration: const Duration(milliseconds: 200), // Durasi transisi
      curve: Curves.easeInOut, // Biar smooth
    ),
    GetPage(
      name: '/forgot-password/verify-otp', page: () => VerificationScreen(),
      transition: Transition.leftToRight, // Transisi di sini!
      transitionDuration: const Duration(milliseconds: 200), // Durasi transisi
      curve: Curves.easeInOut, // Biar smooth
    ),
    GetPage(
      name: '/forgot-password/new-password', page: () => ResetPasswordScreen(),
      transition: Transition.leftToRight, // Transisi di sini!
      transitionDuration: const Duration(milliseconds: 200), // Durasi transisi
      curve: Curves.easeInOut, // Biar smooth
    ),
    GetPage(
      name: '/forgot-password/password-updated', page: () => const PasswordUpdatedScreen(),
      transition: Transition.fadeIn, // Transisi di sini!
      transitionDuration: const Duration(milliseconds: 200), // Durasi transisi
      curve: Curves.easeInOut, // Biar smooth
    ),

    // BackEnd

    GetPage(name: '/home-parent', page: () => HomeScreen()),
    GetPage(name: '/home-teacher', page: () => TeacherHomeScreen()),

    GetPage(name: '/announcements/student', page: () => AnnouncementScreen()),

    GetPage(name: '/schedule', page: () => ScheduleScreen()),

    GetPage(name: '/teacherstaff', page: () => TeacherStaffScreen()),
    GetPage(name: '/student', page: () => StudentChatScreen()),

    GetPage(name: '/learningoutcomes', page: () => LearningOutcomesScreen()),

    GetPage(name: '/payment', page: () => PaymentScreen()),

    // Profile
    GetPage(name: '/profile', page: () => ProfileScreen()),
    GetPage(name: '/account', page: () => const AccountScreen()),
    GetPage(name: '/change', page: () => ChangePasswordScreen()),
    GetPage(name: '/notification', page: () => NotificationScreen()),
    GetPage(name: '/support', page: () => SupportCenterScreen()),
  ];
}
