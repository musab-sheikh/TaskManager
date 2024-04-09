import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Authentication/auth_service.dart';
import 'package:task_manager/UI/task_screen.dart';
import 'package:task_manager/UI/theme_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false; // Add a loading indicator
  final _formKey = GlobalKey<FormState>(); // Add a key for the form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              final themeManager = Provider.of<ThemeManager>(context, listen: false);
              themeManager.setTheme(themeManager.getTheme().brightness == Brightness.dark ? ThemeData.light() : ThemeData.dark());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Form( // Wrap your column with a Form widget
          key: _formKey, // Associate the form key
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) { // Add email validation
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null; // Return null if the input is valid
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) { // Add password validation
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null; // Return null if the input is valid
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _isLoading ? null : () {
                    if (_formKey.currentState!.validate()) { // Check if the form is valid
                      _handleRegister();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Register'),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _isLoading ? null : () {
                    if (_formKey.currentState!.validate()) { // Check if the form is valid
                      _handleLogin();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Login'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Forgot Password?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


void _handleRegister() async {
  setState(() { 
    _isLoading = true; // Show loading indicator
  });

  try {
    bool success = await AuthService().signUp(_emailController.text, _passwordController.text);
    if (success) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TaskListScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration Failed')));
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')));
  } finally {
    setState(() {
      _isLoading = false; // Hide loading indicator
    });
  }
}

  void _handleLogin() async {
    setState(() { 
      _isLoading = true; // Show loading indicator
    });

    try {
      bool success = await AuthService().login(_emailController.text, _passwordController.text);
      if (success) {
          print('Chal gya');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TaskListScreen())); 
      } else {
        
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Failed')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')));
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }
}
