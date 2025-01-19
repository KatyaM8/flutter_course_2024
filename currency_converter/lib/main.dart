import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/repositories/currency_repository_impl.dart';
import 'domain/repositories/currency_repository.dart';
import 'presentation/view_models/currency_view_model.dart';
import 'presentation/views/currency_view.dart';

void main() {

  final CurrencyRepository repository = CurrencyRepositoryImpl();

  final CurrencyViewModel viewModel = CurrencyViewModel(repository: repository);

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
      title: 'Конвертер валют',
      home: CurrencyView(),
      debugShowCheckedModeBanner: false,
    );
  }
}