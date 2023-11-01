class HourlyForecastModel {
  final DateTime time;
  final double temperature;
  final double windSpeed;

  HourlyForecastModel({
    required this.time,
    required this.temperature,
    required this.windSpeed,
  });
}
