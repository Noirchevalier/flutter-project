import 'package:flutter/material.dart';
import 'task_service.dart'; // Certifique-se de que esta importação está correta

void main() {
  runApp(MyApp()); // Inicia o aplicativo com MyApp
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter To-Do List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:
          TaskList(), // Aqui chamamos a TaskList para exibir a lista de tarefas
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
    _reloadTasks(); // Carrega as tarefas quando a tela é iniciada
  }

  void _reloadTasks() {
    setState(() {
      futureTasks = TaskService().fetchTasks(); // Atualiza a lista de tarefas
    });
  }

  void _createTask(String name) async {
    Task newTask = Task(id: 0, name: name);
    try {
      await TaskService().createTask(newTask);
      _reloadTasks(); // Recarrega as tarefas após criar uma nova
    } catch (e) {
      _showErrorDialog('Erro ao criar tarefa');
    }
  }

  void _editTask(int id, String name) async {
    Task updatedTask = Task(id: id, name: name);
    try {
      await TaskService().updateTask(updatedTask);
      _reloadTasks(); // Recarrega as tarefas após editar uma existente
    } catch (e) {
      _showErrorDialog('Erro ao atualizar tarefa');
    }
  }

  void _deleteTask(int id) async {
    try {
      await TaskService().deleteTask(id);
      _reloadTasks(); // Recarrega as tarefas após excluir uma
    } catch (e) {
      _showErrorDialog('Erro ao excluir tarefa');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro'),
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
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma tarefa disponível'));
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

  Future<String?> _showCreateDialog() async {
    TextEditingController controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Criar Nova Tarefa'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Digite o nome da tarefa'),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Criar'),
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
            ),
          ],
        );
      },
    );
  }

  Future<String?> _showEditDialog(String currentName) async {
    TextEditingController controller = TextEditingController(text: currentName);
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Tarefa'),
          content: TextField(
            controller: controller,
            decoration:
                InputDecoration(hintText: 'Digite o novo nome da tarefa'),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Salvar'),
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
