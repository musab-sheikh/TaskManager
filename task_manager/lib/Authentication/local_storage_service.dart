import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/Task_Management/task_model.dart';

class LocalStorageService {
  final String _tasksKey = 'tasks';

  // Save tasks to local storage
  Future<void> saveTasks(List<Task> tasks) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert list of tasks to a list of maps then to a JSON string
    String tasksJson = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString(_tasksKey, tasksJson);
  }

  // Load tasks from local storage
  Future<List<Task>> loadTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasksJson = prefs.getString(_tasksKey);
    if (tasksJson != null) {
      Iterable decoded = jsonDecode(tasksJson);
      List<Task> tasks = List<Task>.from(decoded.map((task) => Task.fromJson(task)));
      return tasks;
    } else {
      return [];
    }
  }

  // Clear all tasks from local storage
  Future<void> clearTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tasksKey);
  }
}
