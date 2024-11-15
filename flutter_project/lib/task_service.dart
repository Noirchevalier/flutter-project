import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_project/config/app_config.dart';

class TaskService {
  static const String apiUrl = AppConfig.apiUrl;

  Future<List<Task>> fetchTasks() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        print('Resposta da API: $data');
        return data.map((task) => Task.fromJson(task)).toList();
      } else {
        print('Falha na requisição: ${response.statusCode}');
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      print('Erro na requisição: $e');
      throw Exception('Failed to load tasks');
    }
  }

  // Criar tarefa
  Future<void> createTask(Task task) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': task.name}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create task');
    }
  }

  Future<void> updateTask(Task task) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${task.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': task.name}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}

class Task {
  final int id;
  final String name;

  Task({required this.id, required this.name});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'] ?? 'Unnamed Task',
    );
  }
}
