import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Providers/task_provider.dart';
import 'package:task_manager/UI/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
      ],
      child: MaterialApp(
        title: 'Task Manager App',
        home: LoginScreen(),
      ),
    );
  }
}
