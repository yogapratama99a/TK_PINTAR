// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tk_pertiwi/screens/in/home.dart';
// import 'package:tk_pertiwi/services/api_service.dart';
// import 'package:tk_pertiwi/widgets/out/auth_button.dart';
// import 'package:tk_pertiwi/screens/out/login.dart';
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final ApiService apiService = ApiService();

//   void _login() async {
//     String email = emailController.text;
//     String password = passwordController.text;

//     var response = await apiService.login(email, password);

//     if (response.containsKey("access_token")) {
//       // Simpan token ke SharedPreferences
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('token', response['access_token']);

//       // Navigasi ke HomeScreen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//       );
//     } else {
//       // Tampilkan pesan error jika login gagal
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(response["error"])),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(48.0),
//           child: Column(
//             children: [
//               // ... UI lainnya tetap sama ...
//               AuthButton(
//                 text: 'MASUK',
//                 onPressed: _login, // Panggil fungsi login di sini
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
