import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
  Future<void> removeTask(Task task);
  Future<void> toggleTaskStatus(Task task);
}