import 'package:flutter/material.dart';
import 'task_service.dart'; // O código TaskService e Task

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskList(),
    );
  }
}

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late Future<List<Task>> futureTasks;

  @override
  void initState() {
    super.initState();
    futureTasks = TaskService().fetchTasks();
  }

  // Função para atualizar a lista de tarefas
  void _reloadTasks() {
    setState(() {
      futureTasks = TaskService().fetchTasks();
    });
  }

  // Função para criar tarefa
  void _createTask(String name) async {
    Task newTask = Task(id: 0, name: name);
    try {
      await TaskService().createTask(newTask);
      _reloadTasks();
    } catch (e) {
      _showErrorDialog('Error creating task');
    }
  }

  // Função para editar tarefa
  void _editTask(int id, String name) async {
    Task updatedTask = Task(id: id, name: name);
    try {
      await TaskService().updateTask(updatedTask);
      _reloadTasks();
    } catch (e) {
      _showErrorDialog('Error updating task');
    }
  }

  // Função para excluir tarefa
  void _deleteTask(int id) async {
    try {
      await TaskService().deleteTask(id);
      _reloadTasks();
    } catch (e) {
      _showErrorDialog('Error deleting task');
    }
  }

  // Função para exibir diálogos de erro
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      body: FutureBuilder<List<Task>>(
        future: futureTasks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tasks available'));
          } else {
            List<Task> tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].name),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteTask(tasks[index].id),
                  ),
                  onTap: () async {
                    String? newName = await _showEditDialog(tasks[index].name);
                    if (newName != null && newName != tasks[index].name) {
                      _editTask(tasks[index].id, newName);
                    }
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? newTaskName = await _showCreateDialog();
          if (newTaskName != null) {
            _createTask(newTaskName);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Função para mostrar diálogo de criação de tarefa
  Future<String?> _showCreateDialog() async {
    TextEditingController controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create New Task'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter task name'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Create'),
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
            ),
          ],
        );
      },
    );
  }

  // Função para mostrar diálogo de edição de tarefa
  Future<String?> _showEditDialog(String currentName) async {
    TextEditingController controller = TextEditingController(text: currentName);
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter new task name'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
            ),
          ],
        );
      },
    );
  }
}
