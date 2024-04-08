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

  void addTask(Task task) async {
    _tasks.add(task);
    await _localStorageService.saveTasks(_tasks);
    notifyListeners();
  }

  void editTask(Task updatedTask) async {
    int index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if(index != -1) {
      _tasks[index] = updatedTask;
      await _localStorageService.saveTasks(_tasks);
      notifyListeners();
    }
  }

  void deleteTask(int taskId) async {
    _tasks.removeWhere((task) => task.id == taskId);
    await _localStorageService.saveTasks(_tasks);
    notifyListeners();
  }
}
