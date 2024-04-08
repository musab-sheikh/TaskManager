import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Authentication/auth_service.dart';
import 'package:task_manager/UI/task_screen.dart';
import 'package:task_manager/UI/theme_manager.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
//eve.holt@reqres.in

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false; // Add a loading indicator

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
  actions: [
    IconButton(
      icon: Icon(Icons.brightness_6),
      onPressed: () {
        final themeManager = Provider.of<ThemeManager>(context, listen: false);
        themeManager.setTheme(themeManager.getTheme().brightness == Brightness.dark
            ? ThemeData.light()
            : ThemeData.dark());
      },
    ),
  ],
),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),
               ElevatedButton(
                onPressed: _isLoading ? null : _handleRegister, // Disable button during loading
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: _isLoading 
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Register'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin, // Disable button during loading
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: _isLoading 
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Login'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Forgot Password?'),
              ),
            ],
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TaskListScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Failed')));
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TaskListScreen())); 
      } else {
        
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login Failed')));
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
