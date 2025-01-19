abstract class CurrencyRepository {
  Future<double> getExchangeRate(String fromCurrency, String toCurrency);

  //double getAnySum(double Summ, double rate);

}