import 'dart:convert'; 
import 'package:task_manager/Authentication/local_storage_service.dart';
import 'package:task_manager/Task_Management/task_model.dart';
import 'package:http/http.dart' as http;

// class TaskService {
//   final String _baseUrl = 'https://reqres.in/api';
//     final LocalStorageService _localStorage = LocalStorageService(); // Instance of storage service

//   List<Task> _tasks = [];

//    // Fetch tasks
//   Future<List<Task>> fetchTasks(int page) async {
//     final Uri url = Uri.https(_baseUrl, '/users', {'page': '$page'});
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final List<dynamic> tasksJson = data['data'];

//       _tasks = tasksJson.map((json) => Task.fromJson(json)).toList();
//       return _tasks;
//     } else {
//       throw Exception('Failed to load tasks');
//     }
//   }
//   // Simulate adding a task
//  Future<Task> addTask(String name, String job) async {
//     final Uri url = Uri.https(_baseUrl, '/users');
//     final response = await http.post(
//       url, 
//       body: jsonEncode({'name': name, 'job': job})
//     );

//     if (response.statusCode == 201) {
//       final newTaskData = jsonDecode(response.body);
//       return Task.fromJson(newTaskData);
//     } else {
//       throw Exception('Failed to add task');
//     }
//   }
// Future<Task> editTask(int taskId, String name, String job) async {
//   final Uri url = Uri.https(_baseUrl, '/api/users/$taskId');
//   final response = await http.put(
//     url,
//     body: jsonEncode({'name': name, 'job': job})
//   );

//   if (response.statusCode == 200) {
//     final updatedTaskData = jsonDecode(response.body);
//     return Task.fromJson(updatedTaskData); // Assuming your Task model
//   } else {
//     throw Exception('Failed to edit task');
//   }
// }

//   // Simulate deleting a task
//   Future<void> deleteTask(int taskId) async {
//     // For simulation purposes with reqres.in, remove the task from the list
//     // In a real scenario, you would make a DELETE request to your backend
//     _tasks.removeWhere((task) => task.id == taskId);
//   }
// }

class TaskService {
  final String _baseUrl = 'https://reqres.in/api';
  final LocalStorageService _localStorage = LocalStorageService();

  List<Task> _tasks = [];

  // Fetch tasks 
  Future<List<Task>> fetchTasks(int page) async {
    // Try loading from local storage first
    try {
      List<Task> storedTasks = await _localStorage.loadTasks();
      if (storedTasks.isNotEmpty) {
        _tasks = storedTasks;
        return _tasks;
      }
    } catch (e) {
      print('Error loading tasks locally: $e');
    }

    // If local load fails or data is empty, fetch from API
    final Uri url = Uri.https(_baseUrl, '/users', {'page': '$page'});
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> tasksJson = data['data'];
      _tasks = tasksJson.map((json) => Task.fromJson(json)).toList();

      // Save to storage after successful fetch
      _localStorage.saveTasks(_tasks); 
      return _tasks;
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  // Add Task
  Future<Task> addTask(String name, String job) async {
    final Uri url = Uri.https(_baseUrl, '/users');
    final response = await http.post(
      url, 
      body: jsonEncode({'name': name, 'job': job})
    );

    if (response.statusCode == 201) {
      final newTaskData = jsonDecode(response.body);
      Task task = Task.fromJson(newTaskData);

      // Update local data
      _tasks.add(task);
      _localStorage.saveTasks(_tasks); 
      return task;
    } else {
      throw Exception('Failed to add task');
    }
  }

  // Edit Task 
  Future<Task> editTask(int taskId, String name, String job) async {
    final Uri url = Uri.https(_baseUrl, '/api/users/$taskId');
    final response = await http.put(
      url,
      body: jsonEncode({'name': name, 'job': job})
    );

    if (response.statusCode == 200) {
      final updatedTaskData = jsonDecode(response.body);
      Task task = Task.fromJson(updatedTaskData); 

      // Update local data
      final taskIndex = _tasks.indexWhere((t) => t.id == taskId);
      if (taskIndex != -1) {
        _tasks[taskIndex] = task;
        _localStorage.saveTasks(_tasks); 
      }
      return task; 
    } else {
      throw Exception('Failed to edit task');
    }
  }

  // Delete Task
  Future<void> deleteTask(int taskId) async {
    // For simulation with reqres.in, locally remove from the list
    // If you have a real backend, implement the DELETE request here

    _tasks.removeWhere((task) => task.id == taskId);
    _localStorage.saveTasks(_tasks); 
  }
}