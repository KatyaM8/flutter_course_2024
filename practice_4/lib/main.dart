import 'package:flutter/material.dart';
import 'data/repositories/task_repository_impl.dart';
import 'domain/repositories/task_repository.dart';
import 'presentation/view_models/task_view_model.dart';
import 'presentation/views/task_view.dart';
import 'package:provider/provider.dart';

void main() {
  final TaskRepository repository = TaskRepositoryImpl();
  final TaskViewModel viewModel = TaskViewModel(repository: repository);

  runApp(
    ChangeNotifierProvider(
      create: (context) => viewModel,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List',
      home: TaskView(),
    );
  }
}