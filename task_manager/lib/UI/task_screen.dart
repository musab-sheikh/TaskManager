// import 'package:flutter/material.dart';
// import 'package:task_manager/Task_Management/task_model.dart';
// import 'package:task_manager/Task_Management/task_service.dart';

// class TaskScreen extends StatefulWidget {
//   @override
//   _TaskScreenState createState() => _TaskScreenState();
// }

// class _TaskScreenState extends State<TaskScreen> {
//   final TaskService _taskService = TaskService();
//   List<Task> _tasks = [];
//   int _currentPage = 1;

//   @override
//   void initState() {
//     super.initState();
//     _loadTasks();
//   }

//   void _loadTasks() async {
//     List<Task> tasks = await _taskService.fetchTasks(_currentPage);
//     setState(() {
//       _tasks = tasks;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tasks'),
//       ),
//       body: // Inside TaskScreen's build method, modify ListView.builder:
//  ListView.builder(
//   itemCount: _tasks.length + 1, // Add one for the load more button
//   itemBuilder: (context, index) {
//     if (index < _tasks.length) {
//       final task = _tasks[index];
//       return ListTile(
//         title: Text(task.name),
//         subtitle: Text(task.job),
//       );
//     } else {
//       return ElevatedButton(
//         onPressed: () {
//           setState(() {
//             _currentPage++;
//           });
//           _loadTasks();
//         },
//         child: Text('Load More'),
//       );
//     }
//   },
// ),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Navigate to add/edit task screen
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Providers/task_provider.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TaskProvider>(context, listen: false).fetchTasks(_currentPage));
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.name),
            subtitle: Text(task.job),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add/edit task screen
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
