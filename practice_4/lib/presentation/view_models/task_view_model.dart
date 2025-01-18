import 'package:flutter/foundation.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository repository;

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  TaskViewModel({required this.repository});

  Future<void> loadTasks() async {
    _tasks = await repository.getTasks();
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    final task = Task(id: DateTime.now().toString(), title: title);
    await repository.addTask(task);
    await loadTasks();
  }

  Future<void> removeTask(Task task) async {
    await repository.removeTask(task);
    await loadTasks();
  }

  Future<void> toggleTaskStatus(Task task) async {
    await repository.toggleTaskStatus(task);
    await loadTasks();
  }
}