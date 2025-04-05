// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {
//   final String baseUrl = "http://10.0.2.2:8000/api/login";

//   Future<Map<String, dynamic>> login(String email, String password) async {
//     final url = Uri.parse("$baseUrl/login");

//     try {
//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"email": email, "password": password}),
//       );

//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         return {"error": "Login gagal, periksa email dan password"};
//       }
//     } catch (e) {
//       return {"error": "Terjadi kesalahan: $e"};
//     }
//   }
// }
