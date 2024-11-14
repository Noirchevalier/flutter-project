import 'dart:convert';
import 'package:http/http.dart' as http;

class TaskService {
  static const String apiUrl =
      'http://192.168.1.5:8000/api/tasks'; // Use o seu IP local aqui

  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((task) => Task.fromJson(task)).toList();
    } else {
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

  // Editar tarefa
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

  // Excluir tarefa
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
      name: json['name'],
    );
  }
}
