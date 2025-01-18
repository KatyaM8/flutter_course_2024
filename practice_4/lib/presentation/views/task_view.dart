import 'package:flutter/material.dart';
import '../view_models/task_view_model.dart';
import '../../domain/entities/task.dart';
import 'package:provider/provider.dart';


class TaskView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('ToDo List')),
      body: ListView.builder(
        itemCount: viewModel.tasks.length,
        itemBuilder: (context, index) {
          final task = viewModel.tasks[index];
          return ListTile(
            title: Text(task.title),
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (value) => viewModel.toggleTaskStatus(task),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => viewModel.removeTask(task),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    String title = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Новая задача'),
          content: TextField(
            onChanged: (value) => title = value,
            decoration: InputDecoration(hintText: 'Введите название задачи'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (title.isNotEmpty) {
                  Provider.of<TaskViewModel>(context, listen: false).addTask(title);
                }
                Navigator.of(context).pop();
              },
              child: Text('Добавить'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Отмена'),
            ),
          ],
        );
      },
    );
  }
}