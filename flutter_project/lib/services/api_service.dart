import 'package:http/http.dart' as http;
import '/models/task.dart';
import 'dart:convert';
import '/config/app_config.dart';

class ApiService {
  // Fetch tasks from API
  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse('${AppConfig.apiUrl}/tasks'));

    // Check if the server returned a successful response
    if (response.statusCode == 200) {
      // Parse JSON and return a list of tasks
      List<dynamic> data = json.decode(response.body);
      return data.map((task) => Task.fromMap(task)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  // Create a new task
  Future<Task> createTask(Task task) async {
    final response = await http.post(
      Uri.parse('${AppConfig.apiUrl}/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toMap()), // Send task as JSON
    );

    // Check if the response is successful
    if (response.statusCode == 201) {
      // Parse and return the newly created task
      return Task.fromMap(json.decode(response.body));
    } else {
      throw Exception('Failed to create task');
    }
  }

  // Update an existing task
  Future<void> updateTask(Task task) async {
    final response = await http.put(
      Uri.parse('${AppConfig.apiUrl}/tasks/${task.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toMap()), // Send updated task as JSON
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }

  // Delete a task
  Future<void> deleteTask(int id) async {
    final response =
        await http.delete(Uri.parse('${AppConfig.apiUrl}/tasks/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}
