// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:task_manager/Providers/task_provider.dart';
// import 'package:task_manager/UI/login.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => TaskProvider()),
//       ],
//       child: MaterialApp(
//         title: 'Task Manager App',
//         home: LoginScreen(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Providers/task_provider.dart';
import 'package:task_manager/UI/login.dart';
import 'package:task_manager/UI/theme_manager.dart';
// Assuming you have a TaskProvider

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => ThemeManager(ThemeData.light())), // Add this line
      ],
      child: Consumer<ThemeManager>( // Use Consumer to listen to ThemeManager changes
        builder: (context, themeManager, child) {
          return MaterialApp(
            title: 'Task Manager App',
            theme: themeManager.getTheme(), // Apply the theme from ThemeManager
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}