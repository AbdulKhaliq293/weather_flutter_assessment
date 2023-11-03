import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/data/DailyForecastDataModel.dart';
import 'package:weather_app/data/HourForecastModel.dart';
import 'package:weather_app/data/WeatherDataModel.dart';
import 'package:weather_app/repos/weather_repo.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherDataModel? cachedData; // Store the cached data here
  DateTime? lastFetchTime; // Store the time of the last data fetch
  static const int maxDataAgeInMinutes = 30; // Define the maximum age for cached data

  WeatherBloc() : super(WeatherInitialState()) {
    // Register an event handler for FetchWeatherEvent.
    on<FetchWeatherEvent>(_fetchWeatherData);
  }

  void _fetchWeatherData(FetchWeatherEvent event, Emitter<WeatherState> emit) async {
  try {
    if (cachedData != null && lastFetchTime != null) {
      final newDateTime = lastFetchTime!.add(Duration(minutes: maxDataAgeInMinutes));
      
      // Check if cached data is still valid and coordinates match
      if (DateTime.now().isBefore(newDateTime) &&
          (cachedData?.latitude == event.latitude) &&
          (cachedData?.longitude == event.longitude)) {
        // Cached data is still valid and coordinates match, emit it
        emit(WeatherDataState(data: cachedData!));
        return; // Exit the function here; no need to proceed further
      }
    }

    emit(WeatherLoadingState());

    final data = await WeatherRepo.fetchWeatherData(event.latitude, event.longitude);
    print(data.current.keys);
    print(data.hourly.keys);

    // Update the cache and last fetch time
    cachedData = data;
    lastFetchTime = DateTime.now();

    emit(WeatherDataState(data: data));
  } catch (e) {
    emit(WeatherErrorState(error: e.toString()));
  }
}
}
