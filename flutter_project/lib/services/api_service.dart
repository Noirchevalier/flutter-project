import 'package:http/http.dart' as http;
import '/models/task.dart';
import 'dart:convert';
import '/config/app_config.dart';

class ApiService {
  final String baseUrl = 'https://yourapi.com';

  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/tasks'));

    if (response.statusCode == 200) {
      List<dynamic> taskList = json.decode(response.body);
      print('Fetched tasks: $taskList');
      return taskList.map((taskData) => Task.fromMap(taskData)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<Task> createTask(Task task) async {
    final response = await http.post(
      Uri.parse('${AppConfig.apiUrl}/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toMap()),
    );

    if (response.statusCode == 201) {
      return Task.fromMap(json.decode(response.body));
    } else {
      throw Exception('Failed to create task');
    }
  }

  Future<void> updateTask(Task task) async {
    final response = await http.put(
      Uri.parse('${AppConfig.apiUrl}/tasks/${task.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toMap()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(int id) async {
    final response =
        await http.delete(Uri.parse('${AppConfig.apiUrl}/tasks/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}
