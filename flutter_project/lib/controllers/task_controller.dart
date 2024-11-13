// lib/controllers/task_controller.dart
import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/api_service.dart';

class TaskController with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Task> tasks = [];

  Future<void> loadTasks() async {
    tasks = await _apiService.fetchTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    final newTask = await _apiService.createTask(task);
    tasks.add(newTask);
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    await _apiService.updateTask(task);
    int index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) tasks[index] = task;
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    await _apiService.deleteTask(id);
    tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}
