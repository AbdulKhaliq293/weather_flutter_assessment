import 'package:intl/intl.dart';
import 'package:weather_app/data/DailyForecastDataModel.dart';
import 'package:weather_app/data/HourForecastModel.dart';

enum WeatherCondition {
  sunny,
  rainy,
  snowy,
  cloudy,
  windy,
  // Add other weather conditions as needed
}

class WeatherDataModel {
  final double latitude;
  final double longitude;
  final Map<String, dynamic> current;
  final Map<String, dynamic> hourly;
  final Map<String, dynamic> daily;
  WeatherCondition condition; // Add weather condition

  WeatherDataModel({
    required this.latitude,
    required this.longitude,
    required this.current,
    required this.hourly,
    required this.daily,
    required this.condition, // Include weather condition
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    // You can calculate the weather condition based on your logic
    WeatherCondition condition = calculateCondition(json['current']);
    
    return WeatherDataModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      current: json['current'],
      hourly: json['hourly'],
      daily: json['daily'],
      condition: condition, // Assign the calculated weather condition
    );
  }

static WeatherCondition calculateCondition(Map<String, dynamic> currentData) {
  double temperature = currentData['temperature_2m'];
  double rain = currentData['rain'];
  double windSpeed = currentData['windspeed_10m'];
  int humidity = currentData['relativehumidity_2m'];
  
  if (rain > 0.0) {
    return WeatherCondition.rainy;
  } else if (temperature <= 0.0) {
    return WeatherCondition.snowy;
  } else if (windSpeed > 20.0) {
    return WeatherCondition.windy;
  } else if (temperature > 20.0) {
    return WeatherCondition.sunny;
  } else if (humidity > 80) {
    return WeatherCondition.cloudy;
  } else {
    return WeatherCondition.cloudy; // Default condition
  }
}
List<DailyForecastModel> generateDailyForecast() {
  final List<DailyForecastModel> dailyForecasts = [];
  final List<dynamic> dailyMaxTemperatures = daily['temperature_2m_max'];
  final List<dynamic> dailyMinTemperatures = daily['temperature_2m_min'];
  final List<dynamic> dates = daily['time'];

  if (dailyMaxTemperatures.length < 7 || dailyMinTemperatures.length < 7 || dates.length < 7) {
    return dailyForecasts; // Not enough data for a 7-day forecast
  }

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  for (int i = 0; i < 7; i++) {
    final DateTime date = dateFormat.parse(dates[i]);

    final double maxTemp = (dailyMaxTemperatures[i] as num).toDouble();
    final double minTemp = (dailyMinTemperatures[i] as num).toDouble();

    dailyForecasts.add(DailyForecastModel(
      date: date,
      minTemp: minTemp,
      maxTemp: maxTemp,
    ));
  }

  return dailyForecasts;
}
List<HourlyForecastModel> generateHourlyForecast() {
  final List<HourlyForecastModel> hourlyForecasts = [];
  final List<dynamic> timeData = hourly['time'];
  final List<dynamic> temperatureData = hourly['temperature_2m'];
  final List<dynamic> windSpeedData = hourly['windspeed_180m'];

  if (timeData != null &&
      temperatureData != null &&
      windSpeedData != null &&
      timeData is List &&
      temperatureData is List &&
      windSpeedData is List) {
    for (int i = 0; i < timeData.length; i++) {
      final DateTime time = DateTime.parse(timeData[i]);
      final double temperature = (temperatureData[i] as num).toDouble();
      final double windSpeed = (windSpeedData[i] as num).toDouble();

      hourlyForecasts.add(HourlyForecastModel(
        time: time,
        temperature: temperature,
        windSpeed: windSpeed,
      ));
    }
  }

  return hourlyForecasts;
}
  

}
