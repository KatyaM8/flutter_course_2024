import 'package:practice_1/features/core/data/owm/owm_api.dart';
import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/entities/search_response.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';

class WeatherRepositoryOWM implements WeatherRepository {
  final OWMApi _api;

  WeatherRepositoryOWM(this._api);

  @override
  Future<SearchResponse> getWeather(SearchQuery query) async {
    try {
      var response = await _api.getWeather(query.city);
      return SearchResponse(response.temp.toInt(), _weatherType(response.type));
    } catch (e) {
      throw Exception('Не удалось получить данные о погоде: $e');
    }
  }


  WeatherType _weatherType(String type) {
    switch (type.toLowerCase()) {
      case 'clear':
        return WeatherType.clear;
      case 'rain':
        return WeatherType.rain;
      case 'clouds':
        return WeatherType.cloudy;
      default:
        return WeatherType.other;
    }
  }
}