import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Providers/task_provider.dart';
import 'package:task_manager/Task_Management/task_model.dart';
import 'package:task_manager/UI/theme_manager.dart';


class AddEditTaskScreen extends StatefulWidget {
  final Task? task;

  const AddEditTaskScreen({super.key, this.task});

  @override
  _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late int _id;
  late String _name;
  late String _job;

  @override
  void initState() {
    super.initState();
    _id = widget.task?.id ?? 0; // Initialize _id with the task id or 0 if task is null
    _name = widget.task?.name ?? '';
    _job = widget.task?.job ?? '';
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.task == null) {
        // Create a new task with the given name and job
        Task newTask = Task(id: _id, name: _name, job: _job);
        Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
      } else {
        // Edit logic
      }
        // Update an existing task with the modified name and job
        Task updatedTask = Task(id: widget.task!.id, name: _name, job: _job);
        Provider.of<TaskProvider>(context, listen: false).editTask(updatedTask);
      Navigator.of(context).pop(); // Go back to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
                title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
  actions: [
    IconButton(
      icon: const Icon(Icons.brightness_6),
      onPressed: () {
        final themeManager = Provider.of<ThemeManager>(context, listen: false);
        themeManager.setTheme(themeManager.getTheme().brightness == Brightness.dark
            ? ThemeData.light()
            : ThemeData.dark());
      },
    ),
  ],
),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Task Name'),
                onSaved: (value) => _name = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _job,
                decoration: const InputDecoration(labelText: 'Task Description'),
                onSaved: (value) => _job = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a job description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
