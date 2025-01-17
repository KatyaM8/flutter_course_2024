import 'package:practice_1/features/core/data/debug/weather_repository_debug.dart';
import 'package:practice_1/features/core/data/osm/osm_api.dart';
import 'package:practice_1/features/core/data/owm/owm_api.dart';
import 'package:practice_1/features/core/data/owm/weather_repository_owm.dart';
import 'package:practice_1/features/core/data/osm/weather_repository_osm.dart';
import 'package:practice_1/features/core/domain/entities/search_response.dart';
import 'package:practice_1/features/core/presentation/app.dart';

const String version = '0.0.1';
const String url = 'https://api.openweathermap.org/data/2.5/weather';
const String apiKey = '';

void main(List<String> arguments) {
  var app = App(WeatherRepositoryOWM(OWMApi(url,apiKey)));

  app.run();

}