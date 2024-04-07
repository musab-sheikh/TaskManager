import 'package:flutter/foundation.dart';
import 'package:task_manager/Authentication/local_storage_service.dart';
import 'package:task_manager/Task_Management/task_model.dart';
import 'package:task_manager/Task_Management/task_service.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  final TaskService _taskService = TaskService();
  final LocalStorageService _localStorageService = LocalStorageService();

  List<Task> get tasks => _tasks;

  TaskProvider() {
    loadTasks();
  }

  void fetchTasks(int page) async {
    _tasks = await _taskService.fetchTasks(page);
    await _localStorageService.saveTasks(_tasks);
    notifyListeners();
  }

  void loadTasks() async {
    _tasks = await _localStorageService.loadTasks();
    notifyListeners();
  }

  // Implement addTask, editTask, deleteTask and make sure to call _localStorageService.saveTasks(_tasks) after updating the list
}
