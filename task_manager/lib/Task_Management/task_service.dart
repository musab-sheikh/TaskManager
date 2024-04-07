import 'package:flutter/foundation.dart';
import 'dart:convert'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/Task_Management/task_model.dart';
import 'package:http/http.dart' as http;



// class TaskService {
//   // Sample tasks (initialize from local storage)
//   late List<Task> _tasks; 

//   TaskService() {
//     _loadTasks();
//   }

//   Future<List<Task>> getTasks(int pageNumber) async {
//     // Simulate pagination from 'users' API in reqres.in
//     final response =
//         await Future.delayed(const Duration(milliseconds: 800), () {
//       return [
//         {
//           'id': 1 + (pageNumber - 1) * 6,
//           'first_name': 'Task ${1 + (pageNumber - 1) * 6}'
//         },
//         {
//           'id': 2 + (pageNumber - 1) * 6,
//           'first_name': 'Task ${2 + (pageNumber - 1) * 6}'
//         },
//         // ... Up to 6 items
//       ];
//     });

//     // Map simulated response to Task objects
//     return response
//         .map((user) => Task(
//             id: (user['id'] as int),
//             title: (user['first_name'] as String) // Using first_name for task title
//             ))
//         .toList();
//   }

//   Future<void> addTask(String title) async {
//     final newId = _tasks.isNotEmpty ? _tasks.last.id + 1 : 1; 
//     _tasks.add(Task(id: newId, title: title));
//     await _saveTasks(); 
//   }

//   Future<void> updateTask(Task task) async {
//     final index = _tasks.indexWhere((element) => element.id == task.id);
//     if (index != -1) {
//       _tasks[index] = task; // Replace the existing task
//       await _saveTasks();
//     }
//   }

//   Future<void> deleteTask(int id) async {
//     _tasks.removeWhere((element) => element.id == id);
//     await _saveTasks();
//   }

//   // Internal methods for local storage
//   Future<void> _loadTasks() async {
//     final prefs = await SharedPreferences.getInstance();
//     final tasksJson = prefs.getString('tasks');
//     if (tasksJson != null) {
//       _tasks = (jsonDecode(tasksJson) as List).map((e) => Task.fromJson(e)).toList();
//     }  else {
//       _tasks = [ 
//         Task(id: 1, title: 'Sample Task 1'),
//         Task(id: 2, title: 'Sample Task 2', isCompleted: true),
//       ]; 
//     }
//   }

//   Future<void> _saveTasks() async {
//     final prefs = await SharedPreferences.getInstance();
//     final tasksJson = jsonEncode(_tasks.map((task) => task.toJson()).toList());
//     await prefs.setString('tasks', tasksJson);
//   }
// }


class TaskService {
  final String _baseUrl = 'reqres.in';
  List<Task> _tasks = [];

   // Fetch tasks
  Future<List<Task>> fetchTasks(int page) async {
    final Uri url = Uri.https(_baseUrl, '/api/users', {'page': '$page'});
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> tasksJson = data['data'];

      _tasks = tasksJson.map((json) => Task.fromJson(json)).toList();
      return _tasks;
    } else {
      throw Exception('Failed to load tasks');
    }
  }
  // Simulate adding a task
  Future<Task> addTask(Task task) async {
    // For simulation purposes with reqres.in, we'll just add the task to our list
    // In a real scenario, you would make a POST request to your backend
    _tasks.add(task);
    return task; // Return the added task
  }

  // Simulate editing a task
  Future<Task> editTask(Task task) async {
    // For simulation purposes with reqres.in, find the task and replace it
    // In a real scenario, you would make a PUT/PATCH request to your backend
    final taskIndex = _tasks.indexWhere((t) => t.id == task.id);
    if(taskIndex != -1) {
      _tasks[taskIndex] = task;
      return task; // Return the edited task
    } else {
      throw Exception('Task not found');
    }
  }

  // Simulate deleting a task
  Future<void> deleteTask(int taskId) async {
    // For simulation purposes with reqres.in, remove the task from the list
    // In a real scenario, you would make a DELETE request to your backend
    _tasks.removeWhere((task) => task.id == taskId);
  }
}
