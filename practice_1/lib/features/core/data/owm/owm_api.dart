import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_1/features/core/data/owm/models/owm_weather.dart';

class OWMApi {
  final String url;

  final String apiKey;

  OWMApi(this.url, this.apiKey);

  Future<OWMWeather> getWeather(String city) async {
    var response = await http.get(Uri.parse('$url/data/2.5/weather?q=$city&appid=$apiKey'));

    if (response.statusCode == 200) {
      var rJson = jsonDecode(response.body);

      if (rJson['main'] == null || rJson['weather'] == null) {
        throw Exception('Данные о погоде отсутствуют в ответе API');
      }

      return OWMWeather(rJson['main']['temp'], rJson['weather'][0]['main']);
    } else {
      throw Exception('Ошибка при получении данных: ${response.statusCode}');
    }
  }
}
