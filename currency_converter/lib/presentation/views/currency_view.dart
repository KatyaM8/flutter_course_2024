import 'package:flutter/material.dart'; // Для виджетов Flutter
import 'package:provider/provider.dart'; // Для работы с Provider
import '../view_models/currency_view_model.dart'; // ViewModel

class CurrencyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Получаем ViewModel через Provider
    final viewModel = Provider.of<CurrencyViewModel>(context);


    final amountController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Конвертер валют', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green.shade700,
        elevation: 10, // Тень
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green.shade100, Colors.white], // Градиент
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Поле ввода суммы с кнопкой
                Card(
                  elevation: 8, // Тень
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Закругленные углы
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: amountController, // Контроллер для управления вводом
                            keyboardType: TextInputType.numberWithOptions(decimal: true), // Клавиатура для чисел
                            decoration: InputDecoration(
                              labelText: 'Сумма', // Подпись поля
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10), // Закругленные углы
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Отступ между полем ввода и кнопкой
                        // Кнопка для подтверждения ввода
                        ElevatedButton(
                          onPressed: () {
                            // Считываем значение из TextField
                            final value = amountController.text;
                            final amount = double.tryParse(value) ?? 0.0; // Преобразуем введенное значение в double
                            viewModel.setAmount(amount); // Сохраняем сумму в ViewModel
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade700, // Зелёный цвет кнопки
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Закругленные углы
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Отступы внутри кнопки
                          ),
                          child: Text('Ввод', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20), // Отступ
                // Отображение введенной суммы
                Text(
                  'Введенная сумма: ${viewModel.amount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green.shade900),
                ),
                SizedBox(height: 20), // Отступ
                // Выпадающий список для выбора исходной валюты
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButton<String>(
                      value: viewModel.fromCurrency,
                      items: ['USD', 'EUR', 'GBP', 'JPY', 'RUB'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(fontSize: 16)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          viewModel.setFromCurrency(value); // Устанавливаем исходную валюту
                          viewModel.fetchExchangeRate(); // Загружаем курс обмена
                        }
                      },
                      isExpanded: true,
                      style: TextStyle(color: Colors.green.shade900),
                      dropdownColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20), // Отступ
                // Выпадающий список для выбора целевой валюты
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButton<String>(
                      value: viewModel.toCurrency,
                      items: ['USD', 'EUR', 'GBP', 'JPY', 'RUB'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(fontSize: 16)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          viewModel.setToCurrency(value); // Устанавливаем целевую валюту
                          viewModel.fetchExchangeRate(); // Загружаем курс обмена
                        }
                      },
                      isExpanded: true,
                      style: TextStyle(color: Colors.green.shade900),
                      dropdownColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20), // Отступ
                // Отображение курса обмена
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Курс обмена: ${viewModel.exchangeRate.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green.shade900),
                    ),
                  ),
                ),
                SizedBox(height: 20), // Отступ
                // Отображение конвертированной суммы
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Конвертированная сумма: ${viewModel.getConvertedAmount().toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green.shade900),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}