import 'package:http/http.dart' as http;
import 'dart:convert'; 
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final baseUrl = 'https://reqres.in/api';

  Future<bool> login(String email, String password) async {
    // Send login request
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      // Login Successful
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', 'sample_token'); // Store a mock token 
      return true;
    } else {
      // Login Failed
      throw Exception('Login failed'); 
    }
  }
}

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class AuthService {
//   final String _baseUrl = 'reqres.in';

//   // Function to login user
//   Future<bool> login(String email, String password) async {
//     final Uri url = Uri.https(_baseUrl, '/api/login');
//     final response = await http.post(
//       url,
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'email': email,
//         'password': password,
//       }),
//     );

//     if (response.statusCode == 200) {
//       // Assuming the token or any response that indicates a successful login is returned
//       // Handle successful authentication here (e.g., store auth token)
//       return true;
//     } else {
//       // Handle error or unsuccessful login
//       // For simplicity, we're just returning false here
//       return false;
//     }
//   }
// }
