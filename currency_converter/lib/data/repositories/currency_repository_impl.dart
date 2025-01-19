import '../../domain/repositories/currency_repository.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Этот класс реализует интерфейс CurrencyRepository и получает данные из API.
class CurrencyRepositoryImpl implements CurrencyRepository {
  //final String _apikey = 'c2c5ede79013d2aab4ef9ac2';
  final String _baseUrl = 'https://api.exchangerate-api.com/v4/latest/';

  @override
  Future<double> getExchangeRate(String fromCurrency, String toCurrency) async {
    final response = await http.get(Uri.parse('$_baseUrl$fromCurrency'));


    if (response.statusCode == 200) {

      final data = json.decode(response.body);

      final rates = data['rates'] as Map<String, dynamic>;

      return rates[toCurrency] ?? 1.0; // Если курс не найден, возвращаем 1.0
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }

  //@override
  //double getAnySum(double Summ, double rate) {
    //return Summ * rate;
  //}
}