// lib/views/home_screen.dart
import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskController = Provider.of<TaskController>(context);

    return Scaffold(
      appBar: AppBar(title: Text('To-Do List')),
      body: FutureBuilder(
        future: taskController.loadTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: taskController.tasks.length,
              itemBuilder: (context, index) {
                final task = taskController.tasks[index];
                return ListTile(
                  title: Text(task.title),
                  // Other UI elements for each task
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to TaskFormScreen for adding a task
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
