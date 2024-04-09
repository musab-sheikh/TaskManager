import 'package:http/http.dart' as http;
import 'dart:convert'; 
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final baseUrl = 'https://reqres.in/api';
Future<bool> signUp(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
      print(response.body);

    if (response.statusCode == 200) {
      // Sign Up Successful
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('id', 'token'); // Store a mock token
      return true;
    } else {
      // Sign Up Failed
      throw Exception('Sign up failed');
    }
  }


  Future<bool> login(String email, String password) async {
    print('hello');
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    print(response.body);

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

