import 'package:flutter/material.dart';
import 'package:task_manager/Authentication/auth_service.dart';
import 'package:task_manager/UI/task_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false; // Add a loading indicator

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  void _handleLogin() async {
    setState(() { 
      _isLoading = true; // Show loading indicator
    });

    try {
      bool success = await AuthService().login(_emailController.text, _passwordController.text);
      if (success) {
          print('Chal gya');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TaskScreen())); 
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

// import 'package:flutter/material.dart';
// import 'package:task_manager/Authentication/auth_service.dart';
// import 'package:task_manager/UI/task_screen.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final AuthService _authService = AuthService();

//   void _login() async {
//     final email = _emailController.text;
//     final password = _passwordController.text;

//     final bool loggedIn = await _authService.login(email, password);

//     if (loggedIn) {
//       // Navigate to your app's home screen or dashboard
//   // Replaces the current screen in the navigator with LoginScreen.
//   print('lol');
//   Navigator.pushReplacement(
//     context,
//     MaterialPageRoute(builder: (context) => TaskScreen()),
//   );    } else {
//       // Show error message
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Login Failed'),
//             content: Text('Invalid email or password.'),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('Close'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _login,
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
