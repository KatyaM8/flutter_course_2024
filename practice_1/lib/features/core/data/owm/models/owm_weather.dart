class OWMWeather {
  final double temp;
  final String type;

  const OWMWeather(this.temp, this.type);

  @override
  String toString() {
    return 'OSMWeather{temp: $temp, type: $type}';
  }
}