import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/api_service.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _tasks = await _apiService.fetchTasks();
      print('Loaded tasks: $_tasks');
    } catch (error) {
      print('Error loading tasks: $error');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    try {
      final newTask = await _apiService.createTask(task);
      _tasks.add(newTask);
      notifyListeners();
    } catch (error) {
      print('Error adding task: $error');
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _apiService.updateTask(task);
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task;
        notifyListeners();
      }
    } catch (error) {
      print('Error updating task: $error');
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await _apiService.deleteTask(id);
      _tasks.removeWhere((task) => task.id == id);
      notifyListeners();
    } catch (error) {
      print('Error deleting task: $error');
    }
  }
}
