import 'package:currency_converter/domain/repositories/currency_repository.dart';
import 'package:flutter/cupertino.dart';
//управляет состоянием и взаимодействует с репозиторием.
class CurrencyViewModel extends ChangeNotifier {
  final CurrencyRepository repository;


  double _exchangeRate = 1.0; //текущий курс обмена
  double get exchangeRate => _exchangeRate;

  String _fromCurrency = 'USD'; //исходная валюта
  String get fromCurrency => _fromCurrency;

  String _toCurrency = 'EUR';  //целевая валюта
  String get toCurrency => _toCurrency;


  double _amount = 0.0;
  double get amount => _amount;

  CurrencyViewModel({required this.repository});


  Future<void> fetchExchangeRate() async {
    _exchangeRate = await repository.getExchangeRate(_fromCurrency,toCurrency);
    notifyListeners();
  }




  //устанавливает исходную валюту
  void setFromCurrency(String currency){
    _fromCurrency = currency;
    notifyListeners();
  }

  //устанавливает целевую валюту
  void setToCurrency(String currency){
    _toCurrency = currency;
    notifyListeners();
  }


  void setAmount(double amount) {
  _amount = amount;
  notifyListeners();
  }

  double getConvertedAmount() {
  return _amount * _exchangeRate;
  }


}