import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Providers/task_provider.dart';
import 'package:task_manager/UI/add_edit.dart';
import 'package:task_manager/UI/theme_manager.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final themeManager = Provider.of<ThemeManager>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              themeManager.setTheme(themeManager.getTheme().brightness == Brightness.dark ? ThemeData.light() : ThemeData.dark());
              // Using ScaffoldMessenger to show a SnackBar message for theme change
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Theme changed to ${themeManager.getTheme().brightness == Brightness.dark ? 'Dark' : 'Light'} mode'),
              ));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: taskProvider.tasks.length,
        itemBuilder: (context, index) {
          final task = taskProvider.tasks[index];
          return Dismissible(
            key: Key(task.id.toString()),
            direction: DismissDirection.endToStart, // Restrict swipe direction to end-to-start
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              taskProvider.deleteTask(task.id);
              // Showing a SnackBar on deletion
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Task deleted'),
              ));
            },
            child: ListTile(
              leading: Icon(Icons.task, color: Theme.of(context).highlightColor),
              title: Text(task.name),
              subtitle: Text(task.job),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddEditTaskScreen(task: task)),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEditTaskScreen())),
        tooltip: 'Add Task',
        child: const Icon(Icons.add), 
      ),
    );
  }
}
