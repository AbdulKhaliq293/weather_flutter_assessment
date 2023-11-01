import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/WeatherDataModel.dart';

class WeatherRepo {
  static Future<WeatherDataModel> fetchWeatherData(double latitude, double longitude) async {
    try {
      final response = await http.get(
        Uri.https(
          'api.open-meteo.com',
          '/v1/forecast',
          {
            'latitude': latitude.toString(),
            'longitude': longitude.toString(),
            'current': 'temperature_2m,relativehumidity_2m,apparent_temperature,is_day,rain,showers,snowfall,pressure_msl,surface_pressure,windspeed_10m',
            'hourly': 'temperature_2m,relativehumidity_2m,windspeed_180m',
            'daily': 'temperature_2m_max,temperature_2m_min,sunrise,sunset',
            'timezone': 'auto',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Received weather data");

        if (data is Map<String, dynamic>) {
          final weatherData = WeatherDataModel.fromJson(data);
          return weatherData;
        } else {
          print('Error: Invalid response format');
          throw Exception('Invalid response format');
        }
      } else {
        print('Error: ${response.statusCode}');
        throw Exception('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch weather data');
    }
  }
}
